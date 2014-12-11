class MaibReportPresenter < DocumentPresenter

  delegate :date_of_occurrence,
    :vessel_type,
    :report_type,
    to: :"document.details"

  def format_name
    "Marine Accident Investigation Branch report"
  end

  def finder_path
    "/maib-reports"
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
    "Until early 2015, the <a href='http://www.maib.gov.uk/home/index.cfm'>MAIB website</a> is the main source for MAIB reports"
  end

private
  def filterable_metadata
    {
      vessel_type: vessel_type,
      report_type: report_type,
    }
  end
end
