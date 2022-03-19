Feature: find, create, and edit news articles

Scenario: find news articles
  Given I am on the search page
  When I fill in "address" with "Alameda County"
  And I press "Search"
  And I follow the first "News Articles"
  Then I should see "Listing News Articles for Joseph R. Biden"
  
Scenario: add news article
  Given I am on the home page
  When I follow "Login"
  And I press "Sign in with GitHub"
  And I go to the search page
  And I fill in "address" with "Alameda County"
  And I press "Search"
  And I follow the first "News Articles"
  And I follow "Add News Article"
  And I fill in "news_item[title]" with "Governor Recall"
  And I fill in "news_item[link]" with "https://ballotpedia.org/Gavin_Newsom_recall,_Governor_of_California_(2019-2021)"
  And I fill in "news_item[description]" with "ello gov'nor"
  And I select "Gavin Newsom" from "news_item[representative_id]"
  And I press "Save"
  Then I should see "News item was successfully created."
