Omega::Hosting::Engine.routes.draw do
  resources :accounts
  mount Omega::Engine => "/:account_name"#, contraints => Omega::Hosting::AccountConstraints
end
