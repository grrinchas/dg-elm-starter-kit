
const fs = require('fs')
const chalk = require('chalk')

fs.readFile('.env.sample', (err, data) => {
  if (err) { console.log(chalk.red(err)) } else {
    if (!fs.existsSync('.env')) {
      fs.writeFile('.env', data, err => {
        if (err) { console.log(chalk.red(err)) } else {
          console.log(chalk.green('Successfully copied .env.sample to .env'))
        }
      })
    }
  }
})
