require 'spec_helper'

describe SpecialistDocumentsController, type: :controller do
  it "gets item from content store" do
    stub_specialist_document
    stub_finder

    get :show, path: "aaib-report/plane-took-off-by-mistake"
    expect(assigns["document"].title).to eq("The plane took off by mistake")
  end

  it "returns 404 for item not in content store" do
    path = 'government/case-studies/boost-chocolate-production'
    content_store_does_not_have_item('/' + path)

    get :show, path: path
    expect(response.status).to eq(404)
  end
end
