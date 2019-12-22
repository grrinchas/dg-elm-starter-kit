

# Elm development environment

Development environment for writing Elm apps.

Based on the amazing work of [javascript-development-environment](https://github.com/coryhouse/javascript-development-environment).


## Features

1. Development Server with hot reloading.
2. Optimised bundling and minification for the production.


## Install

First let's install dependencies

* If you don't have install [node.js](https://nodejs.org/en/).
* Also you will need [yarn](https://yarnpkg.com/en/) package manager.
* And of course [elm](http://elm-lang.org/) environment.

After that

* Clone this repo in a new project:
```bash
git clone https://github.com/grrinchas/dg-elm-starter-kit my-elm-project
```

* Re-initialise as your own repo:
```bash
cd my-elm-project
rm -rf .git         # on Windows: rmdir .git /s /q
git init
```

* Install all `JavaScript` dependencies:
```bash
yarn install
```

* Install all `Elm` dependencies:
```bash
elm-package install
```

Development

* Start development server:
```bash
yarn run start
```
* Then navigate to:
```bash
http://localhost:3000
```

Production

* To bundle files for deployment:
```bash
yarn run build
```

