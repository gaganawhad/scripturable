class ScriptureReference < ActiveRecord::Base
  attr_accessible :start_verse, :end_verse

  REFERENCE_FORMAT = /^(\d+)(?::(\d+))?(?::(\d+))?$/ #http://rubular.com/r/7axgNYfYiK

  belongs_to :scripturable, :polymorphic => true

  validates_presence_of :start_verse
  validates_presence_of :end_verse

  def self.that_include(integer)
    where("scripture_references.start_at <= #{integer}").where("scripture_references.end_at >= #{integer}") if integer.is_a?(Fixnum)
  end

  def start_verse
    if new_record?
      @start_verse ||= ScriptureVerse.new
    else 
      @start_verse ||= ScriptureVerse.new(start_at)
    end
  end


  def end_verse
    if new_record?
      @end_verse ||= ScriptureVerse.new
    else 
      @end_verse ||= ScriptureVerse.new(end_at)
    end
  end

  def start_verse= value
    @start_verse ||= ScriptureVerse.new(value)
    self.start_at = @start_verse.to_i
  end

  def end_verse= value
    @end_verse ||= ScriptureVerse.new(value)
    self.end_at = @end_verse.to_i
  end

  def include?(verse)
    start_at < verse && verse < end_at
  end

  def reference_hash
    {
      :start => start_verse.to_hash,
      :end => end_verse.to_hash
    }
  end

 end


