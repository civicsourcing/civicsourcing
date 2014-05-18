class MembershipRequestResponse < ActiveRecord::Base

  acts_as_eventable is_child: true,
    is_parent: { permitted_children: [Comment] }

  belongs_to :membership_request, class_name: "Adhocracy::MembershipRequest"
  belongs_to :user

  validates :accepted, inclusion: { in: [true, false] }
  validates :membership_request, presence: true

  validate :membership_request_is_still_pending

  after_save :post_event_to_membership_request, :process_membership

  private
  def membership_request_is_still_pending
    unless membership_request.pending?
      errors[:base] << "This membership request is no longer pending."
    end
  end

  def post_event_to_membership_request
    create_event_if_nil
    child_of(membership_request.event)
  end

  def process_membership
    if accepted?
      membership_request.accept
    else
      membership_request.decline
    end
  end
end
