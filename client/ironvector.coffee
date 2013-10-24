
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
  layoutTemplate: 'layout'

Router.map ->

  @route 'index',
    path: '/'
    action: ->
      for i,m of Meteor.vectorResources
        collectionName = i
        break
      @redirect "/#{collectionName}"


  @route 'collection',
    path: '/:collectionName'
    data: ->
      model = Meteor.vectorResources[@params.collectionName]
      collectionName = @params.collectionName
      collectionFields: if model.collectionFields then model.collectionFields else []
      collection: Meteor.vectorCollections[collectionName].find().fetch()
      collectionName: collectionName
    template: 'vectorCollection'

  @route 'edit',
    path: '/:collectionName/:_id'
    data: ->
      _id = @params._id
      model = Meteor.vectorResources[@params.collectionName]
      collectionName = @params.collectionName
      documentFields: if model.documentFields then model.documentFields else []
      document: Meteor.vectorCollections[collectionName].findOne({_id:_id})
      collectionName: collectionName
    template: 'vectorDocument'

Template.vectorNav.helpers
  navMain: ->
    Meteor.vectorCollections
    nav = []
    for i, resource of Meteor.vectorResources
      nav.push
        label: resource.label
        url: "/#{i}"
    nav

