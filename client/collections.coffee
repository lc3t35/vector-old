
Meteor.vectorCollections = {}
for i,collection of Meteor.vectorResources
  if i isnt 'users'
    Meteor.vectorCollections[i] = new Meteor.Collection i
  else
    Meteor.vectorCollections['users'] = Meteor.users



  # Meteor.vectorCollections.pages.insert {title:'ciao2'}