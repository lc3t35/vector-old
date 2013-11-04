Template.vectorFormPasswordChange.events
  'submit form': (e,t) ->
    e.preventDefault()
    oldPassword = t.find("#vectorFormPasswordChange_old").value
    newPassword = t.find("#vectorFormPasswordChange_new").value
    if oldPassword and newPassword
      Accounts.changePassword oldPassword, newPassword, (error,result) ->
        if error
          Notifications.send 'Wrong password'
        else
          Notifications.send 'success'
          Session.set 'forms', null
    else
      Notifications.send 'Please fill all the fields'

