class OtherDatabase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :xe_development
end

