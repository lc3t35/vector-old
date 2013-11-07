
_publish = (i) ->
  Vector.collections[i] = new Meteor.Collection i
  Meteor.publish "vector_#{i}", (docId) ->
    collections = []
    userId = this.userId
    if Vector.checkPermissions(userId,i)
      collections.push Vector.collections[i].find()   
    if docId
      for ii,collectionName of Vector.resources[i].children
        do ->
          if userId and Vector.checkPermissions(userId,collectionName)
            query = {}
            query["#{i}_id"] = docId
            collections.push Vector.collections[collectionName].find(query)
      for ii,collectionName of Vector.resources[i].parents
        do ->
          if userId and Vector.checkPermissions(userId,collectionName)
            ids = Vector.collections[i].findOne(_id:docId)["#{collectionName}_id"]
            if ids
              collections.push Vector.collections[collectionName].find({_id:{$in:ids}})
    collections

  Vector.collections[i].allow
    insert: (userId) ->
      Vector.checkPermissions(userId,i,true)
    update:(userId) ->
      Vector.checkPermissions(userId,i,true)
    remove:(userId) ->
      Vector.checkPermissions(userId,i,true)


for i,collection of Vector.resources
  if i isnt 'users'
    _publish i

  else
    Vector.collections['users'] = Meteor.users
    Meteor.publish null, ->
      fields = {username:1,profile:1,emails:1}
      userId = this.userId
      user = Meteor.users.findOne({_id:userId})
      collections = []

      if userId and Vector.checkPermissions(user._id,'users')
        collections.push Meteor.users.find({},fields)
      else if userId
        collections.push Meteor.users.find({_id:this.userId},fields)

      for ii,collectionName of Vector.resources['users'].children
        do ->
          if Vector.checkPermissions(userId,collectionName)
            query = {}
            query["users_id"] = userId
            collections.push Vector.collections[collectionName].find(query)
      for ii,collectionName of Vector.resources['users'].parents
        do ->
          if Vector.checkPermissions(userId,collectionName)
            ids = Vector.collections[i].findOne(_id:docId)["#{collectionName}_id"]
            if ids
              collections.push Vector.collections[collectionName].find({_id:{$in:ids}})
              
      collections



    Meteor.users.allow
      insert: (userId,doc) ->
        if Vector.checkPermissions(userId,'user') then true
        else if userId then doc._id is userId
      update: (userId,doc) ->
        if Vector.checkPermissions(userId,'user') then true
        else if userId then doc._id is userId
      remove: (userId,doc) ->
        if Vector.checkPermissions(userId,'user') then true
        else if userId then doc._id is userId


Accounts.config
  sendVerificationEmail: Vector.settings.sendVerificationEmail
  forbidClientAccountCreation: Vector.settings.forbidClientAccountCreation

_users = Meteor.users.find().count()
if _users is 0
  Accounts.createUser
    email: "super@user.com"
    password: "super"
    profile:
      role: 'administrator'