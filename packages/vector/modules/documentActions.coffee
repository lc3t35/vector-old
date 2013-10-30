Template.delete.events
  'click': (e,t)->
    button = $(t.find("button"))
    if button.hasClass('active')
      id = @data._id
      model = Vector.resources[@collectionName]
      # for i,field of model.documentFields
      #   if field.type is 'gallery'
      #     gallery = @data[field.key]
      #     for ii,image of gallery
      #       Meteor.call 'remove', image.public_id
      Vector.collections[@collectionName].remove {_id:id}
    else
      Notifications.send @field.options or Vector.settings.defaultDeleteWarning
      $(t.find("button")).addClass 'active'
