/**
 * Common webpack configuration used by development and production.
 */
import HtmlWebpackPlugin from 'html-webpack-plugin';
import MiniCssExtractPlugin from 'mini-css-extract-plugin'
import AppConfig from '../app.confg';

export default {
    target: 'web',
    output: {filename: '[name].js',},
    module: {
        //noParse: /\.elm$/, // we don't need to parse elm files
        rules: [
            {
                test: /\.scss$/,
                use: [{loader: "style-loader"}, {loader: "css-loader"}, {loader: "sass-loader"}]
            },
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [
                    //{loader: 'elm-hot-webpack-loader'},
                    {
                        loader: 'elm-webpack-loader',
                        options: {
                            cwd: AppConfig.paths.root,
                            //forceWatch: true,
                        }
                    }

                ]
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
        new MiniCssExtractPlugin({
            // Options similar to the same options in webpackOptions.output
            // both options are optional
            filename: "[name].css",
            chunkFilename: "[id].css"
        }),
    ],
}
;
