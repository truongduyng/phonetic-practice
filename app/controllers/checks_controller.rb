class ChecksController < ApplicationController
  def new
    build_check
  end

  def create
    build_check
    redirect_to root_path unless @check.save
  end

  private

  def build_check
    @check ||= Check.new(params[:check] || {})
  end

  def question
    @doc ||= Nokogiri::HTML(open("http://livelifehappy.com/page/#{rand(100)}/"))
    @doc.css('article div.entry-content p:nth-child(2)')[rand(4)].content
  end
end
