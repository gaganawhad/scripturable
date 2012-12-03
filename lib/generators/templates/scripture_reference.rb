class ScriptureReference < ActiveRecord::Base
  belongs_to :scripturable, :polymorphic => true

end
