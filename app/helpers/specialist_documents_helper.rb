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

  def metadata_values(data)
    data.values.map { |value|
      if value.linkable?
        content_tag(:a, value.label, href: value.href)
      else
        value.label
      end
    }
  end

  def metadata_hash(metadata)
    metadata.inject({}) do |hash, value|
      hash.merge(value.label => metadata_values(value))
    end
  end

  def date_hash(date_metadata)
    date_metadata.inject({}) do |hash, (key, value)|
      hash.merge(value[:label] => nice_date_format(value[:values]))
    end
  end
end
