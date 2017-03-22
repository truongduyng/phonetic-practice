class Word < ActiveRecord::Base
  include ApplicationHelper

  validates :representation, :phonetic, presence: true

  before_save :santinize

  private

  def santinize
    self.phonetic = phonetic.tr('t̬ɚɝ', 'tǝrɜ').gsub(%r{^\/|\/$|\.}, '')
  end
end
