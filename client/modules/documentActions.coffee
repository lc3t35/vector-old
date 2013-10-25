Template.delete.events
  'click .active': ->
    id = @data._id
    Meteor.vectorCollections[@collectionName].remove {_id:id}
  'click': (e,t)->
    $(t.find("button")).addClass 'active'