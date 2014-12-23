def check_metadata_value(key, value)
  within(shared_component_selector('metadata')) do
    expect(page).to have_content(key)
    expect(page).to have_content(value)
  end
end
