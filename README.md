# alexandersandberg.com

[![Netlify Status](https://api.netlify.com/api/v1/badges/b4d850f4-f6da-46e0-8299-33656adb0394/deploy-status)](https://app.netlify.com/sites/alexandersandberg/deploys)

This is the source code for my personal website, where I occasionally share some interesting stuff with the world.

The website is built with [Hugo](http://gohugo.io) and hosted using [Netlify](https://www.netlify.com/).

## Install hugo
```
brew install hugo
```

## Run website locally
```
hugo server
```

## Create a new post
```
hugo new [-k <archetype>] <path>
```

examples:
```
# books post:
hugo new -k books posts/book-title.md

# other post:
hugo new posts/post-name.md

# page:
hugo new pages/page-title.md
```

## Publish site
Personally, I've connected the project's repo to Netlify and simply push to the repo to publish new updates.

If you want to deploy the site yourself you can use the button below.


[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/alexandersandberg/alexandersandberg.com)