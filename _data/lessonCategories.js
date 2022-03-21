const client = require('../_11ty/utils.js').contentfulClient;

module.exports = async () => {
	return client.getEntries({
		content_type: 'lessonCategory',
		order: 'fields.number'
	}).then((response) => {
		const lessonCategories = response.items
			.map((category) => ({
				...category.fields,
				updatedAt: new Date(category.sys.updatedAt)
			}));
		return lessonCategories;
	})
		.catch(console.error);
};