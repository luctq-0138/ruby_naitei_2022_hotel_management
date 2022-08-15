import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
import 'owl.carousel';
require('jquery');
require('bootstrap');

Rails.start();
Turbolinks.start();
ActiveStorage.start();
function importAll(r) {
  r.keys().forEach(r);
}
importAll(require.context('./js', true, /\.js$/));
importAll(require.context('./js', true, /\.min\.js$/));
