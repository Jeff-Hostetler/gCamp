class Comment<ActiveRecord::Base
  attr_accessor :skip_on_create_validation

  belongs_to :task
  belongs_to :user

  validates :description, presence: true
  validates :task_id, presence: true

end
