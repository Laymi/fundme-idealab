Template.Home.helpers

  participants: ->
    participants = Participants.find().fetch()
    if participants.length then participants else null

  settings: ->
    collection: Participants.find(),
    rowsPerPage: 10,
    showFilter: true,
    fields: [
        'name',
        'company',
        'funding',
        {
          key: '_id',
          label: 'Fund him/her',
          fn: (value) -> Spacebars.SafeString('<a name='+value+' class="fundSomeone">Fund</a>')
        }
    ]

  userId: ->
    Router?.current()?.params?._id

Template.Home.events
  'click .fundSomeone': (event) ->
    console.log 'test', event.target.name
    targetId = event.target.name
    MaterializeModal.prompt
      message: 'With how much do you want to fund him/her'
      callback: (yesNo, rtn, event) ->
          if yesNo
            Meteor.call 'fundUser', Meteor.userId(), targetId, rtn
