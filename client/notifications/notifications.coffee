Meteor.notifications = 
  send: (message,type)->
    _type = type or 'alert'
    Session.set 'notifications', {type:type,message:message,status:"inactive"}
    Meteor.setTimeout (->
      Session.set 'notifications', {type:type,message:message,status:"active"}    
    ), 1
  reset: ->
    notifications = Session.get 'notifications'
    notifications.status = 'inactive'
    Session.set 'notifications', notifications
    Meteor.setTimeout ( ->
      Session.set 'notifications',null ), 300

Template.notifications.helpers
  notifications: ->
    Session.get 'notifications'

Template.notifications.events
  'click li': ->
    Meteor.notifications.reset()

Template.notifications.preserve ["li"]