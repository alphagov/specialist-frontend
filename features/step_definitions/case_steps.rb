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
      "case_type" => "regulatory-references-and-appeals",
      "case_state" => "closed",
      "market_sector" => "distribution-and-service-industries",
      "outcome_type" => "markets-phase-1-undertakings-in-lieu-of-reference",
      "headers" => [],
    }
  )

  content_api_has_an_artefact(@slug, @artefact)

  finder_api_has_schema("cma-cases")
end

When(/^I visit the case page$/) do
  visit "/#{@slug}"
end

Then(/^I should see the case's content$/) do
  expect(page).to have_content(@title)
  expect(page).to have_content(@summary)
  expect(page).to have_content(@artefact[:opened_date])
  expect(page).to have_content(@artefact[:closed_date])
  expect(page).to have_content(@artefact[:case_type])
  expect(page).to have_content(@artefact[:case_state])
end

def slug_from_title(title)
  title.downcase.gsub(/\W/, '-')
end
