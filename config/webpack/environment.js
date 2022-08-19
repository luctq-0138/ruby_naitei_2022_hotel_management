const { environment } = require('@rails/webpacker');

const webpack = require('webpack');
environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default'],
  })
);
environment.toWebpackConfig().merge({
  resolve: {
    alias: {
      jquery: 'jquery/src/jquery',
      'jquery-ui': 'jquery-ui-dist/jquery-ui.js',
    },
  },
});
module.exports = environment;
