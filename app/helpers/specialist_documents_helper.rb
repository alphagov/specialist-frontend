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

  def metadata_value_sentence(data, key, finder_path)
    data.fetch(:values).map { |v|
      content_tag(:a, v.fetch(:label), href: "#{finder_path}?#{key}%5B%5D=#{v.fetch(:slug)}" )
    }.to_sentence(last_word_connector: ' and ').html_safe
  end
end
