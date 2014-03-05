class Star < ActiveRecord::Base

  extend ActsAsStarable::StarerLib
  extend ActsAsStarable::StarScopes

  belongs_to :starable, polymorphic: true
  belongs_to :starer,   polymorphic: true

end
