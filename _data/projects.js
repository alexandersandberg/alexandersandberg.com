const client = require('../_11ty/utils.js').contentfulClient;

module.exports = async () => {
	return client.getEntries({
		content_type: 'project',
		order: 'fields.number'
	}).then((response) => {
		const projects = response.items
			.map((project) => ({
				...project.fields,
			}));
		return projects;
	})
		.catch(console.error);
};