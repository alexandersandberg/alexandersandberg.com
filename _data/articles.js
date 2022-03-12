const client = require("../_11ty/utils.js").contentfulClient;

module.exports = async () => {
	return client.getEntries({
		content_type: "article",
		order: "fields.createdAt"
	}).then((response) => {
		const articles = response.items
			.map((article, index) => ({
				...article.fields,
				id: index + 1,
				createdAt: new Date(article.fields.createdAt || article.sys.createdAt).toISOString(),
				...(article.sys.updatedAt != article.sys.createdAt ? { updatedAt: article.sys.updatedAt } : {})
			}));
		return articles;
	})
		.catch(console.error);
};