/**
 * Webpack configuration for production
 */
const { CleanWebpackPlugin } = require('clean-webpack-plugin')
const Webpack = require('webpack')
const { merge } = require('webpack-merge')
const common = require('./webpack.common')
const AppConfig = require('../app.confg')

const elmPath = require('child_process')
  .spawnSync('yarn', ['bin', 'elm'], { encoding: 'utf8' })
  .stdout.trim()

module.exports = merge(common, {
  // let's include source map for easier debugging
  devtool: 'source-map',
  mode: 'production',
  entry: { main: AppConfig.entries.main },
  module: {
    rules: [
      {
        test: /\.elm$/,
        use: [
          {
            loader: 'elm-webpack-loader',
            options: {
              optimize: true,
              pathToElm: elmPath
            }
          }
        ]
      }
    ]
  },
  output: {
    publicPath: './',
    path: AppConfig.paths.dist
  },
  plugins: [
    // clean distribution folder
    new CleanWebpackPlugin(),
    new Webpack.LoaderOptionsPlugin({ debug: false, minimize: true }),
  ]
})
