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
    hash = {}
    metadata.each do |value|
      hash[value.label] = metadata_values(value)
    end
    hash
  end

  def date_hash(date_metadata)
    hash = {}
    date_metadata
      .reject { |_, value| value.blank? }
      .each { |key, value|
        hash[key] = nice_date_format(value)
      }
    hash
  end
end
