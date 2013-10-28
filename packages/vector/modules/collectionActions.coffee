Template.create.events
  'click': ->
    query = {}
    collectionName = @collectionName
    query[Vector.settings.defaultDocumentTitleKey] = Vector.settings.defaultDocumentTitle
    id = Vector.collections[collectionName].insert query
    Router.go('edit',{collectionName:collectionName,_id:id})


Template.duplicate.events
  'click': ->
    model = Vector.resources[@collectionName].documentFields
    titleKey = Vector.settings.defaultDocumentTitleKey
    collectionName = @collectionName
    query = {}
    for i,field of model
      query[field.key] = @data[field.key]
    query[titleKey] = "(copy) #{query[titleKey]}"
    id = Vector.collections[@collectionName].insert query
    Router.go('edit',{collectionName:collectionName,_id:id})
