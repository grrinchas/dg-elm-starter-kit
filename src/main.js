import {Elm} from './app/Main.elm';
import './main.scss';


const app = Elm.Main.init({
    node: document.getElementById('elm-container'),
    flags: {}
});


if (module.hot) {
    module.hot.accept();
}

