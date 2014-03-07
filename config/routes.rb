SpecialistFrontend::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  get "*path", to: "specialist_documents#show"
end
