# Overrides Omega::ApplicationController to force all omega controllers to load the account.

require_engine_dependency Omega::Engine, "app/controllers", "omega/application_controller"

module Omega
  class ApplicationController < ActionController::Base
    around_filter :load_hosting_account
		puts "\n In Omega::ApplicationController in Omega-Meta\n"

    protected
      def load_hosting_account
        @hosting_account = Hosting::Account.find_by_name!(params[:account_name])
        @hosting_account.with { yield }
      rescue ActiveRecord::RecordNotFound
        #TODO
        render text: "", status: 404
      end
  end
end
