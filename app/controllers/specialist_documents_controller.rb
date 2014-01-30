require 'gds_api/helpers'

class SpecialistDocumentsController < ApplicationController
  include GdsApi::Helpers

  def show; end

protected
  def document
    @document ||= content_api.artefact(params[:id])
  end
  helper_method :document
end
