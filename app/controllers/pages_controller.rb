class PagesController < ApplicationController

  def index
    @obama = Quote.new
    @obama.author = "President Obama"
    @obama.speech = "Let me be clear, gCamp is the best."

    @guy = Quote.new
    @guy.speech = "I have something to say about gCamp, man."
    @guy.author = "Guy on the couch"

    @kanye = Quote.new
    @kanye.author = "Kanye West"
    @kanye.speech = "gCamp is nothing. I am GOD!"
  end
end
