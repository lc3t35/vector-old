Meteor.vectorCollections = {}
for i,collection of Vector.resources
  if i isnt 'users'
    Vector.collections[i] = new Meteor.Collection i
    Meteor.publish i, ->
      Vector.collections[i].find()
  else
    Vector.collections['users'] = Meteor.users
    Meteor.publish 'users', ->
      console.log Meteor.users.find().fetch()
      Meteor.users.find()

Meteor.startup ->
  users = Meteor.users.find()
  if users is 0
    Accounts.createUser
      email: "super@user.com"
      password: "super"