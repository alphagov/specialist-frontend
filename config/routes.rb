SpecialistFrontend::Application.routes.draw do
  resources :cases, only: [:show]
end
