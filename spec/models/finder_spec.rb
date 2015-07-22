require 'spec_helper'

describe Finder do

  describe "#user_friendly_values" do
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

    let(:formatted_attrs) {
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

    it "formats the given keys and values" do
      finder.user_friendly_values(document_attrs).should eq(formatted_attrs)
    end
  end

end
