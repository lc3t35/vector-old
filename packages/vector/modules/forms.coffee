Template.vectorLogin.events
  'submit form': (e,t) ->
    e.preventDefault()
    email = t.find('#vectorLoginEmail').value
    password = t.find('#vectorLoginPassword').value
    Meteor.loginWithPassword email, password, (error) ->
      if e
        Notifications.send 'Login error'