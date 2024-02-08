'use strict';

import CopyPlugin from "copy-webpack-plugin";
import * as FS from "fs";
import * as path from "path";
import TerserPlugin from "terser-webpack-plugin";
import webpack from 'webpack';
const PACKAGE = JSON.parse(FS.readFileSync('./package.json'));


PACKAGE.name = '[project_name]';

const projectURL = `[project_url]`
// const projectURL = `${githubDomain}/${PACKAGE.name}/`;

const devDomain = `[webpack_devServer_domain]:`
const devPort = `[webpack_devServer_port]`;
const devURL = `http://${devDomain}${devPort}`;

/**
 * Console types that should never be in production.
 */
const nonProdConsoles = [
    'assert',
    'count',
    'countReset',
    'debug',
    'dir',
    'dirxml',
    'profile',
    'profileEnd',
    'table',
    'time',
    'timeEnd',
    'timeLog',
    'timeStamp',
    'trace'
];

export default (env) => [
    // Javascript Bundle Config
    {
        context: path.resolve("js/module"),
        name: "bundle",
        entry: {
            app: {
                import: `./${PACKAGE.name}.js`
            }
        },
        output: {
            path: path.resolve( 'js/bundle'),
            filename: `${PACKAGE.name}.bundle.js`,
            module: true,
            libraryTarget: 'module'
        },
        optimization: {
            minimize: env.production ? true : false,
            minimizer: [
                new TerserPlugin({
                    extractComments: false,
                    terserOptions: {
                        compress: {
                            drop_console: nonProdConsoles,
                        }
                    }
                })
            ],
        },
        mode: "production",
        cache: false,
        experiments: {
            outputModule: true,
        },
        performance: env.production ? {
            hints: "warning"
        } : false,
        stats:env.production?{
            all:true,
            colors:true,
            logging:'verbose',
        }:'minimal',
    },
    // Website Config
    {
        context: path.resolve('web/src'),
        name: "web",
        entry: {
            site: {
                import: "./js/main.js"
            }
        },
        devServer: {
            static: {
                directory: './web/public',
                staticOptions: {
                    extensions: ['html'],
                }
            },
            bonjour: false,
            client: {
                logging: "none",
                overlay: true,
                progress: false,
                reconnect: false,
            },
            headers: [
                {
                    key: 'X-Webpack-Server',
                    value: 'TRUE',
                }
            ],
            magicHtml: false,
        },
        output: {
            path: path.resolve('web/public'),
            filename: "./js/main.js",
            module: true,
            libraryTarget: 'module',
            crossOriginLoading: "anonymous",
        },
        optimization: {
            minimize: env.production ? true : false,
            minimizer: [
                new TerserPlugin({
                    extractComments: false,
                    terserOptions: {
                        compress: {
                            drop_console: nonProdConsoles,
                        }
                    }
                })
            ],
        },
        mode: "production",
        plugins: [
            new webpack.EnvironmentPlugin({
                // serviceWorkerURL: env.production ? `/${PACKAGE.name}/sw.js` : (env.customServiceWorkerURL ?? '/sw.js'),
            }),
            new CopyPlugin({
                patterns: [
                    {
                        from: "./manifest.json",
                        to: "../public/manifest.json",
                        transform(content) {
                            return content
                                .toString()
                                .replace('([manifest_start_url])',
                                    (env.production)
                                        ? projectURL
                                        : (env.customManifestStartURL ?? devURL)
                                );
                        },
                    },
                    // {
                    //     from: "./sw.js",
                    //     to: "../prod/sw.js",
                    //     transform(content) {
                    //         return content
                    //             .toString()
                    //             .replace('$serviceWorkerCacheName$',
                    //                 (env.production)
                    //                     ? `${PACKAGE.name}_PWA_Cache_v1`
                    //                     : (env.customServiceWorkerCacheName ?? `${PACKAGE.name}_DEVELOPMENT_PWA_Cache_v1`)
                    //             )
                    //             .replace(
                    //                 '$serviceWorkerAppShellFiles$',
                    //                 serviceWorkerAppShellFiles.filter((fileName)=>{
                    //                     return(
                    //                         fileName[0] !== '.'
                    //                         && fileName.includes('.')
                    //                     )?fileName:null;
                    //                 }).map((fileName)=>{
                    //                     return `./${fileName}`
                    //                 })
                    //                 .join(' ')
                    //                 .concat((env.production)?` /${PACKAGE.name}/`:(env.customBaseURL?` ${env.customBaseURL}`:" /"))
                    //             );
                    //     },
                    // },
                ],
            })
        ],
        cache: false,
        experiments: {
            outputModule: true,
        },
        performance: env.production ? {
            hints: "warning"
        } : false,
        stats:env.production?{
            all:true,
            colors:true,
            logging:'verbose',
        }:'minimal',
    },
];
