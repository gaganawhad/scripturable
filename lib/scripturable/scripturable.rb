module Scripturable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def scripturable options={}
      if options[:has_one] == true
        has_one :scripture_reference, :as => :scripturable, :dependent => :destroy 
      else
        has_many :scripture_references, :as => :scripturable, :dependent => :destroy
      end
    end
  end

end

ActiveRecord::Base.send(:include, Scripturable)
