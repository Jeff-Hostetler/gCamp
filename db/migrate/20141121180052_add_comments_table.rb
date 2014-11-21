class AddCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :task
      t.text :description

      t.timestamps
    end
  end
end
