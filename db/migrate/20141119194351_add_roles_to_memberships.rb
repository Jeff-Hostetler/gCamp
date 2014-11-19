class AddRolesToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :role, :string, default: "member"
  end
end
