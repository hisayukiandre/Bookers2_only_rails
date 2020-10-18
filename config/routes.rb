Rails.application.routes.draw do
  root :to => 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :books ## devise_forの下に書く
  resources :users ## devise_forの下に書く
  # resourcesをdevise_forよりも上に書くと、
  # /users/:id(.:format)が/users/sign_in(.:format)より優先度が高いため
  # urlからsign_inを入力してもidにsign_inが代入されるためエラーが表示される
end
