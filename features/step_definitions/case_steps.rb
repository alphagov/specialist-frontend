Given(/^a published case$/) do
  @title = "Merger of Company A and Company B"
  @slug = slug_from_title(@title)
  @summary = "Example summary"

  @artefact = artefact_for_slug(@slug).merge(
    "title" => @title,
    "format" => "cma_case",
    "details" => {
      "need_id" => nil,
      "business_proposition" => false,
      "description" => nil,
      "language" => "en",
      "need_extended_font" => false,
      "alternative_title" => nil,
      "body" => "<p>Body content</p>\n",
      "summary" => @summary,
      "opened_date" => "2012-01-01",
      "closed_date" => "2014-11-21",
      "updated_at" => "",
      "case_type" => "regulatory-references-and-appeals",
      "case_state" => "closed",
      "market_sector" => "distribution-and-service-industries",
      "outcome_type" => "markets-phase-1-undertakings-in-lieu-of-reference",
      "headers" => [],
      "change_history" => [
        {
          "public_timestamp" => "2014-11-24T08:41:18Z",
          "note" => "Published the CMA Case",
        },
      ],
    }
  )

  content_api_has_an_artefact(@slug, @artefact)

  content_store_has_item("/cma-cases", cma_cases_finder)
end

When(/^I visit the document page$/) do
  visit "/#{@slug}"
end

Then(/^I should see the case's content$/) do
  expect(page).to have_content(@title)
  expect(page).to have_content(@summary)
  expect(page).to have_content("1 January 2012")
  expect(page).to have_content("21 November 2014")
  expect(page).to have_content("Regulatory references and appeals")
  expect(page).to have_content("Closed")
  expect(page).to have_no_content("Updated")
end

def slug_from_title(title)
  title.downcase.gsub(/\W/, '-')
end

def cma_cases_finder
  File.read(
    File.expand_path('../../fixtures/finders/cma-cases.json', __FILE__)
  )
end
