#!/usr/bin/sed

1a\  "private": true,
1a\  "type": "module",

s/"scripts": {/"scripts": {\n    "production": "",\n    "prod": "npm run production",/
