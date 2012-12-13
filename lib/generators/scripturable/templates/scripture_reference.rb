class ScriptureReference < ActiveRecord::Base
  REFERENCE_FORMAT = /^(\d+)(?::(\d+))?(?::(\d+))?$/ #http://rubular.com/r/7axgNYfYiK

  belongs_to :scripturable, :polymorphic => true

  validates_presence_of :start_at
  validates :start_at, :format => {:with => REFRENCE_FORMAT, 
    :message => "Starting reference should be of the format '<book-number>(:<chapter-number>(:<verse-number>))" }
  validates :end_at, :format => {:with => REFERENCE_FORMAT, 
    :message => "Ending reference should be of the format '<book-number>(:<chapter-number>(:<verse-number>))" }


end
