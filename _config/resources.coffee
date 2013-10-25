Meteor.vectorResources =

  dashboard:
    label: "Dashboard"
    collectionFields: [
      type: "welcome"
      label: "Welcome to vector.<br>Select a collection to start editing"
    ]
  pages:
    label: "Pages"
    collectionFields: [
      label: "Manage pages"
      type: "list"
    ]
    collectionActions: [
      label: 'Create new'
      type: 'create'
    ]
    documentFields: [
      key: 'title'
      label: "Title"
      type: "text"
    ,
      key: 'description'
      label: "Description"
      type: "textarea"
    ]
    documentActions: [
      type: "delete"
      label: "Delete document"
    ]
    
  articles:
    label: "Articles"
    collectionFields: [
      label: "Manage articles"
      type: "list"
    ]
    collectionActions: []
    documentFields: [
      key: 'title'
      label: "Title"
      type: "text"
    ,
      key: 'description'
      label: "Description"
      type: "textarea"
    ]
    documentActions: []