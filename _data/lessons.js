const fs = require("fs");
const client = require('../_11ty/utils.js').contentfulClient;

module.exports = async () => {
	return client.getEntries({
		content_type: 'lesson',
		order: 'sys.createdAt',
		limit: 1000,
	}).then(({ items }) => {
		const lessonIds = JSON.parse(fs.readFileSync("./_data/lessonIds.json", "utf8"));
		const newLessonIds = [...lessonIds]

		const lessons = items
			.map((lesson) => {
				let lessonId = lesson.sys.id;
				let numberIndex = newLessonIds.findIndex(id => id === lessonId);
				var number = numberIndex !== -1 ? numberIndex + 1 : undefined;

				if (!number) {
					number = newLessonIds.length + 1;
					newLessonIds.push(lessonId);
				}

				return ({
					...lesson.fields,
					number: number,
					updatedAt: new Date(lesson.sys.updatedAt),
					category: lesson.fields.category.fields
				})
			});

		if (lessonIds.length !== newLessonIds.length) {
			fs.writeFileSync("./_data/lessonIds.json", JSON.stringify(newLessonIds, null, "\t"));
		}

		return lessons;
	})
		.catch(console.error);
};