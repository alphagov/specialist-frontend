  require "ostruct"
require "spec_helper"

describe CmaCasePresenter do

  subject(:presenter) {
    Class.new(DocumentPresenter) {

      delegate :foo, to: :"document.details"

      private
      def extra_raw_metadata
        {
          foo: foo,
        }
      end

    }.new(schema, document)
  }

  let(:document) do
    double(
      :document,
      title: document_title,
      updated_at: document_updated_at,
      details: document_details,
    )
  end

  let(:document_title) { "A Document" }
  let(:document_updated_at) { 3.days.ago }
  let(:document_details) { double(:document_details, details_attributes) }
  let(:details_attributes) { { foo: foo } }
  let(:foo) { "Bar" }
  let(:schema) { double(:schema) }

  describe "#metadata" do
    before do
      allow(schema).to receive(:user_friendly_values).and_return(details_attributes)
    end

    context "when all attributes present" do
      it "converts raw metadata to user friendly metadata via the schema" do
        presenter.metadata

        expect(schema).to have_received(:user_friendly_values).with(details_attributes)
      end

      it "returns user-friendly metadata" do
        expect(presenter.metadata).to eq(details_attributes)
      end
    end

    context "when some attributes are blank" do
      let(:foo) { "" }

      it "excludes them" do
        presenter.metadata

        expect(schema).to have_received(:user_friendly_values)
          .with(details_attributes.except(:foo))
      end
    end
  end

  describe "#date_metadata" do
    context "with all attributes present" do
      let(:document_updated_at) { DateTime.new(2014, 4, 1) }

      specify do
        subject.date_metadata.should eq({
          "Updated at" => DateTime.new(2014, 4, 1),
        })
      end
    end

    context "with closed date blank" do
      let(:document_updated_at) { nil }

      specify do
        subject.date_metadata.should eq({})
      end
    end
  end
end
