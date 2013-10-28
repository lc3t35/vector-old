
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

Handlebars.registerHelper 'navMain', () ->
  nav = []
  for i, resource of Vector.resources
    nav.push
      label: resource.label
      url: "/#{i}"
      name: i
  nav  

Template.vectorNav.events
  'click #vectorNavSide_login': ->
    alert 'login is not yet implemented'
