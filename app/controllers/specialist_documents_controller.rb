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
    when "cma_case"
      CmaCasePresenter.new(schema("cma-cases"), artefact)
    when "international_development_fund"
      InternationalDevelopmentFundPresenter.new(schema("international-development-funding"), artefact)
    when "aaib_report"
      AaibReportPresenter.new(schema("aaib-reports"), artefact)
    else
      DocumentPresenter.new(NullSchema.new, artefact)
    end
  end

  class NullSchema
    def user_friendly_values(input)
      input
    end
  end

end
