class DrugSafetyUpdatePresenter < DocumentPresenter
  delegate(
    :therapeutic_area,
    :first_published_at,
    to: :"document.details"
  )

  def format_name
    "Drug Safety Update"
  end

  def finder_path
    "/drug-safety-update"
  end

  def extra_date_metadata
    {
      "Published at" => first_published_at,
    }
  end

  def beta?
    true
  end

  def beta_message
    "Until January 2015, <a href='http://www.mhra.gov.uk/Safetyinformation/DrugSafetyUpdate/index.htm'>the MHRA website</a> is the official home of the Drug Safety Update."
  end

private
  def filterable_metadata
    {
      therapeutic_area: therapeutic_area,
    }
  end
end
