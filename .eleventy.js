require("dotenv").config();

const fs = require("fs");
const hljs = require("highlight.js");
const imageShortcode = require('./_11ty/utils.js').imageShortcode;
const postDateFromString = require('./_11ty/utils.js').postDateFromString;
const fullDateFromString = require('./_11ty/utils.js').fullDateFromString;
const ogImageGenerator = require('./_11ty/ogImageGenerator/index.js');
const markdownIt = require("markdown-it");
const markdownItAnchor = require("markdown-it-anchor");
const markdownItToC = require("markdown-it-toc-done-right");
const metadata = require("./_data/metadata.js");
const pluginRss = require("@11ty/eleventy-plugin-rss");
const removeMd = require('remove-markdown');
const markdownItIB = require("markdown-it-ib");
const criticalCss = require("eleventy-critical-css");

module.exports = (eleventyConfig) => {
	eleventyConfig.addPlugin(pluginRss);
	eleventyConfig.addPlugin(criticalCss, {
		height: 1080,
		width: 1920,
		penthouse: {
			timeout: 60000
		}
	});

	eleventyConfig.addPassthroughCopy("css");
	eleventyConfig.addPassthroughCopy("img/apps/**/icon.png");
	eleventyConfig.addPassthroughCopy({ "img/og/*": "/og" });
	eleventyConfig.addPassthroughCopy({ "favicon/*": "/" });
	eleventyConfig.addPassthroughCopy("robots.txt");
	eleventyConfig.addPassthroughCopy("_redirects");

	eleventyConfig.addFilter("whereType", (projects, type) => {
		return projects.filter(project => project.type === type);
	});

	eleventyConfig.addFilter("withCategorySlug", (lessons, categorySlug) => {
		return lessons.filter(lesson => lesson.category.slug === categorySlug);
	});

	eleventyConfig.addFilter("head", (array, n) => {
		if (!Array.isArray(array) || array.length === 0) {
			return [];
		}
		if (n < 0) {
			return array.slice(n);
		}

		return array.slice(0, n);
	});

	eleventyConfig.addFilter("postDateFromString", (value) => postDateFromString(value));

	eleventyConfig.addFilter("fullDateFromString", (value) => fullDateFromString(value));

	eleventyConfig.addFilter("isNumber", (value) => typeof value == "number");

	eleventyConfig.addFilter("pad", (value, n) => value.toString().padStart(n, "0"));

	eleventyConfig.addFilter("prettyLink", (link) => {
		if (link.startsWith("/apps/")) {
			return "Learn more and download";
		}

		if (link.startsWith("http")) {
			return link.replace(/^(?:https?:\/\/)?(?:www\.)?/i, "");
		}

		return link
	});

	eleventyConfig.addFilter("removeMd", (value) => removeMd(value, { stripListLeaders: false, }));

	eleventyConfig.addFilter("newlineAsSpace", (text) => {
		return text.replaceAll("\n", " ");
	});

	eleventyConfig.addFilter("latestUpdatedAt", (items) => {
		return items.reduce((latest, item) => {
			if (item.updatedAt > latest) {
				return item.updatedAt;
			}

			return latest;
		}, new Date(0));
	});

	eleventyConfig.addShortcode("arrowForLink", (link) => {
		if (link.startsWith("http") && !link.includes(metadata.url) && !link.includes(metadata.url_live)) {
			return "↗";
		}

		if (link.startsWith("mailto:") || link.startsWith("tel:")) {
			return "↗";
		}

		return "→";
	})

	eleventyConfig.addNunjucksAsyncShortcode("image", imageShortcode);

	const md = markdownIt({
		html: true,
		breaks: true,
		linkify: true,
		typographer: false,
		highlight: (str, lang) => {
			if (lang && hljs.getLanguage(lang)) {
				try {
					return '<pre class="hljs subhead mono"><code>' +
						hljs.highlight(str, { language: lang, ignoreIllegals: false }).value +
						'</code></pre>';
				} catch (__) { }
			}

			return '<pre class="hljs subhead mono"><code>' + md.utils.escapeHtml(str) + '</code></pre>';
		}
	}).use(markdownItAnchor, {
		permalink: markdownItAnchor.permalink.headerLink({ safariReaderFix: true }),
		slugify: eleventyConfig.getFilter("slug")
	}).use(markdownItToC, {
		level: [2, 3],
	}).use(markdownItIB);

	eleventyConfig.addAsyncShortcode(
		"markdownToHtmlString",
		async (text) => {
			const imageRegex = /!\[(.*?)\]\((.*?)\)/g;
			const imageMatches = text.match(imageRegex);

			if (imageMatches) {
				for (const imageMatch of imageMatches) {

					const [, alt, src] = imageMatch.match(/!\[(.*?)\]\((.*?)\)/);
					const imageHtml = await imageShortcode(src, alt);

					text = text.replace(imageMatch, imageHtml);
				}
			}

			return md.render(text);
		}
	);

	eleventyConfig.on('eleventy.before', async () => {
		clearTemp()
	});

	eleventyConfig.on('eleventy.after', async () => {
		await ogImageGenerator(require("./_temp/og.json"));

		clearTemp()
	});

	eleventyConfig.setBrowserSyncConfig({
		callbacks: {
			ready: function (err, browserSync) {
				const content_404 = fs.readFileSync("_site/404.html");

				browserSync.addMiddleware("*", (req, res) => {
					// Provides the 404 content without redirect.
					res.writeHead(404, { "Content-Type": "text/html; charset=UTF-8" });
					res.write(content_404);
					res.end();
				});
			},
		},
		ui: false,
		ghostMode: false
	});

	return {
		templateFormats: [
			"md",
			"njk",
			"html",
		],
		markdownTemplateEngine: "njk",
		htmlTemplateEngine: "njk",
		pathPrefix: "/",
		dir: {
			input: ".",
			includes: "_includes",
			data: "_data",
			output: "_site"
		}
	};
};

function clearTemp() {
	if (fs.existsSync("./_temp")) {
		fs.rmSync("./_temp", { recursive: true });
	}
}