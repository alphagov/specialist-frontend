require "ostruct"
require "spec_helper"

RSpec.describe DocumentPresenter do

  subject {
    DocumentPresenter.new(finder, document)
  }

  let(:finder) {
    OpenStruct.new(
      base_path: "/finder",
      title: "Finder documents",
      format_name: "Finder",
      facets: facets,
      date_facets: date_facets,
      text_facets: text_facets,
    )
  }

  let(:document) do
    double(
      :document,
      title: "A Document Title",
      details: document_details,
      public_updated_at: document_published_at,
    )
  end

  let(:document_published_at) { 3.days.ago }
  let(:document_details) {
    double(:document_details,
      metadata: metadata,
      change_history: [],
    )
  }

  let(:metadata) {
    filterable_attributes.merge(extra_attributes).merge(date_attributes).merge(
      bulk_published: false
    )
  }

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
  let(:date_attributes) {
    {
      day_of_meal: "2015-03-21"
    }
  }

  let(:user_friendly_filterable_attributes) {
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

  let(:user_friendly_extra_attributes) {
    {
      "location" => {
        label: "Location",
        values: "Big Kahuna Burger"
      },
    }
  }

  let(:user_friendly_dates) {
    {
      "day_of_meal" => {
        label: "Day of meal",
        values: "2015-03-21",
      },
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
      OpenStruct.new(
        type: "date",
        filterable: false,
        name: "Day of meal",
        key: "day_of_meal",
      )
    ]
  }

  let(:date_facets) {
    facets.select{ |f| f.type == 'date' }
  }

  let(:text_facets) {
    facets.select{ |f| f.type == 'text' }
  }

  before do
    allow(finder).to receive(:user_friendly)
      .with(filterable_attributes.stringify_keys, change_values: true)
      .and_return(user_friendly_filterable_attributes)

    allow(finder).to receive(:user_friendly)
      .with(extra_attributes.stringify_keys, change_values: false)
      .and_return(user_friendly_extra_attributes)

    allow(finder).to receive(:user_friendly)
      .with(date_attributes.stringify_keys, change_values: false)
      .and_return(user_friendly_dates)
  end

  describe "#metadata" do
    context "when all attributes present" do
      it "converts raw metadata to user friendly metadata via the finder, including values" do
        subject.metadata

        expect(finder).to have_received(:user_friendly).with(filterable_attributes, change_values: true)
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

        expect(finder).to have_received(:user_friendly)
          .with(filterable_attributes.except(:starter), change_values: true)
      end
    end
  end

  describe "#date_metadata" do
    context "with all attributes present" do
      let(:document_published_at) { DateTime.new(2014, 4, 1) }

      specify do
        expect(subject.date_metadata).to eql({
          "published" => {
            label: "Published",
            values: DateTime.new(2014, 4, 1),
          },
          "day_of_meal" => {
            label: "Day of meal",
            values: "2015-03-21",
          },
        })
      end
    end
  end

  describe "details" do
    it "returns the headers if there are some" do
      headers_array = ['blah']
      allow(document_details).to receive(:headers) { ['blah'] }
      expect(subject.headers).to eq(headers_array)
    end

    it "returns an empty array if there is no headers in the details hash" do
      allow(document_details).to receive(:headers) { nil }
      expect(subject.headers).to eq([])
    end
  end

  describe "bulk_published" do
    it "returns the value of bulk_published" do
      expect(subject.bulk_published).to eq false
    end
  end

  describe "breadcrumbs" do
    it "returns the breadcrumbs for the document" do
      breadcrumbs_array = [
        {
          "title": "Home",
          "url": "/",
        },
        {
          "title": "Finder documents",
          "url": "/finder",
        },
      ]
      expect(subject.breadcrumbs).to eq(breadcrumbs_array)
    end
  end

  describe "organisations" do
    let(:links) do
      [
        OpenStruct.new(content_id: SecureRandom.uuid),
        OpenStruct.new(content_id: SecureRandom.uuid),
      ]
    end

    context "when the finder has organisations links" do
      before do
        finder.links = OpenStruct.new(
          organisations: links,
        )
      end

      it "it returns the finder links" do
        expect(subject.organisations).to be(finder.links.organisations)
      end
    end

    context "when the finder has links but no organisations ones" do
      before do
        finder.links = OpenStruct.new(
          different_links: links,
        )
      end

      it "returns an empty array" do
        expect(subject.organisations).to eq([])
      end
    end

    context "when the finder has no links" do
      before { finder.links = nil }

      it "returns an empty array" do
        expect(subject.organisations).to eq([])
      end
    end
  end
end
