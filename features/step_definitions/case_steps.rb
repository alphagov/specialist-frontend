Given(/^a published case$/) do
  @title = "Merger of Company A and Company B"
  @slug = slug_from_title(@title)
  @summary = "Example summary"
  content_api_has_an_artefact(@slug, {
    slug: @slug,
    title: @title,
    summary: @summary
  })
end

When(/^I visit the case page$/) do
  visit case_path(id: @slug)
end

Then(/^I should the case's content$/) do
  assert_match @title, page.body
  assert_match @summary, page.body
end

def slug_from_title(title)
  title.downcase.gsub(/\W/, '-')
end
