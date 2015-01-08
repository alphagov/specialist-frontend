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
      "change_history" => [
        {
          "public_timestamp" => "2014-10-24T08:41:18Z",
          "note" => "Published the Medical Safety Alert",
        },
      ],
    }
  )

  content_api_has_an_artefact(@slug, @artefact)
  content_store_has_item("/drug-device-alerts", drug_device_alerts_finder)
end

Then(/^I see the content of the medical safety alert$/) do
  expect(page).to have_content(@title)
  expect(page).to have_content(@summary)
  expect(page).to have_content("General practice")
end

def drug_device_alerts_finder
  File.read(
    File.expand_path('../../fixtures/finders/medical-safety-alert.json', __FILE__)
  )
end
