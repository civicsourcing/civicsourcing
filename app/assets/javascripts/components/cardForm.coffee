CivicSourcing.CardFormComponent = Ember.Component.extend(

  errors: null

  handleResponse: (response) ->
    _this = Ember.View.views[localStorage.getItem("cardFormComponent")]
    if response.status_code is 201
      fundingInstrument = (if response.cards? then response.cards[0] else response.bank_accounts[0])
      jQuery.post "/api/v1/cards",
        uri: fundingInstrument.href
        dob_month: $("#card-dob-month").val()
        dob_year: $("#card-dob-year").val()
        postal_code: $("#card-postal-code").val()
        name: $("#card-name").val()
      , (r) ->
        if r != null && r.errors
          _this.set("errors", r.errors)
        else
          _this.get("session").setCard(true)
          _this.set("errors", null)
    else
      _this.set("errors", response.errors)

  actions:

    submitCard: (event, view) ->
      localStorage.setItem("cardFormComponent", this.elementId)
      payload =
        name: $("#card-name").val()
        number: $("#card-number").val()
        expiration_month: $("#card-ex-month").val()
        expiration_year: $("#card-ex-year").val()
        cvv: $("#card-cvv").val()
        address:
          line1: $("#card-line1").val()
          postal_code: $("#card-postal-code").val()

      balanced.card.create payload, @handleResponse
)