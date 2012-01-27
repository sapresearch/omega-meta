Omega::Hosting::Engine.routes.draw do
  resources :accounts
  mount Omega::Engine => "/omega" # For testing only.  Get rid of this line later.
  #mount Omega::Engine => "/:account_name"#, contraints => Omega::Hosting::AccountConstraints
end
