# frozen_string_literal: true

When(/^(?:|I )follow the first "([^"]*)"$/) do |link|
    first(:link, link).click
end
