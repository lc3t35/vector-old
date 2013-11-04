
Handlebars.registerHelper 'renderField', (field,data,collectionName) ->
    context =
      data: data
      field: field
      collectionName: collectionName
    if Template[field.type]
      new Handlebars.SafeString(Template[field.type](context))
    else
      "#{Vector.settings.defaultNoTemplateWarning}: #{field.type}"

Handlebars.registerHelper 'plainValue', () ->
  if @field and @field.key and @data
    @data[@field.key]

Handlebars.registerHelper 'activeDocumentIs', (_id) ->
  if Router.getData() and Router.getData().document
    Router.getData().document._id is _id
  else
    false

Handlebars.registerHelper 'activeCollectionIs', (collectionName) ->
  if Router.getData() and Router.getData().collectionName
    Router.getData().collectionName is collectionName
  else
    false

Handlebars.registerHelper 'collectionList', ->
  list = []
  for i, resource of Vector.resources
    if Vector.checkPermissions(Meteor.user(),i)
      list.push
        label: resource.label or ( i.charAt(0).toUpperCase() + i.slice(1) )
        url: "#{Vector.settings.adminRoot}/#{i}"
        name: i
  list  

Handlebars.registerHelper 'settings', ->
  Vector.settings


Meteor.startup ->
  Session.set 'forms', null

Template.vectorNav.events
  'click #vectorNavSide_logout': ->
    Meteor.logout()
    Router.go "#{Vector.settings.adminRoot}/"
  # 'click #vectorNavSide_logoin': ->
  #   Router.setData({forms:'ciao'})


Template.currentForm.helpers
  form: ->
    data = Session.get 'forms'
    if data
      new Handlebars.SafeString(Template[data]())

Template.currentForm.events
  'click .vectorFormCancel': (e) ->
    e.preventDefault()
    Session.set 'forms', null



