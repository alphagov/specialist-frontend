class AaibReportPresenter < DocumentPresenter

  delegate :date_of_occurrence,
    :aircraft_category,
    :report_type,
    to: :"document.details"

  def format_name
    "Air Accidents Investigation Branch report"
  end

private
  def extra_date_metadata
    {
      "Date of occurrence" => date_of_occurrence,
    }
  end

  def extra_raw_metadata
    {
      aircraft_category: aircraft_category,
      report_type: report_type,
    }
  end
end
