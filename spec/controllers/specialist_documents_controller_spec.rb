require 'spec_helper'

describe SpecialistDocumentsController do

  describe "GET 'show'" do
    let(:finder_api) { double(:finder_api) }
    let(:schema) { double(:schema) }
    let(:content_api) { double(:content_api) }
    let(:artefact) { double(:artefact, format: format) }
    let(:slug) { "/some-url/to-somewhere" }

    before do
      allow(controller).to receive(:finder_api) { finder_api }
      allow(controller).to receive(:content_api) { content_api }
      allow(content_api).to receive(:artefact).with(slug) { artefact }
      allow(finder_api).to receive(:get_schema) { schema }
      get :show, path: slug
    end

    context "when the document_type is cma_case" do
      let(:format) { "cma_case" }

      it "sets document with a CmaCasePresenter" do
        expect(finder_api).to have_received(:get_schema).with("cma-cases") { schema }
        assigns(:document).should be_a(CmaCasePresenter)
      end
    end

    context "when the document_type is aaib_report" do
      let(:format) { "aaib_report" }

      it "sets document with a AaibReportPresenter" do
        expect(finder_api).to have_received(:get_schema).with("aaib-reports") { schema }
        assigns(:document).should be_a(AaibReportPresenter)
      end
    end
  end

end
