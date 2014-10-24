class AaibReportPresenter < DocumentPresenter

  delegate :date_of_occurrence,
    :aircraft_category,
    :aircraft_type,
    :location,
    :registration,
    :report_type,
    to: :"document.details"

  def format_name
    "Air Accidents Investigation Branch report"
  end

  def finder_path
    "/aaib-reports"
  end

private
  def extra_date_metadata
    {
      "Date of occurrence" => date_of_occurrence,
    }
  end

  def filterable_metadata
    {
      aircraft_category: aircraft_category,
      report_type: report_type,
    }
  end

  def extra_metadata
    {
      "Aircraft types" => aircraft_type,
      "Location" => location,
      "Registration" => registration,
    }
  end
end
