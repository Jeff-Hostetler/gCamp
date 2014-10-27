class PagesController < ApplicationController



  def index
    @index_page =true

    @obama = Quote.new
    @obama.author = "President Obama"
    @obama.speech = "Let me be clear, gCamp is the best."

    @guy = Quote.new
    @guy.speech = "I have something to say about gCamp, man."
    @guy.author = "Guy on the couch"

    @kanye = Quote.new
    @kanye.author = "Kanye West"
    @kanye.speech = "gCamp is nothing. I am GOD!"

    @quotes = [@obama, @guy, @kanye]
  end

  def faq
    @whatIs = FAQ.new
    @whatIs.question = "What is gCamp?"
    @whatIs.answer = "gCamp is an awesome place that allows you to build on your toolbox. This is a place where you can access all of your documents and read comments on those documents. Eventually, you will find less and less use for traditional paper and pencil and will keep track of all of your documents using our system"

    @howDo = FAQ.new
    @howDo.question = "How do I join gCamp?"
    @howDo.answer = "Right now, gCamp is still under construction. Bummer, I know. We are actively engaged in create a comple user exprience that will rival an product on the market. Here at gCamp, we only accept the highest quality and would deliver nothing less to our clients. Join our mailing list and we can keep you up to date with where we are!"

    @whenWill = FAQ.new
    @whenWill.question = "When will gCamp be finished?"
    @whenWill.answer = "gCamp is a work in progress. That being said, the full bang-a-rang product should be available by the end of December 2014. Beyond the production stage, our developers will be continuing to work to enhance the user experience using the direct feedback you provide. How is that for customer service? We are only a click away. Don't be shy, we want to hear what YOU think!"

    @faqs = [@whatIs, @howDo, @whenWill]
  end

end
