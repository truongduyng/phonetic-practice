class Check < ActiveType::Object
  attribute :question, :string
  attribute :answer, :string
  attribute :right_answer, default: ''
  # attribute :us_sound_link, :string, default: nil

  validates :question, :answer, presence: true
  before_save :sanitize_input

  def errors_array_index
    question.split(' ').each do |q|
      word = Word.find_by_representation(q) || find_in_cambridge_dict(q)
      self.right_answer += word.phonetic + ' '
    end
    self.right_answer.strip!
    errors_index = []
    answer_splits = answer.split(' ')
    self.right_answer.split(' ').each_with_index do |rw_word, i|
      errors_index << i if !answer_splits[i] || rw_word != answer_splits[i]
    end
    errors_index
  end

  private

  def sanitize_input
    self.question = question.downcase.tr('’', '-').gsub(/[^a-z_ -]/, '').squish
    self.answer   = answer.downcase.squish
  end

  def find_in_cambridge_dict(query)
    doc  = Nokogiri::HTML(HTTParty.get("http://dictionary.cambridge.org/dictionary/english/#{query}"))
    ipas = doc.css('div.di-body').try(:first).try(:css, 'span[pron-region="US"] span.ipa')
    if ipas.empty? || ipas.first.content.empty?
      doc = Nokogiri::HTML(HTTParty.get("http://dict.laban.vn/find?type=1&query=#{query}"))
      ipas = doc.css('div.world span.color-black')
      return Word.new(phonetic: '') if ipas.empty? || ipas.first.content.empty?
    end
    Word.create!(representation: query.tr('-', '’'), phonetic: ipas.first.content)
  end
end
