require 'acts_as_starable/version'

module ActsAsStarable
  autoload :Starer,     'acts_as_starable/starer'
  autoload :Starable,   'acts_as_starable/starable'
  autoload :StarerLib,  'acts_as_starable/starer_lib'
  autoload :StarScopes, 'acts_as_starable/star_scopes'

  require 'acts_as_starable/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 4
end
