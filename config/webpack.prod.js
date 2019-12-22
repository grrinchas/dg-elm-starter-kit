/**
 * Webpack configuration for production
 */
import MiniCssExtractPlugin from 'mini-css-extract-plugin'
import merge from 'webpack-merge';
import common from './webpack.common';
import AppConfig from '../app.confg';
import TerserPlugin from 'terser-webpack-plugin';
import {CleanWebpackPlugin} from 'clean-webpack-plugin';
import {GenerateSW} from 'workbox-webpack-plugin';

export default merge.smart(common, {
    // let's include source map for easier debugging
    devtool: 'source-map',
    mode: 'production',
    entry: {main: AppConfig.entries.main,},
    optimization: {
        minimize: true,
        splitChunks: {
            chunks: 'all'
        },
        minimizer: [ new TerserPlugin(
            {
                terserOptions: {
                    ecma: 5,
                    warnings: 'verbose',
                    sourceMap: true,
                    minify: {
                        compress: {
                            pure_func: [ 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9' ]
                        }
                    }

                }
            }
        ) ]
    },
    module: {
        rules: [
            {
                test: /\.elm$/,
                use: [
                    {
                        loader: 'elm-webpack-loader',
                        options: {
                            optimize: true,
                        }
                    }

                ]
            },
        ],
    },
    output: {
        publicPath: './',
        filename: '[name].[contenthash].js',
        path: AppConfig.paths.dist,
    },
    plugins: [
        new CleanWebpackPlugin(),
        // extract css to separate file
        new MiniCssExtractPlugin({
            // Options similar to the same options in webpackOptions.output
            // both options are optional
            filename: "[name].[contenthash]css",
            chunkFilename: "[id].[contenthash]css"
        }),
        new GenerateSW({
            // these options encourage the ServiceWorkers to get in there fast
            // and not allow any straggling "old" SWs to hang around
            clientsClaim: true,
            skipWaiting: true,
        }),
    ],
});
