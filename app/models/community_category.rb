class CommunityCategory < ActiveRecord::Base
  has_many :communities
  
end
