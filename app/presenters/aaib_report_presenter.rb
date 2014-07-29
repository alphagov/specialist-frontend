class AaibReportPresenter < DocumentPresenter
  delegate :aircraft_category,
    :aircraft_types,
    :date_of_occurrence,
    :location,
    :registrations,
    :report_type,
    to: :"document.details"

  def format_name
    "Air Accidents Investigation Branch report"
  end

  def metadata
    super
      .merge(non_schemaified_metadata)
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

  def non_schemaified_metadata
    {
      "Aircraft types" => [aircraft_types],
      "Location" => [location],
      "Registrations" => registrations,
    }
  end
end
