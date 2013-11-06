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
  # used to get data not published (i.e. a list of document to add as a relationship)    
  getDocuments: (collectionName,fields) ->
    Vector.collections[collectionName].find({},fields:fields).fetch()
