Meteor.methods
  populateDatabase: (N = 0) ->
    check N, Number
    for i in [0...N]
      newParticipant =
        "_id": Random.id()
        "name" : Math.random().toString(36).substring(7) + ' ' + Math.random().toString(36).substring(7)
        "company" : Math.random().toString(36).substring(10) + ' GmbH'
        "funding" : 0
        "secureCode" : Math.random().toString(10).substring(5)
        "createdAt": new Date

      Participants.insert newParticipant

  createExampleUser: ->
    Accounts.createUser
      email: 'test1337@test.test'
      password: 'test1234'

    console.log 'test@test.de', 'test1234'
