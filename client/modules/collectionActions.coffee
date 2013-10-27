Template.create.events
  'click': ->
    Vector.collections[@collectionName].insert {title: Meteor.vectorConfig.defaultDocumentTitle}

Template.duplicate.events
  'click': ->
    model = Meteor.vectorResources[@collectionName].documentFields
    titleKey = Meteor.vectorConfig.defaultDocumentTitleKey
    collectionName = @collectionName
    query = {}
    for i,field of model
      query[field.key] = @data[field.key]
    query[titleKey] = "(copy) #{query[titleKey]}"
    id = Vector.collections[@collectionName].insert query
    Router.go('edit',{collectionName:collectionName,_id:id})
