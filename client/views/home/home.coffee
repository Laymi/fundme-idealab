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
        {
          key: 'funding',
          label: 'Funding',
          fn: (value) -> '$ '+value+',00'
        },
        {
          key: '_id',
          label: 'Fund him/her',
          fn: (value) -> Spacebars.SafeString('<a name='+value+' class="fundSomeone">Fund</a>')
        }
    ]

  settingsLoggedOut: ->
    collection: Participants.find(),
    rowsPerPage: 10,
    showFilter: true,
    fields: ['name','company','funding']

  userId: ->
    Router?.current()?.params?._id

  candidate: ->
    Session.get('possibleParticipants')

  setUser: ->
    console.log 'testasd'

Template.Home.events
  'click .userInList': (event) ->
    selectedParticipant = Participants.findOne(event.target.name)
    document.getElementById("searchInput").value = selectedParticipant.name
    document.getElementById("searchInput").name = selectedParticipant._id
    Session.set('possibleParticipants', undefined)
    console.log 'test', event.target.name

  'keyup #searchInput': (event) ->
    console.log 'modified'

  'keyup input': (event, template) ->
    if event.target.value != ''
      search = new RegExp(event.target.value, 'i');
      possibleParticipants = Participants.find("name": search).fetch()
      Session.set('possibleParticipants', possibleParticipants)
    else
      Session.set('possibleParticipants', undefined)

  'click .fundSomeone': (event) ->
    console.log 'test', document.getElementById("searchInput").name
    targetId = document.getElementById("searchInput").name
    Meteor.call 'fundUser', Meteor.userId(), targetId, document.getElementById("amountInput").value
