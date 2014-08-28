Feature: Medical safety alert viewing
  As a specialist member of the public
  I want to be able to view drug and device alerts
  So that I can find out about drug and device alerts

Scenario: Viewing a published alert
  Given a published medical safety alert exists
  When I visit the document page
  Then I see the content of the medical safety alert
