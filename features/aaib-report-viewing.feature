Feature: AAIB report viewing
  As a specialist member of the public
  I want to be able to view AAIB reports
  So that I can find out about air accidents

Scenario: Viewing a published update
  Given a published AAIB report exists
  When I visit the document page
  Then I see the content of the AAIB report

Scenario: Viewing a published update with a major change
  Given a published AAIB report with a major change exists
  When I visit the document page
  Then I see the content of the republished AAIB report
