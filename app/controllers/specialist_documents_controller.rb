require 'gds_api/helpers'

class SpecialistDocumentsController < ApplicationController
  include GdsApi::Helpers
  rescue_from GdsApi::HTTPForbidden, with: :error_403
  rescue_from GdsApi::HTTPNotFound, with: :error_not_found

  def show
    document = content_store.content_item(base_path)

    if document.schema_name != 'gone'
      expires_in(cache_time(document), public: true)
      @document = document_presenter(finder, document)
    else
      error_not_found
    end
  end

private

  def document_presenter(finder, document)
    case document.document_type
    when "drug_safety_update"
      DrugSafetyUpdatePresenter.new(finder, document)
    else
      DocumentPresenter.new(finder, document)
    end
  end

  def cache_time(document)
    document['details']['max_cache_time'] || DEFAULT_CACHE_TIME_IN_SECONDS
  end

  def finder
    Finder.new(content_store.content_item("/#{params[:path].split('/')[0]}"))
  end

  def error_not_found
    render status: :not_found, plain: "404 error not found"
  end

  def base_path
    "/#{params[:path]}"
  end

  def error_403(exception)
    render plain: exception.message, status: 403
  end
end
