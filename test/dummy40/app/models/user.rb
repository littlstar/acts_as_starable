class User < ActiveRecord::Base
  validates_presence_of :name
  acts_as_starer
  acts_as_starable
end
