class DocumentPresenter

  delegate :title, :details, to: :document
  delegate :summary,
    :body,
    :published_at,
    :bulk_published,
    to: :"document.details"

  def initialize(schema, document)
    @schema = schema
    @document = document
  end

  def format_name
    ""
  end

  def date_metadata
    default_date_metadata
      .merge(extra_date_metadata)
  end

  def metadata
    expanded_filterable_metadata + expanded_extra_metadata
  end

  def headers
    document.details.headers || []
  end

  def organisations
    document.tags.select{ |t|
      t.type = "organisation"
    }
  end

  def extra_date_metadata
    {}
  end

  def change_history
    document.details.change_history || []
  end

  def beta?
    false
  end

  def beta_message
    nil
  end

private

  attr_reader :document, :schema

  def metadata_response_builder(label, values)
    OpenStruct.new(
      label: label,
      values: Array(values).map { |value|
        OpenStruct.new(label: value, linkable?: false)
      }
    )
  end

  def filterable_metadata_response_builder(key, data)
    label = data.fetch(:label)

    OpenStruct.new(
      label: label,
      values: data.fetch(:values).map { |value|
        OpenStruct.new(
          label: value.fetch(:label),
          linkable?: true,
          href: "#{finder_path}?#{key}%5B%5D=#{value.fetch(:slug)}"
        )
      }
    )
  end

  def expanded_extra_metadata
    extra_metadata
      .reject { |_, value| value.blank? }
      .map { |label, values| metadata_response_builder(label, values) }
  end

  def convert_filterable_metadata(expanded_filterable_metadata)
    expanded_filterable_metadata.map { |key, data| filterable_metadata_response_builder(key, data) }
  end

  def expanded_filterable_metadata
    present_metadata = filterable_metadata.reject { |_, value| value.blank? }
    convert_filterable_metadata(schema.user_friendly_values(present_metadata))
  end

  def default_date_metadata
    return {} if bulk_published

    {
      "Updated" => published_at,
    }
  end

  def first_edition?
    change_history.size <= 1
  end

  def filterable_metadata
    {}
  end

  def extra_metadata
    {}
  end
end
