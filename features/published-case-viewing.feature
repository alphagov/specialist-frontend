Feature: Published case viewing
  As a specialist member of the public
  I want to be able to view published cases
  So that I can learn what action CMA has taken about it

Scenario: Viewing a published case
  Given a published case
  When I visit the case page
  Then I should see the case's content
