const client = require('../_11ty/utils.js').contentfulClient;
const postDateFromString = require('../_11ty/utils.js').postDateFromString;

module.exports = async () => {
	return client.getEntries({
		content_type: 'article',
		order: 'sys.createdAt'
	}).then((response) => {
		const articles = response.items
			.map((article, index) => ({
				...article.fields,
				id: index + 1,
				createdAt: postDateFromString(article.sys.createdAt),
				updatedAt: postDateFromString(article.sys.updatedAt)
			}));
		return articles;
	})
		.catch(console.error);
};