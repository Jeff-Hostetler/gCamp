class CreateMembershipTable < ActiveRecord::Migration
  def change
    create_table :membership_tables do |t|
      t.belongs_to :user
      t.belongs_to :project

      t.timestamp

    end
  end
end
