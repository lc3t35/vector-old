resources = @resources

Vector =

  resources: resources

  settings:
    defaultDocumentTitleKey: 'title'
    defaultDocumentTitle: "New document"
    defaultCollectionRoles: ["administrator"]
    defaultDeleteWarning: 'Click again to delete forever'
    defaultNoTemplateWarning: 'Template not found'
    defaultLoginErrorWarning: 'Login error'
    defaultLoginSuccess: 'Welcome'

  collections: {}

  checkPermissions: (userId,collectionName)->
    if typeof userId is 'string'
      user = Meteor.users.findOne({_id:userId})
    else
      user = userId
    userRole = if user and user.profile and user.profile.role then user.profile.role else 'guest'
    collectionRoles = roles = Vector.resources[collectionName].roles or Vector.settings.defaultCollectionRoles
    collectionRoles.indexOf(userRole) >= 0
