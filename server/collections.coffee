
Meteor.vectorCollections = {}
for i,collection of Meteor.vectorResources
  if i isnt 'users'
    Meteor.vectorCollections[i] = new Meteor.Collection i
    Meteor.publish i, ->
      Meteor.vectorCollections[i].find()
  else
    Meteor.vectorCollections['users'] = Meteor.users
    Meteor.publish 'users', ->
      Meteor.users.find()


Meteor.startup ->
  users = Meteor.users.find()
  if users is 0
    Accounts.createUser
      email: "super@user.com"
      password: "super"