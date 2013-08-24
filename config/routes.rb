MystroVolley::Engine.routes.draw do
  match "browser" => "home#browser"

  resources :projects
  resources :branches
  resources :versions do
    get "deploy", on: :member
    post "queue", on: :member
  end

  constraints(project: /[\w\d\.]+/,branch: /[\w\d\.]+/,version: /[\w\d\.]+/) do
    match "/:project", to: "home#show"
    match "/:project/:branch", to: "home#show"
    match "/:project/:branch/:version", to: "home#show"
  end

  #match "/__better_errors/:id/:thing" => main_app.root + "/__better_errors/%{id}/%{thing}"

  root to: "home#index"
end

MystroServer::Application.routes.draw do
  mount MystroVolley::Engine => "/plugins/volley"
end
