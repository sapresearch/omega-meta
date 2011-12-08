# Overrides Omega::Migration to force all omega tables to have an account_id column.

require_engine_dependency Omega::Engine, "lib", "omega/migration"

module Omega
  class Migration
    def create_table(*, &block)
      super do |t|
        t.belongs_to :account
        block.call(t)
      end
    end
  end
end
