
Router.configure
  layoutTemplate: 'vectorLayout'

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
      pageFields: if model.pageFields then model.pageFields else null
      collectionFields: if model.collectionFields then model.collectionFields else null
      collectionActions: if model.collectionActions then model.collectionActions else null
      collection: Vector.collections[collectionName].find().fetch()
      documentFields: if model.documentFields then model.documentFields else null
      documentActions: if model.documentActions then model.documentActions else null
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
      pageFields: if model.pageFields then model.pageFields else null
      collectionFields: if model.collectionFields then model.collectionFields else null 
      collectionActions: if model.collectionActions then model.collectionActions else null
      collection: Vector.collections[collectionName].find().fetch()
      documentFields: if model.documentFields then model.documentFields else null
      documentActions: if model.documentActions then model.documentActions else null
      document: Vector.collections[collectionName].findOne({_id:_id})
      collectionName: collectionName
    template: 'vectorEdit'