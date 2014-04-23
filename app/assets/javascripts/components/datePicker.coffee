CivicSourcing.DatePickerComponent = Em.Component.extend

  tagName: 'span'

  date: null

  applyDatepicker: (->
    $(".datepicker").datepicker(dateFormat: 'dd-mm-yy')
  ).on('didInsertElement')