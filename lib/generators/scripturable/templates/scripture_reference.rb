class ScriptureReference < ActiveRecord::Base
  REFERENCE_FORMAT = /^(\d+)(?::(\d+))?(?::(\d+))?$/ #http://rubular.com/r/7axgNYfYiK

  belongs_to :scripturable, :polymorphic => true

  validates_presence_of :start_at
  validates :start_at, :format => {:with => REFERENCE_FORMAT, 
    :message => "start reference should follow the format '<book-number>(:<chapter-number>(:<verse-number>))" }
  validates :end_at, :format => {:with => REFERENCE_FORMAT, 
    :message => "end reference should follow the format '<book-number>(:<chapter-number>(:<verse-number>))" }

  def start_book
    @start_book ||= initialize_start_reference_params['book']
  end
  
  def start_chapter
    @start_book ||= initialize_start_reference_params['chapter']
  end

  def start_verse
    @start_book ||= initialize_start_reference_params['verse']
  end

  def end_book
    @end_book ||= initialize_end_reference_params['book']
  end

  def end_chapter
    @end_chapter ||= initialize_end_reference_params['chapter']
  end

  def end_verse
    @end_verse ||= initialize_end_reference_params['verse']
  end

  
  private

  def initialize_start_reference_params
    raise 'start_at value not set for the object' if start_at.blank?
    @start_book, @start_chapter, @start_verse = parse_reference(start_at)
    reference_hash start_at
  end

  def initialize_end_reference_params
    raise 'end_at value not set for the object' if end_at.blank?
    @end_book, @end_chapter, @end_verse = parse_reference(end_at)
    reference_hash end_at
  end

  def reference_hash reference
      Hash[['book', 'chapter', 'verse'].zip(parse_reference(reference))]
  end

  def parse_reference reference
    raise "Scripture reference does not follow the format: '<book-number>(:<chapter-number>(:<verse-number>))'" unless follows_format? reference
    reference.scan(REFERENCE_FORMAT).flatten.map(&:to_i)
  end

  def follows_format? reference
    reference.scan(REFERENCE_FORMAT).any?
  end


end
