class Resource < ActiveRecord::Base
  attr_accessible :title
  scripturable
end
