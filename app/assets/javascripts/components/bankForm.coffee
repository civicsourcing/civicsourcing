CivicSourcing.BankFormComponent = Ember.Component.extend(

  bankTypes: ["checking", "savings"]
  errors: null

  handleResponse: (response) ->
    _this = Ember.View.views[localStorage.getItem("bankFormComponent")]
    if response.status_code is 201
      fundingInstrument = (if response.cards? then response.cards[0] else response.bank_accounts[0])
      jQuery.post "/api/v1/banks",
        uri: fundingInstrument.href
        dob_month: $("#ba-dob-month").val()
        dob_year: $("#ba-dob-year").val()
        postal_code: $("#ba-postal-code").val()
        name: $("#ba-name").val()
      , (r) ->
        if r != null && r.errors
          _this.set("errors", r.errors)
        else
          _this.get("session").setBank(true)
          _this.set("errors", null)
    else
      _this.set("errors", response.errors)

  actions:
    submit: (event, view) ->
      localStorage.setItem("bankFormComponent", this.elementId)
      payload =
        name: $("#ba-name").val()
        routing_number: $("#ba-routing").val()
        account_number: $("#ba-number").val()
        type: $("#ba-type").val()

      balanced.bankAccount.create payload, @handleResponse
)