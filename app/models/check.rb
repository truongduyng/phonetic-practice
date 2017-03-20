require 'open-uri'

class Check < ActiveType::Object
  attribute :question, :string
  attribute :answer, :string
  attribute :right_answer, default: ''
  # attribute :us_sound_link, :string, default: nil

  validates :question, :answer, presence: true
  before_save :sanitize_input

  def result
    question.split(' ').map(&:singularize).each do |q|
      word = Word.find_by_representation(q) || find_in_cambridge_dict(q)
      self.right_answer += word.phonetic + ' '
    end
    self.right_answer.strip!
    self.right_answer == answer
  end

  private

  def sanitize_input
    self.question = question.downcase.gsub(/[^a-z_ ]/, '').squish
    self.answer   = answer.downcase.squish
  end

  def find_in_cambridge_dict(query)
    doc  = Nokogiri::HTML(open("http://dictionary.cambridge.org/dictionary/english/#{query}"))
    ipas = doc.css('span[pron-region="US"] span.ipa')
    # self.us_sound_link = doc.css('span[pron-region="US"] span.sound.us')
    return query if ipas.empty?
    Word.create!(representation: query, phonetic: ipas.first.content.delete('.'))
  end
end
