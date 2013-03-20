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

      def self.span_scripture_book_numbers
        self.joins(:scripture_references).pluck('scripture_references.start_at').map{|ref| ref / 1000000}
      end

      def self.scripture_spectrum
        uniq_book_numbers = self.span_scripture_book_numbers.uniq
        Scripturable::SCRIPTURE_BOOKS_META.select{|b| uniq_book_numbers.include? b['number']}.map{|a| {'number' => a['number'], 'name' => a['name']}}
      end

      def self.scripture_histogram
        book_numbers = self.span_scripture_book_numbers
        Hash[book_numbers.uniq.map{|r| [r, book_numbers.count(r)]}]
      end

    end
  end

end

ActiveRecord::Base.send(:include, Scripturable)
