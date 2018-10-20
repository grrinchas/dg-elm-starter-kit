/**
 * Webpack configuration for production
 */
import CleanWebpackPlugin from 'clean-webpack-plugin';
import Webpack from 'webpack';
import merge from 'webpack-merge';
import common from './webpack.common';
import AppConfig from '../app.confg';

export default merge.smart(common, {
    // let's include source map for easier debugging
    devtool: 'source-map',
    mode: 'production',
    entry: { main: AppConfig.entries.main, },

    output: {
        publicPath: './',
        path: AppConfig.paths.dist,
    },
    plugins: [
        // clean distribution folder
        new CleanWebpackPlugin(['docs']),
        // file to extract css
        new Webpack.LoaderOptionsPlugin({ debug: false, minimize: true,})
    ],
});
