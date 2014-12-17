Given(/^a published MAIB report exists$/) do
  @title = "This is a test MAIB Report"
  @slug = slug_from_title(@title)

  @artefact = artefact_for_slug(@slug).merge(
    "title" => @title,
    "format" => "maib_report",
    "details" => {
      "body" => "<p>Body content</p>\n",
      "summary" => 'Summary of MAIB report',
      "date_of_occurrence" => "2014-01-01",
      "summary" => nil,
      "vessel_type" => "fishing-vessel",
      "vessel_type_label" => "Fishing vessel",
      "report_type" => "investigation-report",
      "report_type_label" => "Investigation report",
      "updated_at" => "2014-10-24T08:41:18Z",
      "date_of_occurrence" => "1992-04-03",
      "published_at" => "2014-10-24T08:41:18Z",
      "change_history" => [
        {
          "public_timestamp" => "2014-10-24T08:41:18Z",
          "note" => "Published the MAIB Report",
        },
      ],
    }
  )

  content_api_has_an_artefact(@slug, @artefact)
  finder_api_has_schema("maib-reports", maib_report_schema)
end

Then(/^I see the content of the MAIB report$/) do
  expect(page).to have_content(@title)
  check_metadata_value("Published", "24 October 2014")
  check_metadata_value("Date of occurrence", "3 April 1992")
  check_metadata_value("Vessel type", "Fishing vessel")
  check_metadata_value("Report type", "Investigation report")
end

def maib_report_schema
  File.read(
    File.expand_path('../../fixtures/schemas/maib-reports.json', __FILE__)
  )
end
