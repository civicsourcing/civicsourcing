class BadgeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :points
end
