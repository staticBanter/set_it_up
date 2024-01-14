#!/usr/bin/sed

s/"target": "es2016",/"target": "ESNext",/
s/"module": "commonjs",/"module": "ESNext",/
s/\/\/ "rootDir": ".\/",/"rootDir": "ts",/
s/\/\/ "outDir": ".\/",/"outDir": "js",/
s/\/\/ "removeComments": true,/"removeComments": false,/
s/\/\/ "noEmitHelpers": true,/"noEmitHelpers": true,/
s/\/\/ "noImplicitReturns": true,/"noImplicitReturns": true,/
