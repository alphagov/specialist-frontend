require 'gds_api/helpers'

class SpecialistDocumentsController < ApplicationController
  include GdsApi::Helpers

  def show
    artefact = content_api.artefact(params[:path])

    if artefact
      @document = document(finder, artefact)
    else
      error_not_found
    end
  end

private

  def document(finder, artefact)
    case artefact.format
    when "drug_safety_update"
      DrugSafetyUpdatePresenter.new(finder, artefact)
    else
      DocumentPresenter.new(finder, artefact)
    end
  end

  def finder
    Finder.new(content_store.content_item("/#{params[:path].split('/')[0]}"))
  end

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end

  def set_robots_headers
    if finders_excluded_from_robots.include?(request.path.split('/')[1])
      response.headers["X-Robots-Tag"] = "none"
    end
  end

  def finders_excluded_from_robots
    [
      'aaib-reports',
      'maib-reports',
      'raib-reports',
    ]
  end

end
