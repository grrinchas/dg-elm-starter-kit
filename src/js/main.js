import {Elm} from '../elm/app/Main.elm';
import '../scss/main.scss';


const app = Elm.Main.init({
    node: document.getElementById('elm-container'),
    flags: {}
});

if ('serviceWorker' in navigator && process.env.NODE_ENV === 'production') {
    window.addEventListener('load', function() {
        navigator.serviceWorker.register('/service-worker.js');
    });
}
