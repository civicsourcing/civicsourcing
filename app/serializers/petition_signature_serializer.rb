class PetitionSignatureSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :comment

  has_one :petition, serializer: PetitionSerializer
  has_one :user, serializer: UserSerializer

end
