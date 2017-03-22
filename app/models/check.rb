class Check < ActiveType::Object
  attribute :question, :string
  attribute :answer, :string
  attribute :right_answer, default: ''
  # attribute :us_sound_link, :string, default: nil

  validates :question, :answer, presence: true
  before_save :sanitize_input

  def result
    question.split(' ').each do |q|
      word = Word.find_by_representation(q) || find_in_cambridge_dict(q)
      self.right_answer += word.phonetic + ' '
    end
    self.right_answer.strip!
    self.right_answer == answer
  end

  private

  def sanitize_input
    self.question = question.downcase.tr('’', '-').gsub(/[^a-z_ -]/, '').squish
    self.answer   = answer.downcase.squish
  end

  def find_in_cambridge_dict(query)
    doc  = Nokogiri::HTML(HTTParty.get("http://dictionary.cambridge.org/dictionary/english/#{query}"))
    ipas = doc.css('span[pron-region="US"] span.ipa')
    # self.us_sound_link = doc.css('span[pron-region="US"] span.sound.us')
    if ipas.empty?
      doc = Nokogiri::HTML(HTTParty.get("http://dict.laban.vn/find?type=1&query=#{query}"))
      ipas = doc.css('div.world span.color-black')
      return Word.new(phonetic: '') if ipas.empty?
    end
    Word.create!(representation: query.tr('-', '’'), phonetic: ipas.first.content)
  end
end
