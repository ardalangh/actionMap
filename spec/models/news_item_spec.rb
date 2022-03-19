# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
    describe 'news item creation' do
        it 'finds news item by rep id' do
            Representative.create!(name: 'Gavin Newsom')
            ni = NewsItem.create!(title: 'Gavin', representative_id: 1, link: 'google.com')
            expect(NewsItem.find_for(1)).to eq(ni)
        end
    end
end
