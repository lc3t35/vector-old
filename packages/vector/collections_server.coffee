Meteor.vectorCollections = {}
for i,collection of Vector.resources
  if i isnt 'users'
    Vector.collections[i] = new Meteor.Collection i
    Meteor.publish i, ->
      publish = false
      roles = Vector.resources[i].roles
      if @userId
        if roles    
          user = Meteor.users.findOne({_id:this.userId})
          role = if user.profile and user.profile.role then user.profile.role else []
          if roles.indexOf(role) >= 0 then publish = true
        else
          publish = true
      if publish is true
        Vector.collections[i].find()

    Vector.collections[i].allow
      insert: (userId) ->
        userId
      update:(userId) ->
        userId
      remove:(userId) ->
        userId
      fetch: ['roles']

  else
    Vector.collections['users'] = Meteor.users
    Meteor.publish 'users', ->
      fields = {username:1,profile:1,emails:1}
      publish = false
      roles = Vector.resources['users'].roles
      if @userId
        if roles    
          user = Meteor.users.findOne({_id:this.userId})
          role = if user.profile and user.profile.role then user.profile.role else []
          if roles.indexOf(role) >= 0 then publish = true
        else
          publish = true
      if publish is true
        Meteor.users.find({},fields)
      else
        Meteor.users.find({_id:this.userId},fields)
        
    Meteor.users.allow
      insert: (userId) ->
        Meteor.users.findOne({_id:userId}).profile.level >= t.permissions.edit
      update: (userId) ->
        Meteor.users.findOne({_id:userId}).profile.level >= t.permissions.view
      remove: (userId) ->
        Meteor.users.findOne({_id:userId}).profile.level >= t.permissions.view

_users = Meteor.users.find().count()
if _users is 0
  Accounts.createUser
    email: "super@user.com"
    password: "super"
    profile:
      role: 'administrator'