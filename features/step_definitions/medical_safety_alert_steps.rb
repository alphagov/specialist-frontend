Given(/^a published medical safety alert exists$/) do
  @title = "Alert about Panacea"
  @slug = slug_from_title(@title)
  @summary = "Alert about Panacea"

  @artefact = artefact_for_slug(@slug).merge(
    "title" => @title,
    "format" => "medical_safety_alert",
    "details" => {
      "body" => "<p>Body content</p>\n",
      "summary" => @summary,
      "alert_type" => ["drugs"],
      "medical_specialism" => ["general-practice"],
    }
  )

  content_api_has_an_artefact(@slug, @artefact)
  finder_api_has_schema("drug-device-alerts", medical_safety_alert_schema)
end

Then(/^I see the content of the medical safety alert$/) do
  expect(page).to have_content(@title)
  expect(page).to have_content(@summary)
  expect(page).to have_content("General practice")
end

def medical_safety_alert_schema
  File.read(
    File.expand_path('../../fixtures/schemas/medical-safety-alert-schema.json', __FILE__)
  )
end
