class ScriptureReference < ActiveRecord::Base
  attr_accessible :delimiters

  REFERENCE_FORMAT = /^(\d+)(?::(\d+))?(?::(\d+))?$/ #http://rubular.com/r/7axgNYfYiK

  belongs_to :scripturable, :polymorphic => true
  validate :scripture_verses_should_exist

  def self.that_include(integer)
    where("scripture_references.start_at <= #{integer}").where("scripture_references.end_at >= #{integer}") if integer.is_a?(Fixnum)
  end

  def start_verse
    ScriptureVerse.new(start_at)
  end


  def end_verse
    ScriptureVerse.new(end_at)
  end

  def delimiters= hash
    @start_verse = ScriptureVerse.new({'book_number' => hash[:book], 'chapter_number' => hash[:start_chapter], 'verse_number' => hash[:start_verse] })
    @end_verse = ScriptureVerse.new({'book_number' => hash[:book], 'chapter_number' => hash[:end_chapter], 'verse_number' => hash[:end_verse] })
    self.start_at = @start_verse.to_i
    self.end_at = @end_verse.to_i
  end

  def include?(verse)
    start_at < verse && verse < end_at
  end

  def to_hash
    {
      :book_name => start_verse.book_name,
      :book => start_verse.book_number,
      :start_chapter => start_verse.chapter_number,
      :start_verse => start_verse.verse_number,
      :end_chapter => end_verse.chapter_number,
      :end_verse => end_verse.verse_number
    }
  end

  def delimiters
    OpenStruct.new(reference_hash)
  end

  def scripture_verses_should_exist
    if !start_verse.exists? || !end_verse.exists?
      errors.add(:base, "Scripture reference does not exist") 
    end
  end

 end


