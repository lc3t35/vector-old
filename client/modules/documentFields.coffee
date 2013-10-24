Template.text.events
  'keyup': (e,t) ->
    id = @data._id
    query = {}
    query[@field.key] = e.target.value
    Meteor.vectorCollections[@collectionName].update {_id:id},{$set:query}