Template.create.events
  'click': ->
    Meteor.vectorCollections[@collectionName].insert {title: Meteor.vectorConfig.defaultDocumentTitle}

