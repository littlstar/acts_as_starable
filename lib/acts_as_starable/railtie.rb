require 'acts_as_starable'
require 'rails'

module ActsAsStarable
  class Railtie < Rails::Railtie

    initializer "acts_as_starable.active_record" do |app|
      ActiveSupport.on_load :active_record do
        include ActsAsStarable::Starer
        include ActsAsStarable::Starable
      end
    end

  end
end
