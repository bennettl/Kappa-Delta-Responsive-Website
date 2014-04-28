require 'forem'
module Forem
  module Theme
    module Base
      class Engine < Rails::Engine
        Forem.theme = :bootstrap
      end
     end
  end
end
