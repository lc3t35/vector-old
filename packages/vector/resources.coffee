@resources =

  dashboard:
    roles: ["guest","administrator","editor"]
    pageFields: [
      type: "welcome"
      label: "Welcome to Vector."
      options: 
        logged: 'Select a collection to start editing'
        unlogged: "Please login to start editing"
    ]

  accounts:
    children: ['pages']
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
    ,
      type: 'children'
      label: 'Pages'
      key: 'pages'
    ]

  pages:
    roles: ['administrator']
    parents: ['accounts']
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
      key: 'accounts'
      label: 'Users'
      type: 'parents'
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
    children: ['accounts']
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
      key: 'accounts'
      label: "Users"
      type: "children"
    ]
    documentActions: [
      type: "delete"
      label: "Delete document"
    ,
      type: 'duplicate'
      label: 'Create a copy'
    ]