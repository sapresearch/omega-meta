module Omega
  module Hosting
    class Engine < Rails::Engine
      isolate_namespace Hosting
    end
  end
end
