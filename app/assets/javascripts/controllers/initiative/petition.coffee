CivicSourcing.InitiativePetitionController = Ember.ObjectController.extend(

  deliveryCondition: (->
    goal = @get('goal')
    deliveryDate = @get('deliveryDate')
    if deliveryDate? && deliveryDate != undefined
      deliveryDate = moment(deliveryDate).format('MMMM Do, YYYY')
    txt = ''
    txt += goal + ' signatures' if goal?
    txt += ' or ' if goal? && deliveryDate?
    txt += 'midnight ' + deliveryDate if deliveryDate?
    txt
  ).property('goal', 'deliveryDate')

  userHasSigned: (->
    @get('petitionSignatureId')?
  ).property('petitionSignatureId')

  actions:
    unsign: ->
      @store.find('petitionSignature', @get('petitionSignatureId')).then((rec) =>
        rec.deleteRecord()
        rec.save()
        @get('model').set('petitionSignatureId', null)
      )

    sign: ->
      @get('session.currentUser').then( (user) =>
        @store.createRecord('petitionSignature',
          user: user
          petition: @get('model')
        ).save().then((rec) =>
          @get('model').set('petitionSignatureId', rec.id)
        )
      )

    submit: (event, view) ->
      @get('model').save().then(((response) =>
        @get('model.initiative').reload()
      ),
      ((response) ->
        console.log(response.errors)
      ))
)