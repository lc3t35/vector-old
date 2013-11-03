

Router.map ->

  @route 'index',
    path: "/"
    layout: "layout"
    waitOn: ->
      Meteor.subscribe 'pages'
    data: ->
      console.log Vector.collections['pages'].find().count()
      pages: Vector.collections['pages'].find().fetch()

  Template.index.events
    'click a': (e) ->
      href = $(e.target).attr('href')
      if href.charAt(0) is '#'
        e.preventDefault()
        position = $(href).offset().top
        $('html,body').animate({
          scrollTop: position
        },500);

        