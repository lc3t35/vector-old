Meteor.methods

  # upload to cloudinary
  upload: (blob) ->
    path = Npm.require 'path'
    Future = Npm.require('fibers/future')
    cloudinary = Npm.require 'cloudinary'
    future = new Future()
    cloudinary.config
      cloud_name: Vector.privateSettings.cloudinary.cloud
      api_key: Vector.privateSettings.cloudinary.key
      api_secret: Vector.privateSettings.cloudinary.secret
    cloudinary.uploader.upload(blob, (result) -> 
      future.return(result) )
    future.wait()

  # remove from cloudinary  
  remove: (id) ->
    cloudinary = Npm.require 'cloudinary'
    cloudinary.config
      cloud_name: Vector.privateSettings.cloudinary.cloud
      api_key: Vector.privateSettings.cloudinary.key
      api_secret: Vector.privateSettings.cloudinary.secret
    cloudinary.uploader.destroy id, (r) ->
      v = r

  # create a user
  vectorCreateUser: (email,password,profile) ->
    Accounts.createUser
      email: email
      password: password
      profile: profile

  # get documents
  # used to get data not published/related (i.e. a list of document to add as a relationship)    
  getUnrelated: (childrenCollectionName,parentCollectionName,parentIds,fields,relation) ->
    if relation is 'children'
      query = {}
      query["#{parentCollectionName}_id"] = {$ne:parentIds}
      Vector.collections[childrenCollectionName].find(query,fields:fields).fetch()
    else if relation is 'parents'
      query = {}
      query["_id"] = {$nin:parentIds}
      Vector.collections[childrenCollectionName].find(query,fields:fields).fetch()

  addChildren: (childrenCollectionName,parentCollectionName,childrenIds,parentId) ->
    query = {}
    query["#{parentCollectionName}_id"] = parentId
    Vector.collections[childrenCollectionName].update({_id: {$in:childrenIds}},{$push:query},{multi:true});

  removeChildren: (childrenCollectionName,parentCollectionName,childrenIds,parentId) ->
    query = {}
    query["#{parentCollectionName}_id"] = parentId
    Vector.collections[childrenCollectionName].update({_id: {$in:childrenIds}},{$pull:query},{multi:true})

  addParents: (childrenCollectionName,parentCollectionName,childrenId,parentIds) ->
    query = {}
    query["#{parentCollectionName}_id"] = {$each:parentIds}
    Vector.collections[childrenCollectionName].update(childrenId,{$push:query})

  removeParents: (childrenCollectionName,parentCollectionName,childrenId,parentIds) -> 
    query = {}
    query["pages_id"] = parentIds
    Vector.collections[childrenCollectionName].update(childrenId,{$pullAll:query})
