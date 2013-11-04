
_publish = (i) ->
  Vector.collections[i] = new Meteor.Collection i
  Meteor.publish ('vector_' + i), ->
    collections = []
    if Vector.checkPermissions(this.userId,i)
      collections.push Vector.collections[i].find()      
    for ii,collectionName of Vector.resources[i].children
      if Vector.checkPermissions(this.userId,i)
        query = {}
        query["#{i}_id"] = this.userId
        collections.push Vector.collections['articles'].find(query)
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
      user = Meteor.users.findOne({_id:this.userId})
      if user and Vector.checkPermissions(user._id,'users')
        Meteor.users.find({},fields)
      else if user
        Meteor.users.find({_id:this.userId},fields)

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