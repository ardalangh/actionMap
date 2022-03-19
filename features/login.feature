Feature: search representatives by address

Scenario: Google login
  Given I am on the home page
  When I follow "Login"
  And I press "Sign in with Google"
  And I follow "Profile"
  Then I should see "Google Test Developer"
  When I follow "Logout"
  Then I should see "You have successfully logged out."

Scenario: Github login
  Given I am on the home page
  When I follow "Login"
  And I press "Sign in with GitHub"
  And I follow "Profile"
  Then I should see "Github Test Developer"
  When I follow "Logout"
  Then I should see "You have successfully logged out."