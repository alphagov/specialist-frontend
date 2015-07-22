require "ostruct"
require "spec_helper"

describe DocumentPresenter do

  subject {
    DocumentPresenter.new(finder, document)
  }

  let(:finder) {
    OpenStruct.new(
      base_path: "/finder",
      format_name: "Finder"
    )
  }

  let(:document) do
    double(
      :document,
      title: "A Document Title",
      details: document_details,
    )
  end

  let(:document_published_at) { 3.days.ago }
  let(:document_details) { double(:document_details, all_attributes) }

  let(:filterable_attributes) {
    {
      meal_type: "lunch",
      food: "burger",
    }.with_indifferent_access
  }
  let(:extra_attributes) {
    {
      location: "Big Kahuna Burger"
    }
  }

  let(:all_attributes) {
    filterable_attributes.merge(extra_attributes).merge({
      published_at: document_published_at,
      bulk_published: false,
      change_history: [],
    })
  }

  let(:user_friendly_values) {
    {
      "meal_type" => {
        label: "Meal type",
        values: [
          {label: "Lunch", slug: "lunch"}
        ]
      },
      "food" => {
        label: "Food",
        values: [
          {label: "Burger", slug: "burger"}
        ]
      }
    }
  }

  let(:facets) {
    [
      OpenStruct.new(
        type: "text",
        filterable: true,
        name: "Meal type",
        key: "meal_type",
        allowed_values: [
          OpenStruct.new(
            label: "Breakfast",
            value: "breakfast"
          ),
          OpenStruct.new(
            label: "Lunch",
            value: "lunch"
          ),
          OpenStruct.new(
            label: "Dinner",
            value: "dinner"
          )
        ]
      ),
      OpenStruct.new(
        type: "text",
        filterable: true,
        name: "Food",
        key: "food",
        allowed_values: [
          OpenStruct.new(
            label: "Burrito",
            value: "burrito"
          ),
          OpenStruct.new(
            label: "Sushi",
            value: "sushi"
          ),
          OpenStruct.new(
            label: "Burger",
            value: "burger"
          )
        ]
      ),
      OpenStruct.new(
        type: "text",
        filterable: false,
        name: "Location",
        key: "location",
      ),
    ]
  }

  before do
    allow(finder).to receive(:facets).and_return(facets)
    allow(finder).to receive(:date_facets).and_return(facets.select{ |f| f.type == 'date' })
    allow(finder).to receive(:text_facets).and_return(facets.select{ |f| f.type == 'text' })
  end

  describe "#metadata" do
    before do
      allow(finder).to receive(:user_friendly_values).and_return(user_friendly_values)
    end

    context "when all attributes present" do
      it "converts raw metadata to user friendly metadata via the finder" do
        subject.metadata

        expect(finder).to have_received(:user_friendly_values).with(filterable_attributes)
      end

      it "returns user-friendly metadata" do
        metadata = subject.metadata
        expect(metadata.size).to eq(3)

        linkable = metadata.select { |m| m.label == "Meal type" }.first
        linkable_value = linkable.values.first

        expect(linkable_value.linkable?).to eq(true)
        expect(linkable_value.href).to eq("/finder?meal_type%5B%5D=lunch")

        unlinkable = metadata.select { |m| m.label == "Location" }.first
        unlinkable_value = unlinkable.values.first

        expect(unlinkable_value.linkable?).to eq(false)
      end
    end

    context "when some attributes are blank" do
      let(:starter) {
        {
          "starter" => ""
        }
      }

      it "excludes them" do
        filterable_attributes.merge(starter)
        subject.metadata

        expect(finder).to have_received(:user_friendly_values)
          .with(filterable_attributes.except(:starter))
      end
    end
  end

  describe "#date_metadata" do
    context "with all attributes present" do
      let(:document_published_at) { DateTime.new(2014, 4, 1) }

      specify do
        subject.date_metadata.should eq({
          "Published" => DateTime.new(2014, 4, 1),
        })
      end
    end
  end

  describe "details" do
    it "returns the headers if there are some" do
      headers_array = ['blah']
      filterable_attributes.merge!(headers: ['blah'])
      expect(subject.headers).to eq(headers_array)
    end

    it "returns an empty array if there is no headers in the details hash" do
      allow(document_details).to receive(:headers) { nil }
      expect(subject.headers).to eq([])
    end
  end
end
