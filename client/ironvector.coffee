
Handlebars.registerHelper 'renderField', (field,data) ->
    context =
      data: data
      field: field
    new Handlebars.SafeString(Template[field.type](context))

Handlebars.registerHelper 'plainValue', () ->
  if @field and @field.key and @data
    @data[@field.key]

Router.map ->

  @route 'dashboard',
    path: '/'
    data: Meteor.Collections
    template: 'vectorDashboard'

  @route 'collection',
    path: '/collections/:collection'
    data: ->
      model = Meteor.vectorResources[@params.collection]
      collectionFields: if model.collectionFields then model.collectionFields else []
      collection: Meteor.vectorCollections[@params.collection].find().fetch()
    template: 'vectorCollection'

  @route 'edit',
    path: '/collections/:collection/:_id'
    data: ->
      _id = @params._id
      model = Meteor.vectorResources[@params.collection]
      documentFields: if model.documentFields then model.documentFields else []
      document: Meteor.vectorCollections[@params.collection].findOne({_id:_id})
    template: 'vectorDocument'

Template.vectorNav.helpers
  navMain: ->
    nav = []
    for i, resource of Meteor.vectorResources
      nav.push
        label: resource.label
        url: "/collections/#{i}"
    nav



