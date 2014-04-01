class DocumentPresenter

  attr_reader :document, :schema
  private :document, :schema

  delegate :title, :details, :updated_at, to: :document

  delegate :opened_date,
    :closed_date,
    :market_sector,
    :case_type,
    :case_state,
    :outcome_type,
    :summary,
    :headers,
    :body,
    to: :"document.details"

  def initialize(schema, document)
    @schema = schema
    @document = document
  end

  def date_metadata
    date_metadata = {
      "Opened date" => opened_date,
      "Closed date" => closed_date,
      "Updated at" => updated_at,
    }

    date_metadata.reject { |_, value| value.blank? }
  end

  def metadata
    schema.user_friendly_values(raw_metadata)
  end

  private

  def raw_metadata
    {
      case_type: case_type,
      case_state: case_state,
      market_sector: market_sector,
      outcome_type: outcome_type,
    }.reject { |_, value| value.blank? }
  end
end
