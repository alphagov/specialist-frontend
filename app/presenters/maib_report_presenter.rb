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

private
  def extra_date_metadata
    {
      "Date of occurrence" => date_of_occurrence,
    }
  end

  def filterable_metadata
    {
      vessel_type: vessel_type,
      report_type: report_type,
    }
  end
end
