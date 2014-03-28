class DocumentPresenter

  attr_reader :document

  delegate :title, :details, :updated_at, to: :document

  def initialize(document)
    @document = document
  end

end
