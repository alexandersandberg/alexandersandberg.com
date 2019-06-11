---
title: 'Creating a website theme switcher with CSS only'
date: '2019-05-13T17:35:35+02:00'
publishDate: '2019-05-13T17:35:35+02:00'
lastmod: '2019-05-13T17:35:35+02:00'
draft: false
slug: 'theme-switcher'
keywords:
  - webdev
  - css
  - html
  - dark mode
---

[Check it out live](https://alexandersandberg.github.io/theme-switcher/) before reading if you want!

---

So called _dark mode_ layouts have been getting a lot of attention and hype lately, as more and more companies have implemented an optional design of their websites and products. I've personally been using macOS Mojave's dark mode since release, and I'm completely sold on it.

Ever since Safari released [their new @media feature `prefers-color-scheme`](https://webkit.org/blog/8475/release-notes-for-safari-technology-preview-68/), I've seen a lot of people experimenting with implementing this on their own websites. This new media feature - which is [now supported by Firefox](https://caniuse.com/#feat=prefers-color-scheme) as well - gave us a way to automatically detect the user's preference with some simple CSS.]

What most, if not all, of these solutions have in common however, is the need for a tiny bit of JavaScript to switch between themes. With [CSS Custom Properties](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties), it's only a matter of listening for a button click and setting a `dark-mode` class or data attribute on `<body>`.

_Buuuutttt…_ where's the fun in doing that when you can achieve the same thing with _CSS only_, am I right?? 🙌

## The magic revealed

The secret behind the theme switching functionality is _a simple checkbox_, CSS's *`:checked` selector*, and the lovely _subsequent-sibling combinator_, `~`.

For this to work, there are a few things we first have to do:

- Wrap our themed page content in a _container_
- Place the checkbox _before_ and _at the same level in the DOM tree_, as this container

This means we'll doing something like this:

```
<body>
  <input type="checkbox" id="theme-switch">
  <div id="page">
    <!-- Insert page content here -->
  </div>
</body>
```

To make things a bit nicer and more fun, we'll also…

- Add a clickable label to replace the not-so-fun checkbox

```
<body>
  <input type="checkbox" id="theme-switch">
  <div id="page">
    <label for="theme-switch"></label>
    <!-- Insert page content here -->
  </div>
</body>
```

The label is connected together with our checkbox by setting the label's `for` value the same as our checkbox's `id`. This means clicking the label will check the box. _"But the label is empty?"_ I hear you say. Yeah, we'll get to that.

## CSS Custom Properties

Although this would be possible without it, we'll use _CSS Custom Properties_ (aka CSS Variables) to help us with the theming. Beware of the (pretty good) [browser support](https://caniuse.com/#feat=css-variables) for these.

We'll start by defining some colors for our two themes:

```
:root {
  /* Light mode */
  --light-text: #222430;
  --light-bg: #f7f7f7;
  --light-theme: #d34a97;

  /* Dark mode */
  --dark-text: #f7f7f7;
  --dark-bg: #222430;
  --dark-theme: #bd93f9;
}
```

Next, we'll define some new variables to store our theme colors, depending on which theme is selected. By doing it this way, using our theme variables later will be a lot more convenient, especially if you've got a bunch of CSS to manage.

```
:root {
  /* Light mode */
  --light-text: #222430;
  --light-bg: #f7f7f7;
  --light-theme: #d34a97;

  /* Dark mode */
  --dark-text: #f7f7f7;
  --dark-bg: #222430;
  --dark-theme: #bd93f9;
  /* Default mode */
  --text-color: var(--light-text);
  --bg-color: var(--light-bg);
  --theme-color: var(--light-theme);
}

/* Switched mode */
.theme-switch:checked ~ #page {
  --text-color: var(--dark-text);
  --bg-color: var(--dark-bg);
  --theme-color: var(--light-theme);
}
```

The _default mode_ variables will be, you guessed it, used by default. In this case, I've set _light mode_ to be the default theme, but the _dark mode_ variables work just as well, if preferred.

And lastly, we'll find our magical _theme switching functionality_! 🦄

To explain the ruleset in plain English, it's looking for _"a checked box of class `.theme-switched`, that has a sibling with the id `page`"_. Here we redeclare our previously defined default variables with our _other theme's_ colors, in this case _dark mode_.

_And that's pretty much it!_ Now we can use our variables to create CSS rules _once_, and let the theme switching technology do the rest.

But remember, one of the things we had to do earlier for this to work was to wrap our themed page content in a container. This means that you'll only be able to use your theme variables _inside that container_:

```
/* This won't work */
body {
  background: var(--bg-color);
  color: var(--text-color);
}

/* But this will! 🕺 */
#page {
  background: var(--bg-color);
  color: var(--text-color);
}
```

## What about that empty label?

Since we decided earlier that we wanted to do something fancy ✨ with the theme switcher, now is the time. I won't go into detail how this works, as it's not required for the theme switching functionality, but let me know-in the comments or on social media-and I'll be happy to explain it to you!

First we add some new theme variables to show different switch labels depending on the active theme:

```
:root {
  /* Light mode */
  --light-switch-shadow: #373d4e;
  --light-switch-icon: "🌚";
  --light-switch-text: "dark mode?";
  …

  /* Dark mode */
  --dark-switch-shadow: #fce477;
  --dark-switch-icon: "🌝";
  --dark-switch-text: "light mode?";
  …

  /* Default mode */
  --switch-shadow-color: var(--light-switch-shadow);
  --switch-icon: var(--light-switch-icon);
  --switch-text: var(--light-switch-text);
  …
}

.theme-switch:checked ~ #page {
  --switch-shadow-color: var(--dark-switch-shadow);
  --switch-icon: var(--dark-switch-icon);
  --switch-text: var(--dark-switch-text);
  …
}
```

Next, we make our checkbox invisible while still keeping it in the DOM. `display: none;` won't suffice here, since this will put the theme switcher out of reach for visitors using keyboard navigation, and _accessibility rules_! ❤️

```
.theme-switch {
  position: absolute !important;
  height: 1px;
  width: 1px;
  overflow: hidden;
  clip: rect(1px, 1px, 1px, 1px);
}
```

Then we add our icon and text to our label with the `content` property. I threw a `text-shadow` in there as well, as you can see.

```
.switch-label::before {
  content: var(--switch-icon);
  font-size: 40px;
  transition: text-shadow .2s;
}

.switch-label::after {
  content: var(--switch-text);
  color: var(--switch-shadow-color);
}

.theme-switch:focus ~ #page .switch-label::before,
.switch-label:hover::before {
  text-shadow: 0 0 15px var(--switch-shadow-color);
}
```

I added some more stuff to make it a bit prettier, but you can find that later in the source code if you want.

## Remembering the selected theme

Now here's the deal… unless we're using Firefox\*, we unfortunately won't be able to remember which theme was active after reloading the page, with CSS only. We need a little bit of JavaScript for that:

```
// This code is only used to remember theme selection
const themeSwitch = document.querySelector('.theme-switch');
themeSwitch.checked = localStorage.getItem('switchedTheme') === 'true';

themeSwitch.addEventListener('change', function (e) {
  if(e.currentTarget.checked === true) {
    // Add item to localstorage
    localStorage.setItem('switchedTheme', 'true');
  } else {
    // Remove item if theme is switched back to normal
    localStorage.removeItem('switchedTheme');
  }
});
```

<small>\*Firefox is actually caching checkboxes' value when the page reloads, remembering our choice.</small>

However, we probably also want to remember the visitor's selected theme for when they come back another time. The above code will help us with that.

## Live preview

If you didn't click the link in the beginning of the article, here's another that will take you to the [live preview on GitHub](https://alexandersandberg.github.io/theme-switcher/). You can also find all of the source code on GitHub, in [the project's repository](https://github.com/alexandersandberg/theme-switcher).

## When two themes aren't enough

Switching between light and dark is great, but what if you want a _third_ or even _fourth_ theme? Well what if we were to replace our single checkbox with a _set of radio buttons_ instead - one for every theme?

[Say no more](https://alexandersandberg.github.io/theme-switcher/unlimited.html) (preview on GitHub).

This also requires some minor tweaking, other than adding radio buttons, that you can find in [the source code](https://github.com/alexandersandberg/theme-switcher).

However, for accessibility reasons, this method has its limitations when styling and placing the switch labels. You can read more about it in the preview linked above.

## The bottom line

As we've seen, implementing a theme switcher with help of some clever techniques and CSS Custom Properties is not that hard!

The question is, if we need to use a little bit of JavaScript _anyways_ to remember the user's selection for future visits, why don't we just add a few lines of JavaScript to implement the theme switcher as well?

Considering that a (very) small amount of people browse the web with JavaScript disabled, with this implementation they can be part of the fun too!

But most importantly, there's something really satisfying about solving problems with _CSS only_.
