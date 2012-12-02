module Scripturable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_scripturable
      has_one :scripture_reference
    end
  end

end

ActiveRecord::Base.send(:include, Scripturable)
