class Word < ActiveRecord::Base
  include ApplicationHelper

  validates :representation, :phonetic, presence: true

  before_save :santinize

  private

  def santinize
    phonetic.tr('t̬', 't').tr('ɚ', 'ǝr')
  end
end
