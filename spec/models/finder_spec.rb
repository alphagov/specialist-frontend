require 'spec_helper'

describe Finder do

  describe "#user_friendly" do
    let(:cma_cases_finder) {
      OpenStruct.new(
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
      finder.user_friendly(document_attrs).should eq(attrs_with_expanded_keys_and_values)
    end

    it "doesn't alter the values if disabled (used for things without 'allowed_values', like dates)" do
      finder.user_friendly(document_attrs, change_values: false).should eq(attrs_with_expanded_keys)
    end
  end

end
