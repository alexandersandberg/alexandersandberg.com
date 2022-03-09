const chromium = require("chrome-aws-lambda");
const fs = require("fs");
const path = require("path");

const config = {
	width: 1200,
	height: 630,
	type: "jpeg",
	quality: 90
}

module.exports = async (pages) => {
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

	const dir = path.resolve(__dirname, "../../_site/og");
	if (!fs.existsSync(dir)) fs.mkdirSync(dir);

	var imageCount = 0;

	for (const item of pages) {
		const { description, ogTemplate, suptitle, title, url } = item;

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

		await page.screenshot({
			path: `${dir}/${url}.${config.type}`,
			type: config.type,
			quality: config.quality,
			clip: { x: 0, y: 0, width: config.width, height: config.height },
		});

		imageCount++;
	}

	console.log(`[OG] Finished generating ${imageCount} images.`);

	await browser.close();
};

const setHTML = (e, value) => e.innerHTML = value

async function reset(page) {
	await page.$eval('#suptitle', setHTML, "");
	await page.$eval('#title', setHTML, "");
	await page.$eval('#title-long', setHTML, "");
	await page.$eval('#lesson', setHTML, "");
	await page.$eval('#description', setHTML, "");
}