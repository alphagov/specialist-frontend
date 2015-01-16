require "ostruct"
require "spec_helper"

describe AaibReportPresenter do
  subject(:presenter) { AaibReportPresenter.new(finder, document) }

  let(:document) do
    double(
      :document,
      title: "A Document",
      details: detail_object,
    )
  end

  let(:published_at) { DateTime.new(2014, 4, 1) }

  let(:detail_object) { double(:detail_object, document_details) }

  let(:document_details) {
    filterable_metadata.merge(extra_metadata)
  }

  let(:filterable_metadata) {
    {
      aircraft_category: "Big Aeroplanes",
      report_type: "a report type",
    }
  }

  let(:extra_metadata) {
    {
      aircraft_type: "Jumbo Jets and Kitchenettes",
      registration: ["G-BAOZ", "G-BIVE"],
      location: "Just outside Slough",
    }
  }

  let(:finder) { OpenStruct.new(
    base_path: "/aaib-reports",
    details: OpenStruct.new(
      beta: false,
      beta_message: nil,
      facets: [
        OpenStruct.new(
          key: "aircraft_category",
          name: "Aircraft category",
          allowed_values: [
            OpenStruct.new(
              label: "Big Aeroplanes",
              value: "big-aeroplanes"
            )
          ]
        ),
        OpenStruct.new(
          key: "report_type",
          name: "Report type",
          allowed_values: [
            OpenStruct.new(
              label: "a report type",
              value: "a-report-type"
            )
          ]
        ),
      ]
    )
  ) }

  let(:finder_response) {
    {
      "aircraft_category" => {
        label: "Aircraft category",
        values: [
          {label: "Big Aeroplanes", slug: "big-aeroplanes"}
        ]
      },
      "report_type" => {
        label: "Report type",
        values: [
          {label: "a report type", slug: "a-report-type"}
        ]
      }
    }
  }


  describe "#metadata" do
    it "converts raw metadata to user friendly metadata via the schema" do
      expect(finder).to receive(:user_friendly_values)
        .with(filterable_metadata)
        .and_return(finder_response)

      presenter.metadata
    end
  end

  describe "#date_metadata" do
    let(:detail_object) do
      OpenStruct.new(
        date_of_occurrence: Date.new(2013, 9, 1),
        published_at: published_at,
      )
    end

    specify do
      subject.date_metadata.should eq({
        "Published" => published_at,
        "Date of occurrence" => Date.new(2013, 9, 1),
      })
    end
  end
end

