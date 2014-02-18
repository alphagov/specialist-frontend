require 'gds_api/helpers'

class SpecialistDocumentsController < ApplicationController
  include GdsApi::Helpers

  def show
    @document = content_api.artefact(params[:path])
    error_not_found unless @document
  end

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end
end
