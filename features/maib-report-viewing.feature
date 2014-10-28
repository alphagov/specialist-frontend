Feature: MAIB report viewing
  As a specialist member of the public
  I want to be able to view MAIB reports
  So that I can find out about air accidents

Scenario: Viewing a published update
  Given a published MAIB report exists
  When I visit the document page
  Then I see the content of the MAIB report
