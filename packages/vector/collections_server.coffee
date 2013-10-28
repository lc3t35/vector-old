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
      Meteor.users.find()

Meteor.startup ->
  users = Meteor.users.find()
  if users is 0
    Accounts.createUser
      email: "super@user.com"
      password: "super"