@Participants = new Mongo.Collection 'participants'

if Meteor.isServer
  # XXX Temporary permission
  Participants.allow
    insert: -> true
