# http://emberjs.com/guides/models/using-the-store/

DS.ActiveModelAdapter.reopen
  namespace: 'api/v1'

CivicSourcing.Store = DS.Store.extend
  # Override the default adapter with the `DS.ActiveModelAdapter` which
  # is built to work nicely with the ActiveModel::Serializers gem.
  adapter: '-active-model'

CivicSourcing.inject('component', 'store', 'store:main')

CivicSourcing.FundSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin,
  attrs:
    fundRewards:
      embedded: "always"
)