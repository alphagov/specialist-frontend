require 'gds_api/helpers'

class SpecialistDocumentsController < ApplicationController
  include GdsApi::Helpers
  rescue_from GdsApi::HTTPForbidden, with: :error_403

  def show
    if (document = content_store.content_item(base_path)) && document['format'] != 'gone'
      expires_in(cache_time(document), public: true)
      @document = document_presenter(finder, document)
    else
      error_not_found
    end
  end

private

  def document_presenter(finder, document)
    case document['format']
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
    render status: :not_found, text: "404 error not found"
  end

  def base_path
    "/#{params[:path]}"
  end

  def error_403(exception)
    render text: exception.message, status: 403
  end
end
