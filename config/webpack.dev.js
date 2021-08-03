/**
 * Webpack configuration for development.
 */

const { merge } = require('webpack-merge')
const common = require('./webpack.common')
const AppConfig = require('../app.confg')
const Dotenv = require('dotenv-webpack')
const e = require('dotenv')
const env = e.config().parsed

const elmPath = require('child_process')
  .spawnSync('yarn', ['bin', 'elm'], { encoding: 'utf8' })
  .stdout.trim()

module.exports = merge(common, {
  mode: 'development',
  module: {
    rules: [
      {
        test: /\.elm$/,
        use: [
          { loader: 'elm-hot-webpack-loader' },
          {
            loader: 'elm-webpack-loader',
            options: {
              pathToElm: elmPath,
              cwd: AppConfig.paths.root,
              debug: false,
              runtimeOptions: '-A128M -H128M -n8m'
            }
          }
        ]
      }

    ]
  },
  entry: {
    main: AppConfig.entries.main
  },
  output: {
    publicPath: '/',
    // Output files in the build directory in the memory
    path: AppConfig.paths.build
  },
  plugins: [
    new Dotenv()
  ],
  devServer: {
    inline: true,
    noInfo: true,
    hotOnly: true,
    contentBase: "src/assets",
    historyApiFallback: true,
    overlay: true,
    clientLogLevel: 'none',
    port: env.PORT || 3010,
  }
})
