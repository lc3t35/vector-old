
Handlebars.registerHelper 'renderField', (field,data,collectionName) ->
    context =
      data: data
      field: field
      collectionName: collectionName
    new Handlebars.SafeString(Template[field.type](context))

Handlebars.registerHelper 'plainValue', () ->
  if @field and @field.key and @data
    @data[@field.key]

Router.configure
  layoutTemplate: 'vectorLayout'

Template.vectorNav.helpers
  navMain: ->
    nav = []
    collectionName = Router.getData().collectionName
    for i, resource of Vector.resources
      nav.push
        label: resource.label
        url: "/#{i}"
        active: i is collectionName
    nav

Template.vectorNav.events
  'click #vectorNavSide_login': ->
    alert 'login is not yet implemented'
