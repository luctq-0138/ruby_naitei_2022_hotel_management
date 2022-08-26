import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
import 'owl.carousel';
require('jquery');
require('bootstrap');
import '../stylesheets/application';

Rails.start();
Turbolinks.start();
ActiveStorage.start();
function importAll(r) {
  r.keys().forEach(r);
}
importAll(require.context('./js', true, /\.js$/));
importAll(require.context('./js', true, /\.min\.js$/));
global.toastr = require('toastr');
toastr.options = {
  closeButton: false,
  debug: false,
  newestOnTop: false,
  progressBar: true,
  positionClass: 'toast-top-right',
  preventDuplicates: false,
  onclick: null,
  showDuration: '300',
  hideDuration: '1000',
  timeOut: '5000',
  extendedTimeOut: '1000',
  showEasing: 'swing',
  hideEasing: 'linear',
  showMethod: 'fadeIn',
  hideMethod: 'fadeOut',
};
