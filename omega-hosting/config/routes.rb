Omega::Hosting::Engine.routes.draw do
  resources :accounts

  # mount Omega::Engine => "/:account_name", :constraints => Omega::Hosting::AccountConstraints
end
