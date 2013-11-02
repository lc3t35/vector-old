connect = Npm.require('connect')

RoutePolicy.declare('/lib', 'network')

WebApp.connectHandlers
  .use(connect.bodyParser())
  .use('/themes', connect.static("/themes"));