class PetitionSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :title, :body, :goal, :delivery_date, :deliver_to,
    :petition_signatures_count, :petition_signature_id

  has_one :initiative, serializer: InitiativeSerializer

  def petition_signature_id
    PetitionSignature.find_by(user: scope, petition: object).try(:id)
  end

end
