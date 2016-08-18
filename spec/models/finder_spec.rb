require 'spec_helper'

RSpec.describe Finder do

  describe "#user_friendly" do
    let(:cma_cases_finder) {
      OpenStruct.new(
        base_path: '/cma-cases',
        title: 'Competition and Markets Authority cases',
        details: OpenStruct.new(
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
            )
          ]
        )
      )
    }
    let(:finder) { Finder.new(cma_cases_finder)}

    let(:document_attrs) {
      {
        case_type: "ca98-and-civil-cartels",
        market_sector: "aerospace",
      }
    }

    let(:attrs_with_expanded_keys_and_values) {
      {
        "case_type" => {
          :label => "Case type",
          :values => [
            {
              :label => "CA98 and civil cartels",
              :slug => "ca98-and-civil-cartels"
            }
          ]
        },
        "market_sector" => {
          :label => "Market sector",
          :values => [
            {
              :label => "Aerospace",
              :slug=>"aerospace"
            }
          ]
        }
      }
    }

    let(:attrs_with_expanded_keys) {
      {
        "case_type" => {
          :label => "Case type",
          :values => "ca98-and-civil-cartels",
        },
        "market_sector" => {
          :label => "Market sector",
          :values => "aerospace",
        }
      }
    }

    it "formats the given keys and values by default" do
      expect(finder.user_friendly(document_attrs)).to eq(attrs_with_expanded_keys_and_values)
    end

    it "doesn't alter the values if disabled (used for things without 'allowed_values', like dates)" do
      expect(finder.user_friendly(document_attrs, change_values: false)).to eq(attrs_with_expanded_keys)
    end

    let(:bad_document_attrs) {
      {
        case_type: "not-a-case-type",
        market_sector: "not-a-market-sector",
      }
    }

    it "sends an error via Airbrake when given incorrect document attrs" do
      expect(Airbrake).to receive(:notify_or_ignore).twice.with(Finder::ValueNotFoundError)
      finder.user_friendly(bad_document_attrs)
    end
  end

end
