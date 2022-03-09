const chromium = require("chrome-aws-lambda");
const fs = require("fs");
const path = require("path");
const { AssetCache } = require("@11ty/eleventy-fetch");

const config = {
	width: 1200,
	height: 630,
	type: "jpeg",
	quality: 90
}

module.exports = async (pages) => {
	console.log("[OG] Hello, let's generate some OG images!");

	const dir = path.resolve(__dirname, "../../_site/og");
	var pagesToGenerateImagesFor = [];

	if (!fs.existsSync(dir)) fs.mkdirSync(dir);

	for (const item of pages) {
		const imageName = getImageName(item.url)
		const asset = new AssetCache(getCacheIdentifier(imageName));
		if (asset.isCacheValid("1d")) {
			console.log(`[OG] Image already exists in cache for "${item.title}"`);
			const cachedImage = await asset.getCachedValue();
			if (!fs.existsSync(path.resolve(dir, imageName))) {
				console.log('[OG] Writing image from cache to site directory...');
				fs.writeFileSync(path.resolve(dir, imageName), cachedImage);
			}
			continue;
		}

		pagesToGenerateImagesFor.push(item);
	}

	if (pagesToGenerateImagesFor.length == 0) {
		console.log("[OG] All images already in cache — Bye!");
		return;
	}

	console.log("[OG] Generating images...");

	const browser = await chromium.puppeteer.launch({
		args: chromium.args,
		defaultViewport: { width: config.width, height: config.height },
		executablePath: await chromium.executablePath,
		headless: chromium.headless,
	});

	const page = await browser.newPage();

	let html = fs
		.readFileSync(path.resolve(__dirname, "./template.html"))
		.toString();

	let photo = fs.readFileSync(path.resolve(__dirname, "./photo.jpg"), {
		encoding: "base64",
	});
	html = html.replace(
		"./photo.jpg",
		`data:image/jpeg;charset=utf-8;base64,${photo}`
	);

	await page.setContent(html, {
		waitUntil: ["networkidle0", "domcontentloaded"],
	});

	await page.evaluateHandle("document.fonts.ready");

	await page.setViewport({
		width: config.width,
		height: config.height,
		deviceScaleFactor: 1,
	});

	var imageCount = 0;

	for (const item of pagesToGenerateImagesFor) {
		const { description, ogTemplate, suptitle, title, url } = item;
		const imageName = getImageName(url)

		console.log(`[OG] Generating image for "${item.title}"`);

		await reset(page);

		switch (ogTemplate) {
			case "post":
				await page.$eval('#suptitle', setHTML, suptitle);
				await page.$eval('#title-long', setHTML, title);
				break;
			case "lesson":
				await page.$eval('#suptitle', setHTML, suptitle);
				await page.$eval('#lesson', setHTML, description);
				break;
			default:
				await page.$eval('#suptitle', setHTML, suptitle);
				await page.$eval('#title', setHTML, title);
				await page.$eval('#description', setHTML, description);
				break;
		}

		const tempDir = path.resolve(__dirname, "../../_temp");
		const imagePath = `${tempDir}/${imageName}`

		await page.screenshot({
			path: imagePath,
			type: config.type,
			quality: config.quality,
			clip: { x: 0, y: 0, width: config.width, height: config.height },
		});

		const image = fs.readFileSync(imagePath);
		fs.writeFileSync(path.join(dir, imageName), image);

		const asset = new AssetCache(getCacheIdentifier(imageName));
		await asset.save(image, "buffer");

		imageCount++;
	}

	console.log(`[OG] Finished generating ${imageCount} images — See you next time!`);

	await browser.close();
};

const getImageName = (url) => `${url}.${config.type}`;
const getCacheIdentifier = (imageName) => `og_${imageName}`;
const setHTML = (e, value) => e.innerHTML = value

async function reset(page) {
	await page.$eval('#suptitle', setHTML, "");
	await page.$eval('#title', setHTML, "");
	await page.$eval('#title-long', setHTML, "");
	await page.$eval('#lesson', setHTML, "");
	await page.$eval('#description', setHTML, "");
}