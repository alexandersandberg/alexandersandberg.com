require("dotenv").config();

const fs = require("fs");
const hljs = require("highlight.js");
const imageShortcode = require('./_11ty/utils.js').imageShortcode;
const markdownIt = require("markdown-it");
const markdownItAnchor = require("markdown-it-anchor");
const metadata = require("./_data/metadata.json");

module.exports = (eleventyConfig) => {
	eleventyConfig.addPassthroughCopy("css");
	eleventyConfig.addPassthroughCopy("img");
	eleventyConfig.addPassthroughCopy("_redirects");

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

	eleventyConfig.addFilter("isNumber", (value) => typeof value == "number");

	eleventyConfig.addFilter("pad", (value, n) => value.toString().padStart(n, "0"));

	eleventyConfig.addFilter("prettyLink", (link) => {
		if (link.startsWith(metadata.url)) {
			return link.replace(metadata.url, "/");
		}

		if (link.startsWith("http")) {
			return link.replace(/^(?:https?:\/\/)?(?:www\.)?/i, "");
		}

		return link
	});

	eleventyConfig.addShortcode("arrowForLink", (link) => {
		if (link.startsWith("http") && !link.includes(metadata.url)) {
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
	});

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