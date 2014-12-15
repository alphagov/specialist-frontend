Given(/^a published RAIB report exists$/) do
  @title = "This is a test RAIB Report"
  @slug = slug_from_title(@title)

  @artefact = artefact_for_slug(@slug).merge(
    "title" => @title,
    "format" => "raib_report",
    "details" => {
      "body" => "<p>Body content</p>\n",
      "summary" => 'Summary of RAIB report',
      "date_of_occurrence" => "2014-01-01",
      "summary" => nil,
      "railway_type" => "heavy-rail",
      "railway_type_label" => "Heavy rail",
      "report_type" => "investigation-report",
      "report_type_label" => "Investigation report",
      "updated_at" => "2014-10-24T08:41:18Z",
      "date_of_occurrence" => "1992-04-03",
      "published_at" => "2014-10-24T08:41:18Z",
      "change_history" => [
        {
          "public_timestamp" => "2014-10-24T08:41:18Z",
          "note" => "Published the RAIB Report",
        },
      ],
    }
  )

  content_api_has_an_artefact(@slug, @artefact)
  finder_api_has_schema("raib-reports", raib_report_schema)
end

Then(/^I see the content of the RAIB report$/) do
  expect(page).to have_content(@title)
  check_metadata_value("Updated", "24 October 2014")
  check_metadata_value("Date of occurrence", "3 April 1992")
  check_metadata_value("Railway type", "Heavy rail")
  check_metadata_value("Report type", "Investigation report")
end

def raib_report_schema
  File.read(
    File.expand_path('../../fixtures/schemas/raib-reports.json', __FILE__)
  )
end
