class DrugSafetyUpdatePresenter < DocumentPresenter
  delegate(
    :therapeutic_area,
    :first_published_at,
    to: :"document.details"
  )

  def format_name
    "Drug safety update"
  end

  def finder_path
    "/drug-safety-update"
  end

private
  def filterable_metadata
    {
      therapeutic_area: therapeutic_area,
    }
  end

  def extra_date_metadata
    {
      "Published at" => first_published_at,
    }
  end
end
