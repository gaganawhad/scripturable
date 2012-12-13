class ScriptureReference < ActiveRecord::Base
  belongs_to :scripturable, :polymorphic => true

  validates_presence_of :start_at
  validates :start_at, :format => {:with =>/^\d+(?:(?::\d+)?){1,2}$/, #http://rubular.com/r/7axgNYfYiK
    :message => "Starting reference should be of the format '<book-number>(:<chapter-number>(:<verse-number>))" }
  validates :end_at, :format => {:with =>/^\d+(?:(?::\d+)?){1,2}$/, #http://rubular.com/r/7axgNYfYiK
    :message => "Ending reference should be of the format '<book-number>(:<chapter-number>(:<verse-number>))" }


end
