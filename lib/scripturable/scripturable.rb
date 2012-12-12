module Scripturable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def scripturable
      has_one :scripture_reference, :as => :scripturable, :dependent => :destroy
    end
  end

end

ActiveRecord::Base.send(:include, Scripturable)
