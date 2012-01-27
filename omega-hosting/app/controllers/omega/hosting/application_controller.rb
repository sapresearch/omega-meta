module Omega::Hosting
  class ApplicationController < ActionController::Base
    protect_from_forgery
		puts "\n In Omega::Hosting::ApplicationController in Omega-Meta\n"
  end
end
