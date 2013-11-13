
defaultResources = 
  "dashboard": {
    "roles": ["guest", "administrator", "editor"],
    "pageFields": [
      {
        "type": "welcome",
        "label": "Welcome to Vector.",
        "options": {
          "logged": "No settings.json file detected!",
          "unlogged": "No settings.json file detected!",
          "loggingIn": "No settings.json file detected!"
        }
      }
    ]
  }

defaultSettings = 
  "adminRoot": "/admin",
  "defaultDocumentTitleKey": "title",
  "defaultDocumentTitle": "New document",
  "defaultCollectionRoles": ["administrator"],
  "defaultDeleteWarning": "Click again to delete forever",
  "defaultNoTemplateWarning": "Template not found",
  "defaultLoginErrorWarning": "Login error",
  "defaultLoginSuccess": "Welcome",
  "sendVerificationEmail": false,
  "forbidClientAccountCreation": true,
  "cloudinary":{
    "cloud": "cloudName"
  }

Vector =
  resources: if Meteor.settings and Meteor.settings.public and Meteor.settings.public.vectorResources then Meteor.settings.public.vectorResources else defaultResources
  settings: if Meteor.settings and Meteor.settings.public and Meteor.settings.public.vectorSettings then Meteor.settings.public.vectorSettings else defaultSettings
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

  defaultPrivateSettings =
    "vectorSettings":{
      "cloudinary":{
        "key": "key",
        "secret": "secret",
        "cloud": "cloudName"
      }
    }

  Vector.privateSettings = if Meteor.settings and Meteor.settings.vectorSettings then Meteor.settings.vectorSettings else defaultPrivateSettings
