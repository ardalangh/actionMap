# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapController, type: :controller do
    describe 'Map Index Route' do
        before(:each) do
            @state1 = State.create({ name:         'Alabama',
                                     symbol:       'AL',
                                     fips_code:    '01',
                                     is_territory: 0,
                                     lat_min:      '-88.473227',
                                     lat_max:      '-84.88908',
                                     long_min:     '30.223334',
                                     long_max:     '-84.88908' })
            county_filename = 'lib/assets/counties_fips_data/al.json'
            File.open(Rails.root.join(county_filename), 'r:UTF-8') do |f|
                @state1.counties = JSON.parse(f.read, object_class: County)
            end
            @state1.save
        end
        it 'Can list states all states' do
            get :index
            expect(controller.instance_variable_get(:@states)).to include(@state1)
        end
        it 'Can list states by fips code' do
            get :index
            expect(controller.instance_variable_get(:@states_by_fips_code)['01']).to eq(@state1)
        end
    end
    describe 'Map State Route' do
        before(:each) do
            @state1 = State.create({ name:         'Alabama',
                                     symbol:       'AL',
                                     fips_code:    '01',
                                     is_territory: 0,
                                     lat_min:      '-88.473227',
                                     lat_max:      '-84.88908',
                                     long_min:     '30.223334',
                                     long_max:     '-84.88908' })
            county_filename = 'lib/assets/counties_fips_data/al.json'
            File.open(Rails.root.join(county_filename), 'r:UTF-8') do |f|
                @state1.counties = JSON.parse(f.read, object_class: County)
            end
            @state1.save
        end
        it 'Can render map of Alabama Counties' do
            get :state, params: { state_symbol: 'AL' }
            expect(controller.instance_variable_get(:@state)).to eq(@state1)
            expect(controller.instance_variable_get(:@county_details)).to eq(@state1.counties.index_by(&:std_fips_code))
        end
        it 'Can handle invalid state symbol' do
            get :state, params: { state_symbol: 'OO' }
            expect(controller).to redirect_to(root_path)
            expect(flash[:alert]).to eq("State 'OO' not found.")
        end
    end
    describe 'County Route' do
        before(:each) do
            @state1 = State.create({ name:         'Alabama',
                                     symbol:       'AL',
                                     fips_code:    '01',
                                     is_territory: 0,
                                     lat_min:      '-88.473227',
                                     lat_max:      '-84.88908',
                                     long_min:     '30.223334',
                                     long_max:     '-84.88908' })
            county_filename = 'lib/assets/counties_fips_data/al.json'
            File.open(Rails.root.join(county_filename), 'r:UTF-8') do |f|
                @state1.counties = JSON.parse(f.read, object_class: County)
            end
            @state1.save
        end
        it 'Can Handle valid County' do
            get :county, params: { state_symbol: 'AL', std_fips_code: '01' }
            expect(controller).to redirect_to(search_representatives_path(address: 'Autauga County'))
        end

        it 'Can Handle invalid County' do
            get :county, params: { state_symbol: 'AL', std_fips_code: '300' }
            expect(controller).to redirect_to(root_path)
            expect(flash[:alert]).to eq("County with code '300' not found for AL")
        end
    end
end
