import {Elm} from './app/Main.elm';
import './main.scss';

const app = Elm.Main.init({
    node: document.getElementsByTagName('body')[0],
    flags: {
        mode: process.env.NODE_ENV,
        host: process.env.HOST,
        fragment: process.env.IS_FRAGMENT
    }
});

if (module.hot) {
    module.hot.accept();
}
