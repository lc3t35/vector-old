Template.delete.events
  'click .active': ->
    id = @data._id
    Vector.collections[@collectionName].remove {_id:id}
  'click': (e,t)->
    $(t.find("button")).addClass 'active'