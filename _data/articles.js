const client = require('../_11ty/utils.js').contentfulClient;

module.exports = async () => {
	return client.getEntries({
		content_type: 'article',
		order: 'sys.createdAt'
	}).then((response) => {
		const articles = response.items
			.map((lesson, index) => ({
				...lesson.fields,
				id: index + 1,
			}));
		return articles;
	})
		.catch(console.error);
};