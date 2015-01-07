Given(/^a published international development fund exists$/) do
  @title = "Protracted Relief Programme Phase 1"
  @slug = slug_from_title(@title)
  @summary = "Stabilising food security for 1.5 million people in Zimbabwe"

  @artefact = artefact_for_slug(@slug).merge(
    "title" => @title,
    "format" => "international_development_fund",
    "details" => {
      "body" => "<p>Body content</p>\n",
      "summary" => @summary,
      "fund_state" => "open",
      "location" => ["mozambique", "zambia", "zimbabwe"],
      "development_sector" => ["health", "disabilities"],
      "eligible_entities" => ["companies", "local-government"],
      "value_of_funding" => "100001-500000",
      "change_history" => [
        {
          "public_timestamp" => "2014-10-24T08:41:18Z",
          "note" => "Published the Fund",
        },
      ],
    }
  )

  content_api_has_an_artefact(@slug, @artefact)
  content_store_has_item("/international-development-funding", idf_finder)
end

Then(/^I should see the fund's content$/) do
  expect(page).to have_content(@title)
  expect(page).to have_content(@summary)
  expect(page).to have_content("Open")
  expect(page).to have_content("Mozambique")
  expect(page).to have_content("Zambia")
  expect(page).to have_content("Zimbabwe")
  expect(page).to have_content("Health")
  expect(page).to have_content("Disabilities")
  expect(page).to have_content("Companies")
  expect(page).to have_content("Local government")
  expect(page).to have_content("£100,001 to £500,000")
end

def idf_finder
  File.read(
    File.expand_path('../../fixtures/finders/international-development-funding.json', __FILE__)
  )
end
