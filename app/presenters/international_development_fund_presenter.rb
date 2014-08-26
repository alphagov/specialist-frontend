class InternationalDevelopmentFundPresenter < DocumentPresenter
  delegate(
    :fund_state,
    :location,
    :development_sector,
    :eligible_entities,
    :value_of_funding,
    to: :"document.details"
  )

  def format_name
    "International development funding"
  end

  def finder_path
    "/international-development-funding"
  end

private
  def filterable_metadata
    {
      fund_state: fund_state,
      location: location,
      development_sector: development_sector,
      eligible_entities: eligible_entities,
      value_of_funding: value_of_funding,
    }
  end
end
