require 'spec_helper'

describe SpecialistDocumentsController do

  describe "GET 'show'" do
    let(:finder) { double(:finder) }
    let(:content_api) { double(:content_api) }
    let(:artefact) { double(:artefact, format: format) }
    let(:slug) { "/some-url/to-somewhere" }

    before do
      allow(controller).to receive(:finder) { finder }
      allow(controller).to receive(:content_api) { content_api }
      allow(content_api).to receive(:artefact).with(slug) { artefact }
      get :show, path: slug
    end

    context "when the document_type is cma_case" do
      let(:format) { "cma_case" }

      let(:cma_cases_content_item) { double(:cma_cases_content_item) }

      it "sets document with a CmaCasePresenter" do
        expect(controller).to have_received(:finder).with("cma-cases")
        assigns(:document).should be_a(CmaCasePresenter)
      end
    end

    context "when the document_type is aaib_report" do
      let(:format) { "aaib_report" }

      let(:aaib_reports_content_item) { double(:aaib_reports_content_item) }

      it "sets document with a AaibReportPresenter" do
        expect(controller).to have_received(:finder).with("aaib-reports")
        assigns(:document).should be_a(AaibReportPresenter)
      end
    end

    context "excluded from search engines" do
      let(:format) { "aaib_report" }
      let(:slug) { "aaib-reports/an-air-accident" }

      it "sets the correct header" do
        expect(response.headers["X-Robots-Tag"]).should eq("none")
      end
    end
  end

end
