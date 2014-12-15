require "ostruct"
require "spec_helper"

describe DocumentPresenter do

  subject(:presenter) {
    Class.new(DocumentPresenter) {

      delegate :foo, :bar, to: :"document.details"

      private
      def filterable_metadata
        {
          foo: foo,
        }
      end

      def extra_metadata
        {
          "Bar" => bar,
        }
      end

      def finder_path
        '/finder'
      end

    }.new(schema, document)
  }

  let(:document) do
    double(
      :document,
      title: document_title,
      details: document_details,
    )
  end

  let(:document_title) { "A Document" }
  let(:document_published_at) { 3.days.ago }
  let(:document_details) { double(:document_details, all_attributes) }
  let(:filterable_attributes) { { foo: foo } }
  let(:extra_attributes) { { bar: bar } }
  let(:all_attributes) {
    filterable_attributes.merge(extra_attributes).merge({
      published_at: document_published_at,
      bulk_published: false,
    })
  }

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

  let(:foo) { "bar" }
  let(:bar) { "qux" }
  let(:schema) { double(:schema) }

  describe "#metadata" do
    before do
      allow(schema).to receive(:user_friendly_values).and_return(schema_response)
    end

    context "when all attributes present" do
      it "converts raw metadata to user friendly metadata via the schema" do
        presenter.metadata

        expect(schema).to have_received(:user_friendly_values).with(filterable_attributes)
      end

      it "returns user-friendly metadata" do
        metadata = presenter.metadata
        expect(metadata.size).to eq(2)

        linkable = metadata.select { |m| m.label == "Foo" }.first
        linkable_value = linkable.values.first

        expect(linkable_value.linkable?).to eq(true)
        expect(linkable_value.href).to eq("/finder?foo%5B%5D=bar")

        unlinkable = metadata.select { |m| m.label == "Bar" }.first
        unlinkable_value = unlinkable.values.first

        expect(unlinkable_value.linkable?).to eq(false)
      end
    end

    context "when some attributes are blank" do
      let(:foo) { "" }

      it "excludes them" do
        presenter.metadata

        expect(schema).to have_received(:user_friendly_values)
          .with(filterable_attributes.except(:foo))
      end
    end
  end

  describe "#date_metadata" do
    context "with all attributes present" do
      let(:document_published_at) { DateTime.new(2014, 4, 1) }

      specify do
        subject.date_metadata.should eq({
          "Updated" => DateTime.new(2014, 4, 1),
        })
      end
    end
  end

  describe "details" do
    it "returns the headers if there are some" do
      headers_array = ['blah']
      filterable_attributes.merge!(headers: ['blah'])
      expect(presenter.headers).to eq(headers_array)
    end

    it "returns an empty array if there is no headers in the details hash" do
      allow(document_details).to receive(:headers) { nil }
      expect(presenter.headers).to eq([])
    end
  end
end
