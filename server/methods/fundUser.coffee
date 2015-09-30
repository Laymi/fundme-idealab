Meteor.methods
  fundUser: (from, to, amount) ->
    check from, String
    check to, String
    check amount, String

    if amount > 0
      currentBalanceOfSender = parseInt(Meteor.users.findOne(from)?.profile?.credit)
      currentBalanceOfReceiver = parseInt(Participants.findOne(to).funding)

      newBalanceOfSender = currentBalanceOfSender-parseInt(amount)
      newBalanceOfReceiver = currentBalanceOfReceiver+parseInt(amount)
      
      if newBalanceOfSender >= 0
        #Execute funding
        Meteor.users.update from, $set: 'profile.credit': newBalanceOfSender
        Participants.update to, $set: funding: newBalanceOfReceiver
