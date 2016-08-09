Rails.application.routes.draw do
  get "*path", to: "specialist_documents#show"
end
