require "ostruct"
require "spec_helper"

describe CmaCasePresenter do
  subject(:presenter) { CmaCasePresenter.new(finder, document) }

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
      case_type: "ca98-and-civil-cartels",
      market_sector: "aerospace",
      case_state: "open",
      outcome_type: "ca98-commitment",
    }
  }

  let(:finder) { OpenStruct.new(
    base_path: "/cma-cases",
    details: OpenStruct.new(
      beta: false,
      beta_message: nil,
      facets: [
        OpenStruct.new(
          key: "case_type",
          name: "Case type",
          allowed_values: [
            OpenStruct.new(
              label: "CA98 and civil cartels",
              value: "ca98-and-civil-cartels"
            )
          ]
        ),
        OpenStruct.new(
          key: "market_sector",
          name: "Market sector",
          allowed_values: [
            OpenStruct.new(
              label: "Aerospace",
              value: "aerospace"
            )
          ]
        ),
        OpenStruct.new(
          key: "case_state",
          name: "Case state",
          allowed_values: [
            OpenStruct.new(
              label: "Open",
              value: "open"
            )
          ]
        ),
        OpenStruct.new(
          key: "outcome_type",
          name: "Outcome type",
          allowed_values: [
            OpenStruct.new(
              label: "CA98 commitment",
              value: "ca98-commitment"
            )
          ]
        ),
      ]
    )
  ) }

  let(:finder_response) {
    {
      "case_type" => {
        label: "Case type",
        values: [
          {label: "CA98 and civil cartels", slug: "ca98-and-civil-cartels"}
        ]
      },
      "market_sector" => {
        label: "Market sector",
        values: [
          {label: "Aerospace", slug: "aerospace"}
        ]
      }
    }
  }

  describe "#metadata" do
    it "converts raw metadata to user friendly metadata via the finder" do
      expect(finder).to receive(:user_friendly_values)
        .with(document_details)
        .and_return(finder_response)

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
