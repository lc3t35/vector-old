Package.describe({
  summary: "Vector cms",
  environments: ['client', 'server'] // optional. Supposedly specifies environments to load package, but i did not find any package that specifies this key.
});

Package.on_use(function (api, where){

  api.use('coffeescript', ['client','server']);
  api.use('accounts-password', 'server');
  api.use(['templating','stylus','handlebars','iron-router'], 'client');

  api.export('Vector');

  api.add_files([
    'core.coffee',
    'helpers.coffee',
    'collections.coffee',
    'templates.html'], 'client');
});