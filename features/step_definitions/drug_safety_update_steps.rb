Given(/^a published drug safety update exists$/) do
  content_store_has_item("/drug-safety-update", drug_safety_update_finder)

  @document_base_path = "/drug-safety-update/paracetamol-damaging-effects"
  content_store_has_item(@document_base_path, drug_safety_update)
end

Then(/^I see the content of the drug safety update$/) do
  expect(page).to have_content("Paracetamol - Damaging effects")
  expect(page).to have_content("Update about paracetamol")
  expect(page).to have_content("Anaesthesia and intensive care")
  expect(page).to have_content("Cancer")
  expect(page).to have_content("24 October 2014")
  check_breadcrumb_value("Drug Safety Update", "/drug-safety-update")
end

def drug_safety_update
  read_fixture("specialist_documents/drug-safety-update.json")
end

def drug_safety_update_finder
  read_fixture("finders/drug-safety-update.json")
end
