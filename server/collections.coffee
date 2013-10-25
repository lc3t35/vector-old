
Meteor.vectorCollections = {}
for i,collection of Meteor.vectorResources
  if i isnt 'users'
    Meteor.vectorCollections[i] = new Meteor.Collection i
  else
    Meteor.vectorCollections['users'] = Meteor.users


Meteor.startup ->
  users = Meteor.users.find()
  if users is 0
    Accounts.createUser
      email: "super@user.com"
      password: "super"