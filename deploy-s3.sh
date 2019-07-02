#!/bin/bash
rm -rf public
hugo
aws s3 sync --acl "public-read" --cache-control "max-age=2592000" public/ s3://alexandersandberg.com --delete --exact-timestamps
aws cloudfront create-invalidation --distribution-id E227HHZ3ALZV14 --paths "/*"
