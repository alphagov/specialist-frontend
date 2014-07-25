Feature: International development fund viewing
  As a specialist member of the public
  I want to be able to view international development funds
  So that I can learn where government funding goes

Scenario: Viewing a published fund
  Given a published international development fund exists
  When I visit the document page
  Then I should see the fund's content
