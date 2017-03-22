require 'open-uri'

class ChecksController < ApplicationController
  def new
    build_check
  end

  def create
    build_check
    redirect_to root_path unless @check.save
  end

  private

  def check_params
    params[:check] ? params.require(:check).permit(:question, :answer) : {}
  end

  def build_check
    @check ||= Check.new(check_params || {})
  end
end
