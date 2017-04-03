class Word < ActiveRecord::Base
  validates :representation, :phonetic, presence: true

  before_save :santinize

  private

  def santinize
    self.phonetic = phonetic.tr('t̬', 't').tr('ɝ', 'ɜr').gsub('ɚ', 'ǝr') \
                            .gsub(%r{[/.\[\]]}, '')
  end
end
