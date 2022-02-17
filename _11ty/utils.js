require('dotenv').config();
const contentful = require('contentful');

const contentfulClient = contentful.createClient({
	space: process.env.CTFL_SPACE,
	accessToken: process.env.CTFL_ACCESSTOKEN
});

exports.contentfulClient = contentfulClient;