/**
 * Webpack configuration for production
 */
import CleanWebpackPlugin from 'clean-webpack-plugin';
import MiniCssExtractPlugin from 'mini-css-extract-plugin'
import Webpack from 'webpack';
import merge from 'webpack-merge';
import common from './webpack.common';
import AppConfig from '../app.confg';

export default merge.smart(common, {
    // let's include source map for easier debugging
    devtool: 'source-map',
    mode: 'production',
    entry: {main: AppConfig.entries.main,},
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
        path: AppConfig.paths.dist,
    },
    plugins: [
        // clean distribution folder
        new CleanWebpackPlugin(['docs']),
        new Webpack.LoaderOptionsPlugin({debug: false, minimize: true,}),
        // extract css to separate file
        new MiniCssExtractPlugin({
            // Options similar to the same options in webpackOptions.output
            // both options are optional
            filename: "[name].css",
            chunkFilename: "[id].css"
        })
    ],
});
