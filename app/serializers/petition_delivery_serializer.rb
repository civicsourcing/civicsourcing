class PetitionDeliverySerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id

  has_one :petition, serializer: PetitionSerializer

end
