module SpecialistDocumentsHelper

  def nice_date_format(time_string)
    unless time_string.blank?
      time = Time.zone.parse(time_string)
      string = "<time datetime='#{time.iso8601}'>"
      string += time.strftime('%-d %B %Y')
      string += '</time>'
      string.html_safe
    end
  end

  def metadata_value_sentence(values)
    values.map { |v| content_tag(:span, v) }
      .to_sentence(last_word_connector: ' and ')
      .html_safe
  end
end
