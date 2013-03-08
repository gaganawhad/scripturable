class ScriptureReference < ActiveRecord::Base

  REFERENCE_FORMAT = /^(\d+)(?::(\d+))?(?::(\d+))?$/ #http://rubular.com/r/7axgNYfYiK

  belongs_to :scripturable, :polymorphic => true

  validates_presence_of :start_at
  validates :start_at, :format => {:with => REFERENCE_FORMAT, 
    :message => "start reference should follow the format '<book-number>(:<chapter-number>(:<verse-number>))" }
  validates :end_at, :format => {:with => REFERENCE_FORMAT, 
    :message => "end reference should follow the format '<book-number>(:<chapter-number>(:<verse-number>))" }


  def start_verse
    if new_record?
      @start_verse ||= ScriptureVerse.new
    else 
      @start_verse ||= ScriptureVerse.new
    end
  end


  def end_verse
    if new_record?
      @start_verse ||= ScriptureReference.new
    else 
      @start_verse ||= ScriptureReference.new
    end
  end

  def start_verse= value
    @start_verse ||= ScriptureReference.new value
    debugger
    self.start_at = @start_verse.to_i
  end

  def end_verse= params
    @end_verse ||= ScriptureReference.new value
    self.end_at = @end_verse.to_i
  end

end
