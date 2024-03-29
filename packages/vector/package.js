Package.describe({
  summary: "Vector cms",
  environments: ['client', 'server'] // optional. Supposedly specifies environments to load package, but i did not find any package that specifies this key.
});

Npm.depends({cloudinary: "1.0.5"});

Package.on_use(function (api, where){


  api.use('coffeescript', ['client','server']);
  api.use('accounts-password', 'server');
  api.use(['templating','stylus','handlebars','iron-router'], 'client');

  api.export('Vector');


  api.add_files([
    'core.coffee',], ['client','server']);

  api.add_files([
    'collections_server.coffee',
    'modules/methods.coffee'], 'server');

  api.add_files([
    'templates.html',
    'collections.coffee',
    'helpers.coffee',
    'controllers.coffee',
    'initializers.coffee',
    'themes/basic.styl'], 'client');

  api.add_files([
    'modules/forms.html',
    'modules/pageFields.html',
    'modules/collectionActions.html',
    'modules/collectionFields.html',
    'modules/documentActions.html',
    'modules/documentFields.html',
    'modules/forms.coffee',
    'modules/pageFields.coffee',
    'modules/collectionFields.coffee',
    'modules/collectionActions.coffee',
    'modules/documentActions.coffee',
    'modules/documentFields.coffee',], 'client');

});