require('dotenv').config();
const contentful = require('contentful');

const contentfulClient = contentful.createClient({
	space: process.env.CTFL_SPACE,
	accessToken: process.env.CTFL_ACCESSTOKEN
});

const postDateFromString = (string) => new Date(string).toLocaleDateString('en-US', {
	month: 'long',
	year: 'numeric'
})

exports.contentfulClient = contentfulClient;
exports.postDateFromString = postDateFromString