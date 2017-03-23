class Word < ActiveRecord::Base
  validates :representation, :phonetic, presence: true

  before_save :santinize

  private

  def santinize
    self.phonetic = phonetic.tr('t̬ɝ', 'tɜ').gsub('ɚ', 'ǝr') \
                            .gsub(%r{/.\[\]}, '')
  end
end
