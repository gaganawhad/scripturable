class Resource < ActiveRecord::Base
  attr_accessible :title
  acts_as_scripturable
end
