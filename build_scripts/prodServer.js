/**
 * Script for testing production build. It starts express server which serves
 * files compiled for the production.
 */
const chalk = require('chalk')
const express = require('express')
const e = require('dotenv')
const AppConfig = require('../app.confg')
const env = e.config().parsed
const port = process.env.PORT || env.PORT
const app = express()

app.use(express.static(AppConfig.paths.dist))

// This is single page application, therefore we route all the requests to the index.html
app.get('*', (req, res) => {
  res.sendFile(`${AppConfig.paths.dist}/index.html`)
})

// Start express server
app.listen(port, (err) => {
  if (err) {
    console.log(chalk.red(err))
  } else {
    console.log(chalk.green(`Starting server on port ${port}`))
  }
})
