/**
 * Stores paths used by webpack
 */
const path = require('path')

module.exports = {
  paths: {
    root: path.resolve(__dirname),
    src: path.resolve(__dirname, 'src'), // dir for source file to compile
    build: path.resolve(__dirname, 'build'), // dir to output development build (in memory)
    dist: path.resolve(__dirname, 'docs'), // dir to output production build
    index: path.resolve(__dirname, 'src/index.html'),
  },
  entries: {
    main: path.resolve(__dirname, 'src/js/main.js'),
  }
}
