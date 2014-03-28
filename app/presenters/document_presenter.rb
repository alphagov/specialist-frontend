class DocumentPresenter

  attr_reader :document

  delegate :title, :details, :updated_at, to: :document

  delegate :opened_date, :closed_date, :market_sector, :case_type, :case_state, :outcome_type, :summary, :headers, :body, to: :"document.details"

  def initialize(document)
    @document = document
  end

  def date_metadata
    {
      "Opened date" => opened_date,
      "Closed date" => closed_date,
      "Updated at" => updated_at,
    }
  end

  def metadata
    {
      "Market sector" => market_sector,
      "Case type" => case_type,
      "Case state" => case_state.capitalize,
      "Outcome type" => outcome_type,
    }
  end

end
