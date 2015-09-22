Meteor.methods
  fundUser: (from, to, amount) ->
    check from, String
    check to, String
    check amount, String

    currentBalanceOfSender = parseInt(Meteor.users.findOne(from)?.profile?.credit)
    currentBalanceOfReceiver = parseInt(Participants.findOne(to).funding)

    newBalanceOfSender = currentBalanceOfSender-parseInt(amount)
    newBalanceOfReceiver = currentBalanceOfReceiver+parseInt(amount)

    ###
    console.log 'from', from
    console.log 'to', to

    console.log 'currentBalanceOfSender', currentBalanceOfSender
    console.log 'currentBalanceOfReceiver', currentBalanceOfReceiver

    console.log 'newBalanceOfSender', newBalanceOfSender
    console.log 'newBalanceOfReceiver', newBalanceOfReceiver
    ###

    #Execute funding
    Meteor.users.update from, $set: 'profile.credit': newBalanceOfSender
    Participants.update to, $set: funding: newBalanceOfReceiver
