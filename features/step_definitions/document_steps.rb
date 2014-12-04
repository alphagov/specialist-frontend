def check_metadata_value(key, value)
  within(".govuk_component-metadata") do
    expect(page).to have_content(key)
    expect(page).to have_content(value)
  end
end
