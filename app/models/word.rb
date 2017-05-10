class Word < ApplicationRecord
  validates :representation, :phonetic, presence: true
  validates :representation, :phonetic, uniqueness: true
  before_save :santinize

  private

  def santinize
    self.phonetic = phonetic.tr('t̬', 't').tr('ɝ', 'ɜr').gsub('ɚ', 'ər') \
                            .gsub(%r{[/.\[\]]}, '')
  end
end
