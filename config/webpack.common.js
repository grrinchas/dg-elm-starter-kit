/**
 * Common webpack configuration used by development and production.
 */
import HtmlWebpackPlugin from 'html-webpack-plugin';
import AppConfig from '../app.confg';

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
            {
                test: /\.(png|jpg)$/,
                loader:
                    'file-loader',
                options:
                    {
                        name: 'images/[name].[ext]',
                    }
                ,
            }
            ,
        ],
    },
    plugins: [
        // plugin for automatically injecting bundled js file into html
        new HtmlWebpackPlugin({template: 'src/index.html', inject: true,}),
    ],
}
;
