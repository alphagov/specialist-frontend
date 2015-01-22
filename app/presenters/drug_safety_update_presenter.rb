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
      "Published" => first_published_at,
    }
  end

  def footer_date_metadata
    return {} if first_edition?
    super
  end

private
  def filterable_metadata
    {
      therapeutic_area: therapeutic_area,
    }
  end

  def default_date_metadata
    return {} if bulk_published
    return {} if first_edition?
    super
  end
end
