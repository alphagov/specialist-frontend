Feature: Document viewing
  As a user with specialist needs
  I want to be able to view Documents
  So that I can find out about specialist areas

Scenario: Viewing a published update
  Given a published Document exists
  When I visit the Document page
  Then I see the content of the Document

Scenario: Viewing a published update with a major change
  Given a published Document with a major change exists
  When I visit the Document page
  Then I see the content of the republished Document
