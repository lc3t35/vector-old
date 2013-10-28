Package.describe({
  summary: "Simple notifications",
  environments: ['client'] // optional. Supposedly specifies environments to load package, but i did not find any package that specifies this key.
});

Package.on_use(function (api, where){

  api.use('coffeescript', ['client']);
  api.use(['templating','stylus','handlebars'], 'client');

  api.export('Notifications');

  api.add_files([
    'notifications.html',
    'notifications.coffee',
    'notifications.styl'], 'client');

});