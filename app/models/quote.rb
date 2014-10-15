class Quote

  attr_accessor :author, :speech

  def quotation
    "#{speech} -- #{author}"

  end
end
