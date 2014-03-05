class Band < ActiveRecord::Base
  validates_presence_of :name
  acts_as_starable
end
