module Feature
  extend ActiveSupport::Concern

  module ClassMethods
    def expire_featured
      featured = self.find_by(featured: true)
      featured.update_column(:featured, false) if featured.present?
    end
  end

  def feature
    return defeature if featured?
    self.class.expire_featured
    update_column(:featured, true)
  end

  def defeature
    update_column(:featured, false)
  end
end