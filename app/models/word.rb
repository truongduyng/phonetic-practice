class Word < ActiveRecord::Base
  include ApplicationHelper

  validates :representation, :phonetic, presence: true

  before_save :santinize

  private

  def santinize
    phonetic.tr('t̬ɚɝ', 'tǝrɜ')
  end
end
