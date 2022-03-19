# frozen_string_literal: true

class Representative < ApplicationRecord
    has_many :news_items, dependent: :delete_all
    validates :name, uniqueness: true

    def self.civic_api_to_representative_params(rep_info)
        reps = []

        rep_info.officials.each_with_index do |official, index|
            title = get_title(rep_info.offices, index)
            ocdid = get_ocdid(rep_info.offices, index)

            rep = get_representative(official.name, ocdid, title)
            reps.push(rep)
        end
        reps
    end

    def self.get_title(offices, index)
        offices.each do |office|
            return office.name if official_in_office?(office, index)
        end
    end

    def self.get_ocdid(offices, index)
        offices.each do |office|
            return office.division_id if official_in_office?(office, index)
        end
    end

    def self.official_in_office?(office, index)
        office.official_indices.include? index
    end

    def self.get_representative(name, ocdid, title)
        Representative.create!({ name: name, ocdid: ocdid,
            title: title })
    rescue ActiveRecord::RecordInvalid
        rep = Representative.find_by(name: name)
        rep.update({ name: name, ocdid: ocdid, title: title })
        rep
    end

    # rep_info: what the API call returned
    # rep: the representative object that we will update
    def self.civic_api_to_profile(rep_info, rep)
        official = find_matching_official(rep_info, rep)
        update(official, rep)
    end

    # extra methods because rubocop sucks
    def self.find_matching_official(rep_info, rep)
        rep_info.officials.each do |official|
            next unless official.name == rep.name

            return official
        end
    end

    def self.update(official, rep)
        unless official.address.nil?
            ad = official.address[0]
            rep.update(line1: ad.line1, line2: ad.line2, line3: ad.line3, city: ad.city, state: ad.state, zip: ad.zip)
        end
        rep.update(party: official.party, photo_url: official.photo_url)
    end
end
