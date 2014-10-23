class DrugSafetyUpdatePresenter < DocumentPresenter
  delegate(
    :therapeutic_area,
    :published_date,
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
      "Published date" => published_date,
    }
  end
end
