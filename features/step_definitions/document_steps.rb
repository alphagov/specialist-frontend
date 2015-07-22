Given(/^a published Document exists$/) do
  @title = "Product Gaps Team Lunch"
  @slug = "team-meals/#{slug_from_title(@title)}"
  @artefact = create_team_meal(@slug)
end

When(/^I visit the Document page$/) do
  visit "/#{@slug}"
end

Then(/^I see the content of the Document$/) do
  expect(page).to have_content(@title)
  check_metadata_value("Published", "24 October 2014")
  check_metadata_value("Date of meal", "3 February 2015")
  check_metadata_value("Meal type", "Lunch")
  check_metadata_value("Food", "Steak")
  check_metadata_value("Location", "Moe's Tavern")
end

Given(/^a published Document with a major change exists$/) do
  @title = "Product Gaps Team Lunch"
  @slug = "team-meals/#{slug_from_title(@title)}"
  @artefact = create_team_meal(@slug, major_changes: 2)
end

Then(/^I see the content of the republished Document$/) do
  expect(page).to have_content(@title)
  check_metadata_value("Updated", "24 October 2014")
end

def slug_from_title(title)
  title.downcase.gsub(/\W/, '-')
end

def team_meals_finder
  File.read(
    File.expand_path('../../fixtures/finders/team-meals.json', __FILE__)
  )
end

def create_team_meal(slug, major_changes: 1)
  base_time = Time.mktime(2013, 10, 24)

  change_history = major_changes.times.map do |x|
    {
      "public_timestamp" => base_time + x.months,
      "note" => "Published the document - #{x}",
    }
  end

  artefact = artefact_for_slug(@slug).merge(
    "title" => @title,
    "format" => "team-meal",
    "details" => {
      "body" => "<p>Body content</p>\n",
      "summary" => 'Summary of document',
      "food" => ["steak"],
      "meal_type" => "lunch",
      "updated_at" => "2014-10-24T08:41:18Z",
      "date_of_meal" => "2015-02-03",
      "location" => "Moe's Tavern",
      "published_at" => "2014-10-24T08:41:18Z",
      "change_history" => change_history,
    }
  )

  content_api_has_an_artefact(@slug, artefact)
  content_store_has_item("/team-meals", team_meals_finder)
end

def check_metadata_value(key, value)
  within(shared_component_selector('metadata')) do
    expect(page).to have_content(key)
    expect(page).to have_content(value)
  end
end
