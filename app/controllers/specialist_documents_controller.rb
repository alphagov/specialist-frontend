require 'gds_api/helpers'

class SpecialistDocumentsController < ApplicationController
  include GdsApi::Helpers

  def show
    artefact = content_api.artefact(params[:path])

    if artefact
      @document = document_presenter(artefact)
    else
      error_not_found
    end
  end

private

  def schema(name)
    finder_api.get_schema(name)
  end

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end

  def document_presenter(artefact)
    case artefact.format
    when "cma_case", "specialist-document"
      # TODO: Remove 'specialist-document' once docs
      # have been republished and panopticon has correct 'format'.
      CmaCasePresenter.new(schema("cma-cases"), artefact)
    when "aaib_report"
      AaibReportPresenter.new(schema("aaib-reports"), artefact)
    end
  end

end
