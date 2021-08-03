import {Elm} from '../elm/app/Main.elm';
import '../scss/main.scss';


const app = Elm.Main.init({
    node: document.getElementById('elm-container'),
    flags: {}
});
