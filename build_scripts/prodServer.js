/**
 * Script for testing production build. It starts express server which serves
 * files compiled for the production.
 */
import express from 'express';
import chalk from 'chalk';
import AppConfig from '../app.confg';
import e from 'dotenv';


const env = e.config().parsed;
const port = env.PORT || 3000;
const app = express();

app.use(express.static('docs'));

// This is single page application, therefore we route all the requests to the index.html
app.get('*', (req, res) => {
    res.sendFile(AppConfig.paths.dist +"/index.html");
});

// Start express server
app.listen(port, (err) => {
    if (err) {
        console.log(chalk.red(err));
    } else {
        console.log(chalk.green(`Starting server on port ${port}`));
    }
});
