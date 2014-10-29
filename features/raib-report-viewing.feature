Feature: RAIB report viewing
  As a specialist member of the public
  I want to be able to view RAIB reports
  So that I can find out about air accidents

Scenario: Viewing a published update
  Given a published RAIB report exists
  When I visit the document page
  Then I see the content of the RAIB report
