class Membership < ActiveRecord::Base

  belongs_to :project
  belongs_to :user

  validates :user_id, presence: true, uniqueness: {scope: :project_id}
  validates :project_id, presence: true

  before_destroy :at_least_one_owner
  before_update :at_least_one_owner

  private

  def at_least_one_owner
    membership = Membership.find(id)
    if ((project.memberships.where(role: "owner").count - 1) == 0) && membership.role == "owner"
      errors.add(:base, "There must be at least 1 owner on a project.")
      return false
      redirect_to project_memberships_path(project)
    end
  end



end
