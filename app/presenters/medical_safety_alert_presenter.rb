class MedicalSafetyAlertPresenter < DocumentPresenter
  delegate(
    :alert_type,
    :medical_specialism,
    :issued_date,
    to: :"document.details"
  )

  def format_name
    "Medical safety alert"
  end

  def finder_path
    "/drug-device-alerts"
  end

  def extra_date_metadata
    {
      "Issued date" => issued_date,
    }
  end

  def beta?
    true
  end

  def beta_message
    "Until January 2015, <a href='http://www.mhra.gov.uk/Safetyinformation/Safetywarningsalertsandrecalls/index.htm'>the MHRA website</a> is the main source for drug alerts and medical device alerts."
  end

private
  def filterable_metadata
    {
      alert_type: alert_type,
      medical_specialism: medical_specialism,
    }
  end
end
