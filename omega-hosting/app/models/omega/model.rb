# Overrides Omega::Model to force all omega models to be scoped by the current account.

require_engine_dependency Omega::Engine, "app/models", "omega/model"

module Omega
  class Model < ActiveRecord::Base
    def self.build_default_scope
      if method(:default_scope).owner != ActiveRecord::Base.singleton_class
        evaluate_default_scope { default_scope }
      elsif default_scopes.any?
        evaluate_default_scope do
          default_scopes.inject(relation) do |default_scope, scope|
            if scope.is_a?(Hash)
              default_scope.apply_finder_options(scope)
            elsif !scope.is_a?(ActiveRecord::Relation) && scope.respond_to?(:call)

				  		# This part is different from the source code: https://github.com/rails/rails/blob/v3.1.3/activerecord/lib/active_record/base.rb#L1279
              if scope.respond_to?(:arity) && scope.arity == 1
                scope = scope.call(self) # passes self to scope
              else
                scope = scope.call
				  		# End of the different part.

              end
              default_scope.merge(scope)
            else
              default_scope.merge(scope)
            end
          end
        end
      end
    end

    default_scope do |model|
	  # I commented this out until I add the account_id column to all tables. Otherwise, it'll return an error that there's no account_id column.
      #model.where(:account_id => Hosting::Account.current)
    end

    belongs_to :account, :class_name => "Hosting::Account"

	 self.abstract_class = true

  end
end
