class ScriptureReference < ActiveRecord::Base
  belongs_to :scripturable, :polymorphic => true

  def name 
    'my name is scripture referecne'
  end
end
