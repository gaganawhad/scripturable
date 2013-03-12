module Scripturable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def scripturable options={}
      if options[:has_one] == true
        attr_accessible :scripture_references_attributes
        has_one :scripture_reference, :as => :scripturable, :dependent => :destroy 
        accepts_nested_attributes_for :scripture_reference
      else
        attr_accessible :scripture_references_attributes
        has_many :scripture_references, :as => :scripturable, :dependent => :destroy
        accepts_nested_attributes_for :scripture_references
      end
    end
  end

end

ActiveRecord::Base.send(:include, Scripturable)
