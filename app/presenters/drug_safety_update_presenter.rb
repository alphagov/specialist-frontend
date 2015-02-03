class DrugSafetyUpdatePresenter < DocumentPresenter

  def footer_date_metadata
    return {} if first_edition?
    super
  end

private

  def default_date_metadata
    return {} if bulk_published
    return {} if first_edition?
    super
  end
end
