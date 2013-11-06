adminRoot = Vector.settings.adminRoot

Router.map ->

  @route 'vectorIndex',
    path: "#{adminRoot}"
    before: ->
      for i,m of Vector.resources
        Router.go Router.path('vectorCollection',{collectionName:i})
        break

  @route 'vectorCollection',
    path: "#{adminRoot}/:collectionName"
    layoutTemplate: 'vectorLayout'
    waitOn: ->
      Meteor.subscribe "vector_" + @params.collectionName
    data: ->
      model = Vector.resources[@params.collectionName]
      collectionName = @params.collectionName
      pageFields: if model.pageFields then model.pageFields else null
      collectionFields: if model.collectionFields then model.collectionFields else null
      collectionActions: if model.collectionActions then model.collectionActions else null
      collection: Vector.collections[collectionName].find({},sort: {created_at: -1}).fetch()
      documentFields: if model.documentFields then model.documentFields else null
      documentActions: if model.documentActions then model.documentActions else null
      collectionName: collectionName
    template: 'vectorEdit'

  @route 'vectorEdit',
    path: "#{adminRoot}/:collectionName/:_id"
    layoutTemplate: 'vectorLayout'
    waitOn: ->
      Meteor.subscribe "vector_" + @params.collectionName, @params._id
    before: ->
      _id = @params._id
      collectionName = @params.collectionName
      unless Vector.collections[collectionName].findOne({_id:_id})
        Router.go Router.path('vectorCollection',{collectionName:collectionName})
    data: ->
      _id = @params._id
      model = Vector.resources[@params.collectionName]
      collectionName = @params.collectionName
      pageFields: if model.pageFields then model.pageFields else null
      collectionFields: if model.collectionFields then model.collectionFields else null 
      collectionActions: if model.collectionActions then model.collectionActions else null
      collection: Vector.collections[collectionName].find({},sort: {created_at: -1}).fetch()
      documentFields: if model.documentFields then model.documentFields else null
      documentActions: if model.documentActions then model.documentActions else null
      document: Vector.collections[collectionName].findOne({_id:_id})
      collectionName: collectionName
    template: 'vectorEdit'