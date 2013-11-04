@resources =

  dashboard:
    roles: ["guest","administrator","editor"]
    pageFields: [
      type: "welcome"
      label: "Welcome to Vector."
      options: 
        logged: 'Select a collection to start editing'
        unlogged: "User: editor@editor.com, pass: editor"
    ]

  users:
    collectionFields: [
      type: "accountList"
      label: "Manage users"
    ]
    collectionActions: [
      type: 'accountCreate'
      label: 'Create account'
      options: ['administrator','editor']
    ]
    documentFields: [
      type: 'accountEmails'
      label: 'Email'
      key: 'emails'
    ,
      type: 'accountPassword'
      label: 'Password'
      key: 'password'
    ]

  pages:
    roles: ['administrator']
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
      key: 'gallery'
      label: 'Gallery'
      type: 'gallery'
    ]
    documentActions: [
      type: "delete"
      label: "Delete document"
    ,
      type: 'duplicate'
      label: 'Create a copy'
    ]

  articles:
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
    ]
    documentActions: [
      type: "delete"
      label: "Delete document"
    ,
      type: 'duplicate'
      label: 'Create a copy'
    ]