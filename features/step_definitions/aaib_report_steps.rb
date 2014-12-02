Given(/^a published AAIB report exists$/) do
  @title = "Grob G115, G-BPKG, 3 April 1992"
  @slug = slug_from_title(@title)

  @artefact = artefact_for_slug(@slug).merge(
    "title" => @title,
    "format" => "aaib_report",
    "details" => {
      "body" => "<p>Body content</p>\n",
      "summary" => 'Summary of AAIB report',
      "date_of_occurrence" => "2014-01-01",
      "summary" => nil,
      "aircraft_category" => ["general-aviation-fixed-wing"],
      "aircraft_category_label" => nil,
      "report_type" => "pre-1997-monthly-report",
      "report_type_label" => "Bulletin - Pre-1997 uncategorised monthly report",
      "updated_at" => "2014-10-24T08:41:18Z",
      "date_of_occurrence" => "1992-04-03",
      "location" => "Loch Muick near Ballater, Scotland",
      "aircraft_type" => "Grob G115",
      "registration" => "G-BPKG",
      "published_at" => "2014-10-24T08:41:18Z",
      "change_history" => [
        {
          "public_timestamp" => "2014-10-24T08:41:18Z",
          "note" => "Published the AAIB Report",
        },
      ],
    }
  )

  content_api_has_an_artefact(@slug, @artefact)
  finder_api_has_schema("aaib-reports", aaib_report_schema)
end

Then(/^I see the content of the AAIB report$/) do
  expect(page).to have_content(@title)
  check_metadata_value("Updated at", "24 October 2014")
  check_metadata_value("Date of occurrence", "3 April 1992")
  check_metadata_value("Aircraft category", "General aviation - fixed wing")
  check_metadata_value("Report type", "Bulletin - Pre-1997 uncategorised monthly report")
  check_metadata_value("Aircraft type", "Grob G115")
  check_metadata_value("Location", "Loch Muick near Ballater, Scotland")
  check_metadata_value("Registration", "G-BPKG")
end

def aaib_report_schema
  File.read(
    File.expand_path('../../fixtures/schemas/aaib-reports.json', __FILE__)
  )
end
