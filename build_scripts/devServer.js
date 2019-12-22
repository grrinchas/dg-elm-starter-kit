/**
 * Script for Elm application development which includes hot reloading.
 * Note that bundled webpack files fill be served from the memory.
 */
import express from 'express';
import path from 'path';
import chalk from 'chalk';
import webpack from 'webpack';
import webpackDevMiddleware from 'webpack-dev-middleware';
import webpackHotMiddleware from 'webpack-hot-middleware';
import webpackConfig from '../config/webpack.dev';
import e from 'dotenv';
import AppConfig from "../app.confg";

const env = e.config().parsed;
const port = env.PORT || 3000;
const app = express();
const bundler = webpack(webpackConfig);

// Serve bundled files from the memory
app.use(webpackDevMiddleware(bundler, {
    publicPath: webpackConfig.output.publicPath,
    noInfo: true, // suppress all webpack log output
    stats: {
        colors: true,
        hash: false,
        version: false,
        timings: false,
        assets: false,
        chunks: false,
        modules: false,
        reasons: false,
        children: false,
        source: false,
        errors: true,
        errorDetails: true,
        warnings: false,
        publicPath: false
    },
}));

// Recompile files on any change
app.use(webpackHotMiddleware(bundler, {
    reload: true,
}));


// This is single page application, therefore we route all the requests to the index.html
app.get('*', (req, res) => {
    res.sendFile(AppConfig.paths.index);
});


// Start the server
app.listen(port, err => {
    if (err) {
        console.log(chalk.red(err));
    } else {
        console.log(`Server is listening on port ${port}`);
    }
});

