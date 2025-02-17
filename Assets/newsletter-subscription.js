//
//  newsletter-subscription.js
//  alexandersandberg.com
//
//  Created by Alexander Sandberg on 17.02.25.
//

document.getElementById("subscription-form").addEventListener("submit", async (e) => {
	e.preventDefault();

	const form = e.target;
	const email = form.email.value;
	const button = document.getElementById("submit-button");
	const successMessage = document.getElementById("success-message");
	const errorMessage = document.getElementById("error-message");

	button.disabled = true;
	successMessage.style.display = "none";
	errorMessage.style.display = "none";

	try {
		const response = await fetch("https://newsletter-subscription-k6spv.bunny.run/?email=" + encodeURIComponent(email), {
			method: "POST"
		});

		if (!response.ok) {
			throw new Error()
		}

		form.reset();
		successMessage.style.display = "block";
	} catch {
		errorMessage.style.display = "block";
	} finally {
		button.disabled = false;
	}
});
