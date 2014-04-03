require 'gds_api/helpers'

class SpecialistDocumentsController < ApplicationController
  include GdsApi::Helpers

  def show
    artefact = content_api.artefact(params[:path])
    error_not_found unless artefact

    @document = DocumentPresenter.new(schema, artefact)
  end

  private

  def schema
    finder_api.get_schema("cma-cases")
  end

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end
end
