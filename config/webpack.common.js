/**
 * Common webpack configuration used by development and production.
 */

const HtmlWebpackPlugin = require('html-webpack-plugin')
const AppConfig = require('../app.confg');

module.exports = {
  target: 'web',
  stats: 'errors-only',
  output: { filename: '[name].js' },
  module: {
    noParse: /\.elm$/, // we don't need to parse elm files
    rules: [
      {
        test: /\.scss$/,
        use: [{loader: "style-loader"}, {loader: "css-loader"}, {loader: "sass-loader"}]
      },
      {
        test: /\.(png|jpg)$/,
        loader: 'file-loader',
        options:
          { name: 'images/[name].[ext]' }
      }
    ]
  },
  plugins: [
    // plugin for automatically injecting bundled js file into html
    new HtmlWebpackPlugin({template: AppConfig.paths.index, inject: true,})
  ],
}
