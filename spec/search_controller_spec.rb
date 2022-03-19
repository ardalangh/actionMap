# frozen_string_literal: true

require 'rails_helper'

require 'webmock/rspec'

RSpec.describe SearchController, type: :controller do
    describe 'Basic Test' do
        it 'search displays representatives/search' do
            allow(Representative).to receive(:civic_api_to_representative_params).and_return([])

            stub_request(:get, 'https://civicinfo.googleapis.com/civicinfo/v2/representatives')
                .with(
                    query:   hash_including({ 'address' => 'CA' }),
                    headers: {
                        'Accept'            => '*/*',
                        'Accept-Encoding'   => 'gzip,deflate',
                        'Content-Type'      => 'application/x-www-form-urlencoded',
                        'X-Goog-Api-Client' => 'gl-ruby/2.6.5 gdcl/0.42.2'
                    }
                )
                .to_return(status: 200, body: '', headers: {})

            get :search, params: { address: 'CA' }
            expect(response).to render_template('representatives/search')
        end
        it 'Invalid Address Error Message' do
            allow(Representative).to receive(:civic_api_to_representative_params).and_return([])

            stub_request(:get, 'https://civicinfo.googleapis.com/civicinfo/v2/representatives')
                .with(
                    query:   hash_including({ 'address' => 'Blarp' }),
                    headers: {
                        'Accept'            => '*/*',
                        'Accept-Encoding'   => 'gzip,deflate',
                        'Content-Type'      => 'application/x-www-form-urlencoded',
                        'X-Goog-Api-Client' => 'gl-ruby/2.6.5 gdcl/0.42.2'
                    }
                )
                .to_return(status: 403, body: '{"error": {
                                                "code": 403,
                                                "message": "The request is missing a valid API key.",
                                                "errors": [
                                                  {
                                                    "message": "The request is missing a valid API key.",
                                                    "domain": "global",
                                                    "reason": "forbidden"
                                                  }
                                                ],
                                                    "status": "PERMISSION_DENIED"
                                                }}', headers: {})

            get :search, params: { address: 'Blarp', key: '0' }
            expect(flash[:notice]).to be('Please input a valid address')
        end
    end
end
