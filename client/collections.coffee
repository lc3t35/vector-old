

for i,collection of Meteor.vectorResources
  if i isnt 'users'
    Vector.collections[i] = new Meteor.Collection i
  else
    Vector.collections['users'] = Meteor.users
  # Meteor.vectorCollections.pages.insert {title:'ciao2'}