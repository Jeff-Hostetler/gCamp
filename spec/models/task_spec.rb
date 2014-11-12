require 'rails_helper'

describe Task do

  it "validates date on new save is in the future or blank" do
    task = Task.new(description: "test" )
    task.valid?
    expect(task.errors[:due].present?).to eq(false)

    task2 = Task.new(description: "test", due: "01/01/2011" )
    task2.valid?
    expect(task2.errors[:due].present?).to eq(true)

    task3 = Task.create(description: "test")
    task3.update(description: "tester", due: "01/01/2011")
    expect(task3.errors[:due].present?).to eq(false)

  end

end
