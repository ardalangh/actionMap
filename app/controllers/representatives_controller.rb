# frozen_string_literal: true

class RepresentativesController < ApplicationController
    def index
        @representatives = Representative.all
    end

    def show
        @representative = Representative.find(params[:id])
        service = Google::Apis::CivicinfoV2::CivicInfoService.new
        service.key = Rails.application.credentials.dig(:GOOGLE_API_KEY)
        result = service.representative_info_by_division(@representative.ocdid)
        Representative.civic_api_to_profile(result, @representative)
    end
end
