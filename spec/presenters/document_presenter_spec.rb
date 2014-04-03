require 'ostruct'
require 'spec_helper'

describe DocumentPresenter do
  subject(:presenter) { DocumentPresenter.new(schema, document) }

  let(:document) do
    double(
      :document,
      title: document_title,
      updated_at: document_updated_at,
      details: document_details,
    )
  end

  let(:document_title) { 'A Document' }
  let(:document_updated_at) { 3.days.ago }
  let(:schema) { double(:schema) }

  describe '#metadata' do
    let(:document_case_type) { double(:document_case_type) }
    let(:user_friendly_metadata) { double(:user_friendly_metadata) }
    let(:document_details) { double(:document_details, document_details_attrs) }
    let(:document_details_attrs) {
      {
        case_type: "a case type",
        case_state: "a case state",
        market_sector: "a market sector",
        outcome_type: "an outcome type",
      }
    }

    before do
      allow(schema).to receive(:user_friendly_values)
        .and_return(user_friendly_metadata)
    end

    context 'when all attributes present' do
      it "converts raw metadata to user friendly metadata via the schema" do
        presenter.metadata

        expect(schema).to have_received(:user_friendly_values)
          .with(document_details_attrs)
      end

      it "returns user-friendly metadata" do
        expect(presenter.metadata).to eq(user_friendly_metadata)
      end
    end

    context 'when some attributes are blank' do
      let(:document_details_attrs) {
        {
          case_type: "a case type",
          case_state: "a case state",
          market_sector: "a market sector",
          outcome_type: "",
        }
      }

      it "excludes them" do
        presenter.metadata

        expect(schema).to have_received(:user_friendly_values)
          .with(document_details_attrs.except(:outcome_type))
      end
    end
  end

  describe '#date_metadata' do
    let(:document_updated_at) { DateTime.new(2014, 4, 1) }

    context 'with all attributes present' do
      let(:document_details) do
        OpenStruct.new(
          opened_date: Date.new(2013, 9, 1),
          closed_date: Date.new(2014, 3, 1),
        )
      end

      specify do
        subject.date_metadata.should == {
          'Opened date' => Date.new(2013, 9, 1),
          'Closed date' => Date.new(2014, 3, 1),
          'Updated at' => DateTime.new(2014, 4, 1),
        }
      end
    end

    context 'with closed date blank' do
      let(:document_details) do
        OpenStruct.new(
          opened_date: Date.new(2013, 9, 1),
          closed_date: nil,
        )
      end

      specify do
        subject.date_metadata.should == {
          'Opened date' => Date.new(2013, 9, 1),
          'Updated at' => DateTime.new(2014, 4, 1),
        }
      end
    end
  end
end
