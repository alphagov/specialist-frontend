Given(/^a published AAIB report exists$/) do
  @title = "Grob G115, G-BPKG, 3 April 1992"
  @slug = slug_from_title(@title)
  @artefact = create_aaib_report(@slug)
end

Then(/^I see the content of the AAIB report$/) do
  expect(page).to have_content(@title)
  check_metadata_value("Published", "24 October 2014")
  check_metadata_value("Date of occurrence", "3 April 1992")
  check_metadata_value("Aircraft category", "General aviation - fixed wing")
  check_metadata_value("Report type", "Bulletin - Pre-1997 uncategorised monthly report")
  check_metadata_value("Aircraft type", "Grob G115")
  check_metadata_value("Location", "Loch Muick near Ballater, Scotland")
  check_metadata_value("Registration", "G-BPKG")
end

Given(/^a published AAIB report with a major change exists$/) do
  @title = "Grob G115, G-BPKG, 3 April 1992"
  @slug = slug_from_title(@title)
  @artefact = create_aaib_report(@slug, major_changes: 2)
end

Then(/^I see the content of the republished AAIB report$/) do
  expect(page).to have_content(@title)
  check_metadata_value("Updated", "24 October 2014")
end

def aaib_reports_finder
  File.read(
    File.expand_path('../../fixtures/finders/aaib-reports.json', __FILE__)
  )
end

def create_aaib_report(slug, major_changes: 1)
  base_time = Time.mktime(2013, 10, 24)

  change_history = major_changes.times.map do |x|
    {
      "public_timestamp" => base_time + x.months,
      "note" => "Published the AAIB report - #{x}",
    }
  end

  artefact = artefact_for_slug(@slug).merge(
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
      "change_history" => change_history,
    }
  )

  content_api_has_an_artefact(slug, artefact)
  content_store_has_item("/aaib-reports", aaib_reports_finder)
end
