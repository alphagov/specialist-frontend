require 'spec_helper'

RSpec.describe SpecialistDocumentsController, type: :controller do
  it "gets item from content store" do
    stub_specialist_document
    stub_finder

    get :show, params: { path: 'aaib-report/plane-took-off-by-mistake' }
    expect(assigns["document"].title).to eq("The plane took off by mistake")
    expect(response.cache_control[:max_age]).to eq(30)
  end

  it "gets item from content store without max cache time and sets default cache time" do
    stub_specialist_document_without_max_cache_time
    stub_finder

    get :show, params: { path: 'aaib-report/plane-took-off-by-mistake' }
    expect(response.cache_control[:max_age]).to eq(10)
  end

  it "returns 404 for item not in content store" do
    path = 'government/case-studies/boost-chocolate-production'
    content_store_does_not_have_item('/' + path)

    get :show, params: { path: path }
    expect(response.status).to eq(404)
  end

  it "returns 403 for access-limited item" do
    path = 'aaib-reports/super-sekrit-document'
    url = Plek.current.find('content-store') + "/content/" + path
    stub_request(:get, url).to_return(status: 403, headers: {})

    get :show, params: { path: path }
    expect(response.status).to eq(403)
  end
end
