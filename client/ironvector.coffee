
Handlebars.registerHelper 'renderField', (field,data,collectionName) ->
    context =
      data: data
      field: field
      collectionName: collectionName
    new Handlebars.SafeString(Template[field.type](context))

Handlebars.registerHelper 'plainValue', () ->
  if @field and @field.key and @data
    @data[@field.key]

Router.configure
  layoutTemplate: 'vectorLayout'

# VectorController = RouteController.extend
#   before: ->
#     unless Meteor.user()
#       Router.go Router.path('login')

Router.map ->

  @route 'index',
    path: '/'
    before: ->
      for i,m of Meteor.vectorResources
        Router.go Router.path('collection',{collectionName:i})
        break

  @route 'collection',
    path: '/:collectionName'
    waitOn: ->
      Meteor.subscribe @params.collectionName
    data: ->
      model = Meteor.vectorResources[@params.collectionName]
      collectionName = @params.collectionName
      collectionFields: if model.collectionFields then model.collectionFields else []
      collectionActions: if model.collectionActions then model.collectionActions else []
      collection: Meteor.vectorCollections[collectionName].find().fetch()
      collectionName: collectionName
    template: 'vectorEdit'

  @route 'edit',
    path: '/:collectionName/:_id'
    waitOn: ->
      Meteor.subscribe @params.collectionName
    before: ->
      _id = @params._id
      collectionName = @params.collectionName
      unless Meteor.vectorCollections[collectionName].findOne({_id:_id})
        Router.go Router.path('collection',{collectionName:collectionName})
    data: ->
      _id = @params._id
      model = Meteor.vectorResources[@params.collectionName]
      collectionName = @params.collectionName
      collectionFields: if model.collectionFields then model.collectionFields else []
      collectionActions: if model.collectionActions then model.collectionActions else []
      collection: Meteor.vectorCollections[collectionName].find().fetch()
      documentFields: if model.documentFields then model.documentFields else []
      documentActions: if model.documentActions then model.documentActions else []
      document: Meteor.vectorCollections[collectionName].findOne({_id:_id})
      collectionName: collectionName
    template: 'vectorEdit'

Template.vectorNav.helpers
  navMain: ->
    Meteor.vectorCollections
    nav = []
    collectionName = Router.getData().collectionName
    for i, resource of Meteor.vectorResources
      nav.push
        label: resource.label
        url: "/#{i}"
        active: i is collectionName
    nav

Template.vectorNav.events
  'click #vectorNavSide_login': ->
    alert 'login is not yet implemented'
