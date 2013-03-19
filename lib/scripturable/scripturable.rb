module Scripturable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def scripturable options={}
      if options[:has_one] == true
        attr_accessible :scripture_references_attributes
        has_one :scripture_reference, :as => :scripturable, :dependent => :destroy 
        accepts_nested_attributes_for :scripture_reference, :allow_destroy => true
      else
        attr_accessible :scripture_references_attributes
        has_many :scripture_references, :as => :scripturable, :dependent => :destroy
        accepts_nested_attributes_for :scripture_references, :allow_destroy => true
      end

      def self.from_scripture_book book
        book_number = case book
        when String
          book_hash = Scripturable::SCRIPTURE_BOOKS_META.find{|meta_book| meta_book['string_id'] == book.parameterize} 
          raise "book #{book} was not found" unless book_hash
          book_hash['number']
        when Fixnum
          raise "book #{book} was not found" unless book.between?(1,66)
          book
        end
        self.includes(:scripture_references).where("scripture_references.start_at >= #{book_number * 1000000} AND scripture_references.start_at < #{(book_number + 1) * 1000000}").uniq
      end

    end
  end

end

ActiveRecord::Base.send(:include, Scripturable)
