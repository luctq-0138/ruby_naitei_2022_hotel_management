import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
import 'owl.carousel';
require('jquery');
require('bootstrap');
function importAll(r) {
  r.keys().forEach(r);
}
importAll(require.context('./admin/js', true, /\.js$/));
importAll(require.context('./admin/js', true, /\.min\.js$/));
Rails.start();
Turbolinks.start();
ActiveStorage.start();
