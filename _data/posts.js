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
				createdAt: post.sys.createdAt,
				...(post.sys.updatedAt != post.sys.createdAt ? { updatedAt: post.sys.updatedAt } : {})
			}));
		return posts;
	})
		.catch(console.error);
};