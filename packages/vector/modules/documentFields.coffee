
Template.text.events
  'keyup': (e,t) ->
    id = @data._id
    query = {}
    query[@field.key] = e.target.value
    Vector.collections[@collectionName].update {_id:id},{$set:query}  

Template.textarea.events
  'keyup': (e,t) ->
    id = @data._id
    query = {}
    query[@field.key] = e.target.value
    Vector.collections[@collectionName].update {_id:id},{$set:query}

Template.gallery.helpers
  filteredContent: ->
    c = Vector.settings.cloudinary.cloud
    images = []
    for i,image of this.content
      images.push
        image: image
        label: this.label
        index: this.index
        cloud: c
    images

Template.gallery.events
  # 'click .galleryImage': (e,t) ->
  #   doc = Meteor.State.get 'document'
  #   label = this.index
  #   name = this.image
  #   query = {}
  #   query[label] = name
  #   doc.update {$pull:query}
  #   Meteor.call 'remove', name.public_id
  'change .galleryInput': (e) ->
    doc = @data
    key = @field.key
    max = e.srcElement.files.length
    collection = Vector.collections[@collectionName]
    c = 0
    console.log 'start editing'
    _.each(e.srcElement.files, (file) ->
        query = {}
        reader = new FileReader()
        reader.onload = (e) ->
            console.log 'loaded'
            data = e.target.result
            Meteor.call "upload",data, (error,result) ->
                query[key] = result
                collection.update {_id:doc._id},{$push: query}
                c = c + 1
                if c is max then console.log 'finish'
        reader.onerror = (d) ->
            c = c + 1
            if c is max then Meteor.Message.release()
        reader.readAsDataURL(file)
    )