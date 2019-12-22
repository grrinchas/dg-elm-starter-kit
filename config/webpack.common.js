/**
 * Common webpack configuration used by development and production.
 */
import HtmlWebpackPlugin from 'html-webpack-plugin';
import AppConfig from '../app.confg';
import CopyPlugin from 'copy-webpack-plugin';

export default {
    target: 'web',
    output: {filename: '[name].js',},
    module: {
        noParse: /\.elm$/, // we don't need to parse elm files
        rules: [
            {
                test: /\.scss$/,
                use: [{loader: "style-loader"}, {loader: "css-loader"}, {loader: "sass-loader"}]
            },
        ],
    },
    plugins: [
        // plugin for automatically injecting bundled js file into html
        new HtmlWebpackPlugin({template: AppConfig.paths.index, inject: true,}),
        new CopyPlugin([
            { from: "public" }
        ]),
    ],
}
;
