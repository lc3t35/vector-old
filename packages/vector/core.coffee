Vector =

  collections: {}

  settings:
    defaultDocumentTitleKey: 'title'
    defaultDocumentTitle: "New document"
    defaultCollectionRoles: ["admin"]

  resources:

    dashboard:
      label: "Dashboard"
      collectionFields: [
        type: "welcome"
        label: "Welcome to vector.<br>Select a collection to start editing"
      ]

    users:
      label: "Users"
      collectionFields: [
        type: "listUsers"
        label: "Manage users"
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
      ,
        type: 'duplicate'
        label: 'Create a copy'
      ]