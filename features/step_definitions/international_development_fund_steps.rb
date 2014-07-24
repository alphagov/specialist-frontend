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
      "application_state" => "open",
      "location" => ["mozambique", "zambia", "zimbabwe"],
      "document_sector" => ["health", "disabilities"],
      "eligible_entities" => ["companies", "local-government"],
      "value_of_fund" => "100001-500000",
    }
  )

  content_api_has_an_artefact(@slug, @artefact)
  finder_api_has_schema("international-development-funds", idf_schema)
end

Then(/^I should see the fund's content$/) do
  expect(page).to have_content(@title)
  expect(page).to have_content(@summary)
  expect(page).to have_content("Open")
  expect(page).to have_content("Mozambique, Zambia and Zimbabwe")
  expect(page).to have_content("Health and Disabilities")
  expect(page).to have_content("Companies and Local government")
  expect(page).to have_content("£100,001 to £500,000")
end

def idf_schema
  File.read(
    File.expand_path('../../fixtures/schemas/international-development-funding-schema.json', __FILE__)
  )
end
