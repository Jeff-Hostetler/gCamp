class ChangeFromMigrationToMigartions < ActiveRecord::Migration
  def change
    rename_table :membership_tables, :memberships
  end
end
