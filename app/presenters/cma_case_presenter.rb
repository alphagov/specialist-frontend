class CmaCasePresenter < DocumentPresenter

  delegate :opened_date,
    :closed_date,
    :market_sector,
    :case_type,
    :case_state,
    :outcome_type,
    to: :"document.details"

  def format_name
    "Competition and Markets Authority case"
  end

  def finder_path
    "/cma-cases"
  end

private
  def extra_date_metadata
    {
      "Opened date" => opened_date,
      "Closed date" => closed_date,
    }
  end

  def extra_raw_metadata
    {
      case_type: case_type,
      case_state: case_state,
      market_sector: market_sector,
      outcome_type: outcome_type,
    }
  end
end
