require 'ostruct'
require 'spec_helper'

describe DocumentPresenter do
  subject { DocumentPresenter.new(document) }

  let(:document) do
    OpenStruct.new(title: document_title,
                   updated_at: document_updated_at,
                   details: document_details)
  end

  let(:document_title) { 'A Document' }
  let(:document_updated_at) { 3.days.ago }
  let(:document_details) { OpenStruct.new }

  describe '#metadata' do
    context 'with all attributes present' do
      let(:document_details) do
        OpenStruct.new(
          market_sector: 'Energy',
          case_type: 'Merger',
          case_state: 'closed',
          outcome_type: 'Referred',
        )
      end

      specify do
        subject.metadata.should == {
          'Market sector' => 'Energy',
          'Case type' => 'Merger',
          'Case state' => 'Closed',
          'Outcome type' => 'Referred',
        }
      end
    end

    context 'with outcome type blank' do
      let(:document_details) do
        OpenStruct.new(
          market_sector: 'Energy',
          case_type: 'Merger',
          case_state: 'closed',
          outcome_type: nil,
        )
      end

      specify do
        subject.metadata.should == {
          'Market sector' => 'Energy',
          'Case type' => 'Merger',
          'Case state' => 'Closed',
        }
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
