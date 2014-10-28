class Task < ActiveRecord::Base

  def self.as_csv
  CSV.generate do |csv|
    csv << column_names
    all.each do |task|
      csv << task.attributes.values_at(*column_names)
      end
    end
  end

end
