
import Elm from './example/elm/Main.elm';
import './example/scss/main.scss';
import './example/images/ipsum_image.png';

const mountNode = document.getElementById('app');
const app = Elm.Main.embed(mountNode);

if (module.hot) {
    module.hot.accept();
}
