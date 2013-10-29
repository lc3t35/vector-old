@resources =

  dashboard:
    label: "Dashboard"
    roles: ['guest']
    pageFields: [
      type: "welcome"
      label: "Welcome to Vector."
      options: 
        logged: 'Select a collection to start editing'
        unlogged: 'Login to start editing'
    ]

  users:
    label: "Users"
    collectionFields: [
      type: "accountList"
      label: "Manage users"
    ]
    documentFields: [
      type: 'accountEmails'
      label: 'Email'
      key: 'emails'
    ]

  pages:
    label: "Pages"
    roles: ['administrator','editor']
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
    , 
      key: 'users'
      label: 'Related users'
      type: 'parents'
    ]
    documentActions: [
      type: "delete"
      label: "Delete document"
    ,
      type: 'duplicate'
      label: 'Create a copy'
    ]