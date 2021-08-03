/**
 * Script for building application for production.
 */

const chalk = require('chalk')
const webpack = require('webpack')
const webpackConfig = require('../config/webpack.prod')

// Webpack bundler with production configuration
const bundler = webpack(webpackConfig)

console.log(chalk.blue('Generating minimized bundle for production. This may take a while...'))

bundler.run((err, stats) => {
  if (err) {
    console.log(chalk.red(err))
    return 1
  } else if (stats.hasErrors()) {
    console.log(chalk.red(stats.compilation.errors))
    return 1
  } else {
    console.log(chalk.green('Build was successful.'))
    return 0
  }
})
