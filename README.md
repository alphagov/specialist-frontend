#Specialist frontend

##Purpose
![Specialist frontend screenshot](https://raw.githubusercontent.com/alphagov/specialist-frontend/master/docs/assets/page-screenshot.png)

Displays documents published via [alphagov/specialist-publisher](https://github.com/alphagov/specialist-publisher).

##Dependencies
* [alphagov/static](https://github.com/alphagov/static): provides static assets (JS/CSS) and provides the GOV.UK templates.
* [alphagov/finder-api](https://github.com/alphagov/finder-api): provides the schema used to convert metadata into human-readable values.
* [alphagov/govuk_content_api](https://github.com/alphagov/govuk_content_api): provides the document to display.

##Running the application

```
$ ./startup.sh
```

If you are using the GDS development virtual machine then the application will be available on the host at [http://specialist-frontend.dev.gov.uk/](http://specialist-frontend.dev.gov.uk/)

##Running the test suite

```
$ bundle exec rake
```

##Adding a new document type
1. Add a new presenter in `app/presenters` for the new document type.
2. Add the mapping for the new presenter to its document type in `app/controllers/specialist_documents_controller.rb#document_presenter`
