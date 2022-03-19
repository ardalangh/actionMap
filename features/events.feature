Feature: find events

#Background: events in database

#  Given events exist
  
Scenario: find events page
  Given I am on the home page
  When I follow "Events"
  Then I should see "Pride Parade"
  And I should see "BLM"

Scenario: filter by state and county
  Given I am on the home page
  When I follow "Events"
  And I select "California" from "state"
  And I press "Filter by State"
  Then I should see "Pride Parade"
  And I should not see "BLM"
  
Scenario: view details
  Given I am on the home page
  When I follow "Events"
  And I select "Oregon" from "state"
  And I press "Filter by State"
  And I follow "View"
  Then I should see "Event Details"
  And I should see "BLM"
  
Scenario: edit event
  Given I am on the home page
  When I follow "Login"
  And I press "Sign in with Google"
  And I follow "Events"
  And I follow the first "View"
  And I follow "Edit"
  And I fill in "event[name]" with "Pride Parade uwu"
  And I press "commit"
  Then I should see "Pride Parade uwu"
  
Scenario: add event failure
  Given I am on the home page
  When I follow "Login"
  When I press "Sign in with Google"
  And I follow "Events"
  And I follow "Add New Event"
  And I fill in "event[name]" with "Caltopia"
  And I fill in "event[description]" with "Get free stuff!"
  And I select "California" from "event[state]"
  And I select "2022" from "event[start_time(1i)]"
  And I select "2022" from "event[end_time(1i)]"
  And I press "Save"
  Then I should see "County must exist"