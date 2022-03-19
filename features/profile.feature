Feature: find representative profiles

Scenario: search for representative
  Given I am on the search page
  When I fill in "address" with "Alameda County"
  And I press "Search"
  And I follow the first "Details"
  Then I should see "Representative Details"
  And I should see "President of the United States"