Given(/^a published Document exists$/) do
  @document_base_path = create_team_meal
end

When(/^I visit the Document page$/) do
  visit @document_base_path
end

Then(/^I see the content of the Document$/) do
  expect(page).to have_content("Product Gaps Team Lunch")
  check_metadata_value("Published", "24 October 2014")
  check_metadata_value("Date of meal", "3 February 2015")
  check_metadata_value("Meal type", "Lunch")
  check_metadata_value("Food", "Steak")
  check_metadata_value("Location", "Moe's Tavern")
end

Given(/^a published Document with a major change exists$/) do
  @document_base_path = create_team_meal(major_changes: 2)
end

Then(/^I see the content of the republished Document$/) do
  expect(page).to have_content("Product Gaps Team Lunch")
  check_metadata_value("Updated", "24 October 2014")
end

def slug_from_title(title)
  title.downcase.gsub(/\W/, '-')
end

def team_meals_finder
  read_fixture("finders/team-meals.json")
end

def team_meal
  read_fixture("specialist_documents/team-meal.json")
end

def create_team_meal(major_changes: 1)
  base_time = Time.mktime(2013, 10, 24)

  change_history = major_changes.times.map do |x|
    {
      "public_timestamp" => base_time + x.months,
      "note" => "Published the document - #{x}",
    }
  end

  team_meal_with_change_history = JSON.parse(team_meal)
  team_meal_with_change_history["details"]["change_history"] = change_history
  base_path = team_meal_with_change_history["base_path"]
  team_meal_with_change_history = team_meal_with_change_history.to_json

  content_store_has_item(base_path, team_meal_with_change_history)
  content_store_has_item("/team-meals", team_meals_finder)

  return base_path
end

def check_metadata_value(key, value)
  within(shared_component_selector('metadata')) do
    expect(page).to have_content(key)
    expect(page).to have_content(value)
  end
end
