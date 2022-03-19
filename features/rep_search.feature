Feature: search representatives by address

Scenario: find search page
  Given I am on the home page
  When I follow "Representatives"
  Then I should see "Search for a Representative"


Scenario: search for representative
  Given I am on the search page
  When I fill in "address" with "Alameda County"
  And I press "Search"
  Then I should see "Joseph R. Biden"
  And I should see "Gavin Newsom"
  And I should see "Nancy E. O'Malley"
  
Scenario: faulty input to API 
  Given I am on the search page
  When I fill in "address" with "aaaaaaaaaa"
  And I press "Search"
  Then I am on the search page
  When I fill in "address" with "Alameda County"
  And I press "Search"
  Then I should see "Joseph R. Biden"
  And I should see "Gavin Newsom"
  And I should see "Nancy E. O'Malley"
    
  