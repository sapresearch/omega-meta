# Overrides Omega::ApplicationModel to force all omega models to be scoped by the current account.

require_engine_dependency Omega::Engine, "app/models", "omega/model"

module Omega
  class Model < ActiveRecord::Base
    def self.build_default_scope
      if method(:default_scope).owner != Base.singleton_class
        evaluate_default_scope { default_scope }
      elsif default_scopes.any?
        evaluate_default_scope do
          default_scopes.inject(relation) do |default_scope, scope|
            if scope.is_a?(Hash)
              default_scope.apply_finder_options(scope)
            elsif !scope.is_a?(Relation) && scope.respond_to?(:call)
              if scope.respond_to?(:arity) && scope.arity == 1
                scope = scope.call(self)
              else
                scope = scope.call
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
      model.where(:account_id => Hosting::Account.current)
    end

    belongs_to :account, :class_name => "Hosting::Account"
  end
end
