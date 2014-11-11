class Task < ActiveRecord::Base

  validates :description, presence: true

   validate :due_date_not_in_future
  def  due_date_not_in_future
    if due != nil && id == nil
      if (due < Date.today)
        errors.add(:due, "date must be in future.")
      end
    end
  end


  def self.as_csv
  CSV.generate do |csv|
    csv << column_names
    all.each do |task|
      csv << task.attributes.values_at(*column_names)
      end
    end
  end

end
