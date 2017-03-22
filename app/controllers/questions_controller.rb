class QuestionsController < ApplicationController
  def show
    load_question
  end

  private

  def load_question
    @doc    ||= Nokogiri::HTML(HTTParty.get("http://livelifehappy.com/page/#{rand(100)}/"))
    @question = @doc.css('article div.entry-content p:nth-child(2)')[rand(4)].content.gsub(/^.*:|–.*$/, '')
  end
end
