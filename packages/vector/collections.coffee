for i,collection of Vector.resources
  if i isnt 'users'
    Vector.collections[i] = new Meteor.Collection i
  else
    Vector.collections['users'] = Meteor.users