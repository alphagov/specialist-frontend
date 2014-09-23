# Specialist frontend

## Purpose

Displays long form single page documents published via
[alphagov/specialist-publisher].

![Specialist frontend screenshot](https://raw.githubusercontent.com/alphagov/specialist-frontend/master/docs/assets/page-screenshot.png)

[alphagov/specialist-publisher]: https://github.com/alphagov/specialist-publisher

### Examples

* [Energy Market Investigation] published by the
  [Competition and Markets Authority].
* [Trade Advocacy Fund] published by the
  [Department for International Development].

[Energy Market Investigation]: https://www.gov.uk/cma-cases/energy-market-investigation
[Competition and Markets Authority]: https://www.gov.uk/government/organisations/competition-and-markets-authority
[Trade Advocacy Fund]: https://www.gov.uk/international-development-funding/trade-advocacy-fund
[Department for International Development]: https://www.gov.uk/government/organisations/department-for-international-development

## Dependencies

* [alphagov/static]: provides static assets (JS/CSS) and provides the GOV.UK
  templates.
* [alphagov/finder-api]: provides the schema used to convert metadata into
  human-readable values.
* [alphagov/govuk_content_api]: provides the document to display.

[alphagov/static]: https://github.com/alphagov/static
[alphagov/finder-api]: https://github.com/alphagov/finder-api
[alphagov/govuk_content_api]: https://github.com/alphagov/govuk_content_api

## Running the application

```
$ ./startup.sh
```

If you are using the GDS development virtual machine then the application will
be available on the host at http://specialist-frontend.dev.gov.uk/

## Running the test suite

```
$ bundle exec rake
```

## Adding a new document type

1. Add a new presenter in `app/presenters` for the new document type.
2. Add the mapping for the new presenter to its document type in the
   `document_presenter` method in
   `app/controllers/specialist_documents_controller.rb`.
