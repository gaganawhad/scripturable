module Scripturable
  module FormHelper

    def scripture_input(object_name, method, options = {}, &block)
      
      content_tag(:div, (label + input + comment), {:class => 'scripture'})
    end
  end
end
