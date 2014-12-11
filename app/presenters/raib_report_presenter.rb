class RaibReportPresenter < DocumentPresenter

  delegate :date_of_occurrence,
    :railway_type,
    :report_type,
    to: :"document.details"

  def format_name
    "Rail Accident Investigation Branch report"
  end

  def finder_path
    "/raib-reports"
  end

  def extra_date_metadata
    {
      "Date of occurrence" => date_of_occurrence,
    }
  end

  def beta?
    true
  end

  def beta_message
    "Until early 2015, the <a href='http://www.raib.gov.uk/home/index.cfm'>RAIB website</a> is the main source for RAIB reports"
  end

private
  def filterable_metadata
    {
      railway_type: railway_type,
      report_type: report_type,
    }
  end
end
