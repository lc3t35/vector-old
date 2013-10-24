
# custom event for emitting a global save event
# need better solution!!
Template.vectorDocument.events
  'click #save': (e,t)->
    fields = t.findAll(".documentField")
    for i,field of fields
      $(field).children().eq(0).trigger 'documentSave'

# intercept global save event
Template.text.events
  'documentSave': ->
    console.log 'saved'
