module Omega
  module Hosting
    require "omega/hosting/version"
    require "omega/hosting/engine"
  end
end

def require_engine_dependency(engine, path, file)
  paths = engine.paths[path]
  raise "#{engine} does not have a path for `#{path}'" unless paths

  if found = paths.map { |p| File.join(p, file) }.detect { |p| File.exists? File.join(p, file) }
    require_dependency found
  else
    require_dependency File.join(paths.first, file)
  end
end
