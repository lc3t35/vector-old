

Meteor.publish 'pages', ->
	Vector.collections['pages'].find()