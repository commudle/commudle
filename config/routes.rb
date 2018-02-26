Rails.application.routes.draw do

  match '*all', to: proc { [204, {}, ['']] }, via: :options

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  root "application#hello_gdg"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
