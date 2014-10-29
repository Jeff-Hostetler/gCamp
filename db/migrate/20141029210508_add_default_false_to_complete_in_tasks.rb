class AddDefaultFalseToCompleteInTasks < ActiveRecord::Migration
  def up
    change_column :tasks, :complete, :boolean, :default => false
  end
  def down
    change_column :tasks, :complete, :boolean, :default => nil
  end
end
