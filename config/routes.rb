SpecialistFrontend::Application.routes.draw do
  resources :specialist_documents, only: [:show], path: 'specialist-documents'
end
