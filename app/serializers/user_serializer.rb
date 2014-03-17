class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :username, :slug

  has_one :upload
end
