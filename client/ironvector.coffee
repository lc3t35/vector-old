


# VectorController = RouteController.extend
#   before: ->
#     unless Meteor.user()
#       Router.go Router.path('login')

Router.map ->

  @route 'index',
    path: '/'
    before: ->
      for i,m of Vector.resources
        Router.go Router.path('collection',{collectionName:i})
        break

  @route 'collection',
    path: '/:collectionName'
    waitOn: ->
      Meteor.subscribe @params.collectionName
    data: ->
      model = Vector.resources[@params.collectionName]
      collectionName = @params.collectionName
      collectionFields: if model.collectionFields then model.collectionFields else []
      collectionActions: if model.collectionActions then model.collectionActions else []
      collection: Vector.collections[collectionName].find().fetch()
      collectionName: collectionName
    template: 'vectorEdit'

  @route 'edit',
    path: '/:collectionName/:_id'
    waitOn: ->
      Meteor.subscribe @params.collectionName
    before: ->
      _id = @params._id
      collectionName = @params.collectionName
      unless Vector.collections[collectionName].findOne({_id:_id})
        Router.go Router.path('collection',{collectionName:collectionName})
    data: ->
      _id = @params._id
      model = Vector.resources[@params.collectionName]
      collectionName = @params.collectionName
      collectionFields: if model.collectionFields then model.collectionFields else []
      collectionActions: if model.collectionActions then model.collectionActions else []
      collection: Vector.collections[collectionName].find().fetch()
      documentFields: if model.documentFields then model.documentFields else []
      documentActions: if model.documentActions then model.documentActions else []
      document: Vector.collections[collectionName].findOne({_id:_id})
      collectionName: collectionName
    template: 'vectorEdit'
