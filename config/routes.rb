MystroVolley::Engine.routes.draw do
  resources :projects
  resources :branches
  resources :versions

  constraints(project: /[\w\d\.]+/,branch: /[\w\d\.]+/,version: /[\w\d\.]+/) do
    match "/:project", to: "home#show"
    match "/:project/:branch", to: "home#show"
    match "/:project/:branch/:version", to: "home#show"
  end

  root to: "home#index"
end

MystroServer::Application.routes.draw do
  mount MystroVolley::Engine => "/plugins/volley"
end
