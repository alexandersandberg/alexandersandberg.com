const client = require('../_11ty/utils.js').contentfulClient;

module.exports = async () => {
	return client.getEntries({
		content_type: 'lesson',
		order: 'sys.createdAt'
	}).then((response) => {
		const lessons = response.items
			.map((lesson, index) => ({
				...lesson.fields,
				source: lesson.source || "Unknown",
				id: index + 1,
				updatedAt: new Date(lesson.sys.updatedAt),
				category: lesson.fields.category.fields
			}));
		return lessons;
	})
		.catch(console.error);
};