Feature: search representatives using the map

Scenario: find representative
  When I go to "Alameda County"
  Then I should see "Joseph R. Biden"
  And I should see "Gavin Newsom"
  And I should see "Nancy E. O'Malley"