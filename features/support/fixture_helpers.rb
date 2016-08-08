module FixtureHelpers
  def read_fixture(fixture_path)
    File.read(
      File.expand_path("../../fixtures/#{fixture_path}", __FILE__)
    )
  end

  def check_breadcrumb_value(title, url)
    within(shared_component_selector('breadcrumbs')) do
      expect(page).to have_content(title)
      expect(page).to have_content(url)
    end
  end
end

World(FixtureHelpers)
