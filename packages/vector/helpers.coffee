
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
        label: resource.label or i
        url: "#{Vector.settings.adminRoot}/#{i}"
        name: i
  list  

Handlebars.registerHelper 'settings', ->
  Vector.settings

Handlebars.registerHelper 'renderForm', (collection,doc,collectionName) ->
  data = Router.getData()
  if data.forms
    # if Template[data.forms.type]
    new Handlebars.SafeString(Template[data.forms]())
    # else
    #   "#{Vector.settings.defaultNoTemplateWarning}: #{context}"

Template.vectorNav.events
  'click #vectorNavSide_logout': ->
    Meteor.logout()
    Router.go "#{Vector.settings.adminRoot}/"



