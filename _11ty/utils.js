require('dotenv').config();

const contentful = require('contentful');
const Image = require("@11ty/eleventy-img");

const contentfulClient = contentful.createClient({
	space: process.env.CTFL_SPACE,
	accessToken: process.env.CTFL_ACCESSTOKEN
});

const postDateFromString = (string) => new Date(string).toLocaleDateString('en-US', {
	month: 'long',
	year: 'numeric'
})

const imageShortcode = async (
	src,
	alt,
	widths = [null, 400],
	formats = ["webp", "jpeg"],
	sizes = "100vw"
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