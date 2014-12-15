require "ostruct"
require "spec_helper"

describe CmaCasePresenter do
  subject(:presenter) { CmaCasePresenter.new(schema, document) }

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
    {
      case_type: "a case type",
      case_state: "a case state",
      market_sector: "a market sector",
      outcome_type: "an outcome type",
    }
  }

  let(:schema) { double(:schema) }

  let(:schema_response) {
    {
      "foo" => {
        label: "Foo",
        values: [
          {label: 'The Bar', slug: "bar"}
        ]
      }
    }
  }

  describe "#metadata" do
    it "converts raw metadata to user friendly metadata via the schema" do
      expect(schema).to receive(:user_friendly_values)
        .with(document_details)
        .and_return(schema_response)

      presenter.metadata
    end
  end

  describe "#date_metadata" do
    let(:detail_object) do
      OpenStruct.new(
        opened_date: Date.new(2013, 9, 1),
        closed_date: Date.new(2014, 3, 1),
        published_at: published_at,
      )
    end

    specify do
      subject.date_metadata.should eq({
        "Published" => published_at,
        "Opened date" => Date.new(2013, 9, 1),
        "Closed date" => Date.new(2014, 3, 1),
      })
    end
  end
end
