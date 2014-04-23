CivicSourcing.DonationFormComponent = Ember.Component.extend(

  userHasDonated: (->
    @get('fund.fundDonationId')?
  ).property('fund.fundDonationId')

  currentUserHasCard: (->
    @get('session.currentUserHasCard')
  ).property('session.currentUserHasCard')

  userIsDonating: false
  errors: null
  donation: null
  fund: null

  cancelDonation: ->
    @set('userIsDonating', false)
    @set('errors', null)
    @set('donation', null)

  actions:

    startDonationProcess: ->
      @set('userIsDonating', true)
      donation = @store.createRecord('fundDonation',
        fund: @get('fund')
      )
      @set('donation', donation)

    restartDonationProcess: ->
      @set('userIsDonating', true)
      @store.find('fundDonation', @get('fund.fundDonationId')).then (response) =>
        @set('donation', response)

    cancelDonationProcess: ->
      @cancelDonation()

    retractDonation: (event, view) ->
      donation = @get('donation')
      donation.deleteRecord()
      donation.save().then(((response) =>
        @cancelDonation()
        @set('fund.fundDonationId', null)
      ),
      ((response) ->
        @set("errors", response.errors)
      ))

    submit: (event, view) ->
      @get('donation').save().then(((response) =>
        @cancelDonation()
        @set('fund.fundDonationId', response.get("id"))
      ),
      ((response) =>
        @set("errors", response.errors)
      ))
)