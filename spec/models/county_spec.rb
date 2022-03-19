# frozen_string_literal: true

require 'rails_helper'

RSpec.describe County, type: :model do
    describe 'Basic Test' do
        it 'Can correctly format 1 digit FIPS codes' do
            county = County.new({ name: 'countee', fips_code: 1 })
            expect(county.std_fips_code).to eq('001')
        end

        it 'Can correctly format 2 digit FIPS codes' do
            county = County.new({ name: 'countee', fips_code: 21 })
            expect(county.std_fips_code).to eq('021')
        end

        it 'Can correctly format 3 digit FIPS codes' do
            county = County.new({ name: 'countee', fips_code: 121 })
            expect(county.std_fips_code).to eq('121')
        end
    end
end
