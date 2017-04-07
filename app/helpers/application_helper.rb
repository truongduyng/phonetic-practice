module ApplicationHelper
  def ipa_keys
    %w(' , a: ai au o: oy ou e ei ea I i: uw u: ^ ow 3: p b f v k ɡ th dd s z sx 3y
       t d tsx d3y j m n ny w r h l)
  end

  def ipa_list
    %w(ˈ ˌ ɑː aɪ aʊ ɔː ɔɪ oʊ e eɪ æ ɪ iː ʊ uː ʌ ə ɜ: p b f v k ɡ θ ð s z ∫ ʒ t d t∫
       dʒ j m n ŋ w r h l)
  end
end
