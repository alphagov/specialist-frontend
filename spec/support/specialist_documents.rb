require 'gds_api/test_helpers/content_store'

module SpecialistDocumentHelpers
  include GdsApi::TestHelpers::ContentStore

  def stub_specialist_document
    base_path = "/aaib-report/plane-took-off-by-mistake"
    content_store_has_item(base_path, {
      base_path: base_path,
      title: "The plane took off by mistake",
      format: "specialist_document",
      public_updated_at: Time.zone.now,
      details: {
        metadata: {
          document_type: "aaib_report"
        },
        max_cache_time: 30
      }
    })
  end

  def stub_specialist_document_without_max_cache_time
    base_path = "/aaib-report/plane-took-off-by-mistake"
    content_store_has_item(base_path, {
      base_path: base_path,
      title: "The plane took off by mistake",
      format: "specialist_document",
      public_updated_at: Time.zone.now,
      details: {
       metadata: {
         document_type: "aaib_report",
       },
      }
    })
  end

  def stub_finder
    base_path = "/aaib-report"
    content_store_has_item(base_path, {
      base_path: base_path,
      format: "finder"
    })
  end
end

RSpec.configuration.include SpecialistDocumentHelpers
