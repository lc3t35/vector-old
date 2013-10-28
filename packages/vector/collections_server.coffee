Meteor.vectorCollections = {}
for i,collection of Vector.resources
  if i isnt 'users'
    Vector.collections[i] = new Meteor.Collection i
    Meteor.publish i, (userId)->
      if @userId
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
      if @userId
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

Meteor.startup ->
  users = Meteor.users.find()
  if users is 0
    Accounts.createUser
      email: "super@user.com"
      password: "super"
