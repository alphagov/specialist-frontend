require "ostruct"
require "spec_helper"

describe AaibReportPresenter do
  subject(:presenter) { AaibReportPresenter.new(schema, document) }

  let(:document) do
    double(
      :document,
      title: "A Document",
      updated_at: updated_at,
      details: detail_object,
    )
  end

  let(:updated_at) { DateTime.new(2014, 4, 1) }

  let(:detail_object) { double(:detail_object, detail_attributes) }

  let(:schema_attributes) {
    {
      aircraft_category: "Big Aeroplanes",
      report_type: "a report type",
    }
  }

  let(:detail_attributes) {
    schema_attributes.merge({
      aircraft_types: "some types of aircraft",
      location: "a location",
      registrations: "some registrations",
    })
  }

  let(:user_friendly_document_details) {
    {
      "Aircraft category" => "Big Aeroplanes",
      "Report type" => "a report type",
    }
  }

  let(:schema) {
    double(:schema, user_friendly_values: user_friendly_document_details)
  }

  describe "#metadata" do
    it "converts raw metadata to user friendly metadata via the schema" do
      expect(schema).to receive(:user_friendly_values)
        .with(schema_attributes)

      presenter.metadata
    end

    it "contains the extra fields that are not in the schema" do
      expect(presenter.metadata).to include(
        "Aircraft types",
        "Location",
        "Registrations",
      )
    end
  end

  describe "#date_metadata" do
    let(:detail_object) do
      OpenStruct.new(
        date_of_occurrence: Date.new(2013, 9, 1),
      )
    end

    specify do
      subject.date_metadata.should eq({
        "Updated at" => updated_at,
        "Date of occurrence" => Date.new(2013, 9, 1),
      })
    end
  end
end

