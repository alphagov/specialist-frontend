module FixtureHelpers
  def read_fixture(fixture_path)
    File.read(
      File.expand_path("../../fixtures/#{fixture_path}", __FILE__)
    )
  end
end

World(FixtureHelpers)
