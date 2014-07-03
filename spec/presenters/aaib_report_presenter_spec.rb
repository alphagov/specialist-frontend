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

  let(:detail_object) { double(:detail_object, document_details) }

  let(:document_details) {
    {
      aircraft_category: "Big Aeroplanes",
      report_type: "a report type",
    }
  }

  let(:schema) { double(:schema) }

  describe "#metadata" do
    it "converts raw metadata to user friendly metadata via the schema" do
      expect(schema).to receive(:user_friendly_values)
        .with(document_details)

      presenter.metadata
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

