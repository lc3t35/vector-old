resources = @resources
settings = @settings

Vector =
  resources: Meteor.settings.public.vectorResources
  settings: Meteor.settings.public.vectorSettings
  collections: {}
  subscriptionId: null

  checkPermissions: (userId,collectionName,writePermission) ->
    if typeof userId is 'string'
      user = Meteor.users.findOne({_id:userId})
    else
      user = userId
    userRole = if user and user.profile and user.profile.role then user.profile.role else 'guest'
    collectionRoles = Vector.resources[collectionName].roles or Vector.settings.defaultCollectionRoles
    if writePermission is true and userRole is 'guest'
      false
    else
      collectionRoles.indexOf(userRole) >= 0

  bugs:
    refreshPublication: ->
      location.reload()

if Meteor.isServer
  Vector.privateSettings = Meteor.settings.vectorSettings
