class BadgeGranter

  attr_accessor :user, :count, :qualifications, :sash
  def initialize(params)
    @user = params[:user]
    @count = params[:count]
    @qualifications = params[:qualifications]
    @sash = @user.sash
  end

  def add_badges
    qualifications.each do |qual|
      if count == qual[:prerequisite]
        user.add_badge(qual[:badge]) unless badge_present?(qual[:badge])
      end
    end
  end

  def remove_badges
    qualifications.each do |qual|
      if count == qual[:prerequisite] - 1
        user.rm_badge(qual[:badge]) if badge_present?(qual[:badge])
      end
    end
  end

  private
  def badge_present?(badge_id)
    sash.badge_ids.include?(badge_id)
  end
end
