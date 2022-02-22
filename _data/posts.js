const client = require('../_11ty/utils.js').contentfulClient;

module.exports = async () => {
	return client.getEntries({
		content_type: 'post',
		order: 'sys.createdAt'
	}).then((response) => {
		const posts = response.items
			.map((post, index) => ({
				...post.fields,
				id: index + 1,
			}));
		return posts;
	})
		.catch(console.error);
};