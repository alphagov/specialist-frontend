Feature: Drug safety update viewing
As a specialist member of the public
I want to be able to view drug safety updates
So that I can find out about drug safety

Scenario: Viewing a published update
  Given a published drug safety update exists
  When I visit the Document page
  Then I see the content of the drug safety update
