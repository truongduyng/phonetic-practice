class ChecksController < ApplicationController
  def new
    build_check
  end

  def create
    build_check
    @check.save
  end

  private

  def build_check
    @check ||= Check.new({ question: question }.merge(params[:check] || {}))
  end

  def question
    'hello'
  end
end
