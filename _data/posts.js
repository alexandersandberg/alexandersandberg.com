const client = require('../_11ty/utils.js').contentfulClient;
const postDateFromString = require('../_11ty/utils.js').postDateFromString;

module.exports = async () => {
	return client.getEntries({
		content_type: 'post',
		order: 'sys.createdAt'
	}).then((response) => {
		const posts = response.items
			.map((post, index) => ({
				...post.fields,
				id: index + 1,
				createdAt: postDateFromString(post.sys.createdAt),
				updatedAt: postDateFromString(post.sys.updatedAt)
			}));
		return posts;
	})
		.catch(console.error);
};