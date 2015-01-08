class Finder

  def initialize(content_item)
    @content_item = content_item
  end

  def user_friendly_values(document_attributes)
    document_attributes.each_with_object({}) do |(k, v), values|
      values.store(
        k.to_s,
        {
          label: user_friendly_facet_label(k.to_s),
          values: user_friendly_facet_value(k.to_s, v),
        }
      )
    end
  end

private

  attr_reader :content_item

  def user_friendly_facet_label(facet_key)
    find_facet(facet_key.to_s).name
  end

  def user_friendly_facet_value(facet_key, value)
    Array(value).map { |value|
      {
        label: find_schema_allowed_value_label(facet_key, value),
        slug: value,
      }
    }
  end

  def find_schema_allowed_value_label(facet_key, value)
    value_label_pair = allowed_values_for(facet_key)
      .find { |schema_value|
        schema_value.value == value
      }

    if value_label_pair.nil?
      raise_value_not_found_error(facet_key, value)
    else
      value_label_pair.label
    end
  end

  def allowed_values_for(facet_key)
    find_facet(facet_key).allowed_values
  end

  def find_facet(facet_key)
    facets.find { |facet| facet.key == facet_key }
  end

  def facets
    content_item.details.facets
  end

end
