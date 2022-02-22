require("dotenv").config();

const metadata = require("./_data/metadata.json");
const fs = require("fs");
const { richTextFromMarkdown } = require("@contentful/rich-text-from-markdown");
const { documentToHtmlString } = require("@contentful/rich-text-html-renderer");

module.exports = (eleventyConfig) => {
	eleventyConfig.addPassthroughCopy("assets");

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

	eleventyConfig.addAsyncShortcode(
		"markdownToHtmlString",
		async (text) => {
			const richText = await richTextFromMarkdown(text, node => {
				// TODO: All assets are of node.type "image"; identify the type some
				// other way if we want to properly render non-image assets.

				if (node.type === "image") {
					return {
						nodeType: "embedded-entry-block",
						content: [],
						data: {
							target: {
								fields: {
									url: node.url,
									alt: node.alt,
								},
								sys: {
									type: "image"
								}
							}
						}
					}
				}

				if (node.type === "code") {
					return {
						nodeType: "code",
						content: [],
						data: {
							target: {
								fields: {
									value: node.value,
								},
								sys: {
									type: "code",
									lang: node.lang
								}
							}
						}
					}
				}

				if (node.type === "html") {
					return {
						nodeType: "html",
						content: [],
						data: {
							target: {
								fields: {
									html: node.value,
								},
								sys: {
									type: "html",
								}
							}
						}
					}
				}

				return node;
			})

			const options = {
				renderNode: {
					"embedded-entry-block": ({ data: { target: { fields, sys } } }) => {
						if (sys.type === "image") {
							return `<img src="${fields.url}" alt="${fields.alt}"/>`
						}

						return null;
					},
					"code": ({ data: { target: { fields, sys } } }) => {
						if (sys.type === "code") {
							return `<code><pre>${fields.value}</pre></code>`
						}

						return null;
					},
					"html": ({ data: { target: { fields } } }) => {
						return fields.html
					}
				},
			};

			return documentToHtmlString(richText, options)
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