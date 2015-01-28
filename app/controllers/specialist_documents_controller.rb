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

  def finder(slug)
    Finder.new(content_store.content_item("/#{slug}"))
  end

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end

  def document_presenter(artefact)
    case artefact.format
    when "aaib_report"
      AaibReportPresenter.new(finder("aaib-reports"), artefact)
    when "cma_case"
      CmaCasePresenter.new(finder("cma-cases"), artefact)
    when "drug_safety_update"
      DrugSafetyUpdatePresenter.new(finder("drug-safety-update"), artefact)
    when "international_development_fund"
      InternationalDevelopmentFundPresenter.new(finder("international-development-funding"), artefact)
    when "maib_report"
      MaibReportPresenter.new(finder("maib-reports"), artefact)
    when "medical_safety_alert"
      MedicalSafetyAlertPresenter.new(finder("drug-device-alerts"), artefact)
    when "raib_report"
      RaibReportPresenter.new(finder("raib-reports"), artefact)
    else
      DocumentPresenter.new(NullSchema.new, artefact)
    end
  end

  class NullSchema
    def user_friendly_values(input)
      input
    end
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
