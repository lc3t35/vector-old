
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