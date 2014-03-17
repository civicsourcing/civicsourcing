CivicSourcing.Vote = DS.Model.extend(

  voter: DS.belongsTo 'amorphous',
    polymorphic: true
  event: DS.belongsTo "event"
  value: DS.attr()
)