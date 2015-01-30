require 'spec_helper'
require 'gds_api/test_helpers/content_store'
include GdsApi::TestHelpers::ContentStore

describe SpecialistDocumentsController do

  describe "GET 'show'" do
    let(:finder) { double(:finder) }
    let(:content_api) { double(:content_api) }
    let(:format) { "aaib_report" }
    let(:artefact) { double(:artefact, format: format) }
    let(:content_item) { double(:content_item) }
    let(:slug) { "aaib-reports/an-air-accident" }

    before do
      allow(controller).to receive(:finder) { finder }
      allow(finder).to receive(:document_type) { "document_type" }
      allow(controller).to receive(:content_api) { content_api }
      allow(content_api).to receive(:artefact).with(slug) { artefact }
      content_store_has_item('/aaib-reports', content_item)
      get :show, path: slug
    end

    context "excluded from search engines" do
      it "sets the correct header" do
        expect(response.headers["X-Robots-Tag"]).should eq("none")
      end
    end
  end

end
