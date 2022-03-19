# frozen_string_literal: true

require 'rails_helper'
require 'google/apis/civicinfo_v2'

RSpec.describe Representative, type: :model do
    describe 'creates list of Representative from the civic api response' do
        before(:each) do
            address = 94_720
            service = Google::Apis::CivicinfoV2::CivicInfoService.new
            service.key = Rails.application.credentials.dig(:GOOGLE_API_KEY)
            VCR.use_cassette('rep_info') do
                @rep_info = service.representative_info_by_address(address: address)
            end
            @result = Representative.civic_api_to_representative_params(@rep_info)
        end

        it 'returns an array of representatives' do
            @result.each do |rep|
                expect(rep).to be_a(Representative)
            end
        end

        it 'creates the representative in the database' do
            @result.each do |rep|
                expect(Representative.find_by(name: rep.name)).to eq(rep)
            end
        end

        it 'is unique in the database' do
            expect do
                Representative.civic_api_to_representative_params(@rep_info)
            end.not_to change(Representative, :count)
        end

        it 'returns representative in array even it is not unique in database' do
            expect(Representative.civic_api_to_representative_params(@rep_info)).to eq(@result)
        end
    end
end
