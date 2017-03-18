Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users,
  controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    get 'users/sign_out' =>  'devise/sessions#destroy'
  end
  scope "(:locale)", locale: /en|ru/ do
    resources :users do
      resources :instructions do
        resources :steps
      end
    end
    resources :steps do
      resources :comments
    end
    resources :instructions do
      get :autocomplete_tag_name, :on => :collection
    end
    get 'tags/:tag', to: 'instructions#index', as: "tag"
    root to: 'instructions#index'
    resources :instructions
    resources :steps
  end
end
