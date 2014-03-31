require 'gds_api/helpers'

class SpecialistDocumentsController < ApplicationController
  include GdsApi::Helpers

  def show
    artefact = content_api.artefact(params[:path])
    error_not_found unless artefact

    @document = DocumentPresenter.new(artefact)
  end

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end
end
