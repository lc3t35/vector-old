Template.delete.events
  'click': (e,t)->
    button = $(t.find("button"))
    if button.hasClass('active')
      id = @data._id
      Vector.collections[@collectionName].remove {_id:id}
    else
      Notifications.send @field.options or Vector.settings.defaultDeleteWarning
      $(t.find("button")).addClass 'active'
