---
title: "Default to tabs instead of spaces for an 'accessible first' environment"
slug: "tabs-for-accessibility"
date: "2019-07-11T15:09:04+02:00"
publishDate: "2019-07-11T15:09:04+02:00"
lastmod: "2019-07-11T15:09:04+02:00"
draft: false
summarize: true
keywords:
    - webdev
    - productivity
    - accessibility
    - a11y
    - inclusive design
---

I'm sure you've come across the age-old, opinion based debate of 'Tabs vs. Spaces' for *indentation* before. It has been going since forever, and there seems to be valid reasons for both sides:

**Tabs...**

- smaller files because it's just 1 character
- that's what they're used for
- you can customize your own identation width (👈 keep this one in mind)

**Spaces...**

- to avoid problems in whitespace-sensitive environments
- because you know what you'll get, and consistency is key

But, there's more to this than just personal preferences. [u/ChaseMoskal](https://www.reddit.com/user/ChaseMoskal) recently posted a very insightful and eye-opening post on Reddit with the title ["Nobody talks about the real reason to use Tabs over Spaces"](https://www.reddit.com/r/javascript/comments/c8drjo/nobody_talks_about_the_real_reason_to_use_tabs/).

<!--more-->

## The one real reason to use tabs over spaces
In his post, Chase explains his own experience of using spaces at his workplace, and the negative effects it had on co-workers with visual impairment.

One of his co-workers uses a tab-width of `1`, to avoid huge indentations when using a large font-size.

Another co-worked of his is using a tab-width of `8`, because that works best for his situation with a wide monitor.

> I see people saying "tabs lets us customize our tab-width", as though we do this "for fun" — Chase

By using tabs in our projects, we allow these kinds of customizations that are *essential* for people with visual impairment. Custom tab-widths might seem like an unnecessary thing to most, but some people rely on it—and we *can not* ignore that.

## Accessibile first
We simply can't "convert" everyone to one side or the other, there's no question about it. Everyone has their own preferences, and we should celebrate that freedom—that we have the ability to make our own choices.

But with that said, we should also make sure to include *everyone*, and that means respecting and using accessible tools like the Tab-character.

Much like designing for 'mobile first'—making sure everyone, no matter what device, has a great experience with your product—we should create an '**accessible first**' environment, by making sure that everyone has the same ability to work, whether it's at the workplace or on an open-source project.

I thought Chase put it perfectly when he said in his post that *"...there's just no counter-argument that even comes close to outweighing the accessibility needs of valued coworkers"*.

## Conclusion — Accessible first, personal preference second
By defaulting to tabs, we make sure that everyone has a great experience working together with others, no matter their own abilities.

And I you prefer spaces, feel free to use an auto formatting tool that converts tabs to spaces when opening a file (all modern editors have these). Just make sure that the spaces get converted back to tabs before anyone else has to work on your code.

> Only by making sure everyone has the same capability can we maximize our combined potential ❤️