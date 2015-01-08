Given(/^a published drug safety update exists$/) do
  @title = "Paracetamol - Damaging effects"
  @slug = slug_from_title(@title)
  @summary = "Update about paracetamol"

  @artefact = artefact_for_slug(@slug).merge(
    "title" => @title,
    "format" => "drug_safety_update",
    "details" => {
      "body" => "<p>Body content</p>\n",
      "summary" => @summary,
      "therapeutic_area" => ["anaesthesia-intensive-care", "cancer"],
      "change_history" => [
        {
          "public_timestamp" => "2014-10-24T08:41:18Z",
          "note" => "Published the Drug Safety Update",
        },
      ],
    }
  )

  content_api_has_an_artefact(@slug, @artefact)
  content_store_has_item("/drug-safety-update", drug_safety_update_finder)
end

Then(/^I see the content of the drug safety update$/) do
  expect(page).to have_content(@title)
  expect(page).to have_content(@summary)
  expect(page).to have_content("Anaesthesia and intensive care")
  expect(page).to have_content("Cancer")
end

def drug_safety_update_finder
  File.read(
    File.expand_path('../../fixtures/finders/drug-safety-update.json', __FILE__)
  )
end
