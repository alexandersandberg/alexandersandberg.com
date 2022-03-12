require('dotenv').config();

const contentful = require('contentful');
const Image = require("@11ty/eleventy-img");

const contentfulClient = contentful.createClient({
	space: process.env.CTFL_SPACE,
	accessToken: process.env.CTFL_ACCESSTOKEN
});

const postDateFromString = (string) => {
	if (!string) return "";

	return new Date(string).toLocaleDateString('en-US', {
		month: 'long',
		year: 'numeric'
	});
}

const pageMaxWidth = 900; // Should be same as --page-max-width in main.css

const imageShortcode = async (
	src,
	alt,
	widths = [pageMaxWidth, pageMaxWidth * 2, pageMaxWidth * 3, null], // 1x, 2x, 3x, rest
	sizes = `${pageMaxWidth}px`,
	formats = ["webp", "jpeg"],
) => {
	const parsedSrc = src.startsWith("//") ? `https:${src}` : src;
	const metadata = await Image(parsedSrc, {
		widths,
		formats,
		outputDir: "./_site/img/",
	});

	const imageAttributes = {
		alt,
		sizes,
		loading: "lazy",
		decoding: "async",
	};

	return Image.generateHTML(metadata, imageAttributes);
}

exports.contentfulClient = contentfulClient;
exports.postDateFromString = postDateFromString
exports.imageShortcode = imageShortcode