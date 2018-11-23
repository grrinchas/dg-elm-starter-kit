import {Elm}from './app/Main.elm';
import './main.scss';

const app = Elm.Main.init({
    node: document.getElementsByTagName('body')[0]
});

if (module.hot) {
    module.hot.accept();
}
