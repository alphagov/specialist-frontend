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

* [alphagov/content-store]: provides the document to display.
* [alphagov/static]: provides static assets (JS/CSS) and provides the GOV.UK
  templates.

[alphagov/static]: https://github.com/alphagov/static
[alphagov/content-store]: https://github.com/alphagov/content-store

## Running the application

```
$ ./startup.sh
```

or you can run using bowler in the VM from cd /var/govuk/development/:

```
bowl specialist-frontend
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
