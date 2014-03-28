class DocumentPresenter

  attr_reader :document

  delegate :title, :details, :updated_at, to: :document

  delegate :opened_date, :closed_date, :market_sector, :case_type, :case_state, :outcome_type, :summary, :headers, :body, to: :"document.details"

  def initialize(document)
    @document = document
  end

end
