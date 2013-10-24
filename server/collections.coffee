
Meteor.vectorCollections = {}
for i,collection of Meteor.vectorResources
  Meteor.vectorCollections[i] = new Meteor.Collection i