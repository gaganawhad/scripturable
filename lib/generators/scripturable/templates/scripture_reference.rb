class ScriptureReference < ActiveRecord::Base
  belongs_to :scripturable, :polymorphic => true
  validates_presence_of :start_verse
  validates :start_verse, :format => {:with =>/^\d+(?:(?::\d+)?){1,2}$/, #http://rubular.com/r/7axgNYfYiK
    :message => "Scripture Verse should be of the format '<book-number>(:<chapter-number>(:<verse-number>))" }
  validates :end_verse, :format => {:with =>/^\d+(?:(?::\d+)?){1,2}$/, #http://rubular.com/r/7axgNYfYiK
    :message => "Scripture Verse should be of the format '<book-number>(:<chapter-number>(:<verse-number>))" }

end
