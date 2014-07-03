class DocumentPresenter

  delegate :title, :details, :updated_at, to: :document
  delegate :summary,
    :headers,
    :body,
    to: :"document.details"

  def initialize(schema, document)
    @schema = schema
    @document = document
  end

  def format_name
    ""
  end

  def date_metadata
    metadata = default_date_metadata.merge(extra_date_metadata)
    metadata.reject { |_, value| value.blank? }
  end

  def metadata
    schema.user_friendly_values(raw_metadata)
  end

private

  attr_reader :document, :schema

  def default_date_metadata
    {
      "Updated at" => updated_at,
    }
  end

  def extra_date_metadata
    {}
  end

  def default_raw_metadata
    {}
  end

  def extra_raw_metadata
    {}
  end

  def raw_metadata
    metadata = default_raw_metadata.merge(extra_raw_metadata)
    metadata.reject { |_, value| value.blank? }
  end
end
