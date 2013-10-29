resources = @resources
settings = @settings

Vector =
  resources: resources
  settings: settings
  collections: {}

  checkPermissions: (userId,collectionName)->
    if typeof userId is 'string'
      user = Meteor.users.findOne({_id:userId})
    else
      user = userId
    userRole = if user and user.profile and user.profile.role then user.profile.role else 'guest'
    collectionRoles = roles = Vector.resources[collectionName].roles or Vector.settings.defaultCollectionRoles
    collectionRoles.indexOf(userRole) >= 0

if Meteor.isServer
  privateSettings = @privateSettings
  Vector.privateSettings = privateSettings
