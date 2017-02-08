Rails.application.routes.draw do
  devise_for :users
  resources :pins do
    resources :orders, only: [:new, :create]
    # , :only => [:show, :update, :edit]
    member do
      put "like", to: "pins#upvote"
    end
  end

  match '/seller' => "pins#seller", via: :get, as: :seller
  match '/sales' => "orders#sales", via: :get, as: :sales
  match '/purchases' => "orders#purchases", via: :get, as: :purchases

 root "pins#index"
end
