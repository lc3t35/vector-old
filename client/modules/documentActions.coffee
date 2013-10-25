Template.delete.events
  'click': ->
    id = @data._id
    Meteor.vectorCollections[@collectionName].remove {_id:id}