Rails.application.routes.draw do
  devise_for :users
  resources :pins do
    member do
      put "like", to: "pins#upvote"
    end
  end

  match '/seller' => "pins#seller", via: :get, as: :seller

 root "pins#index"
end
