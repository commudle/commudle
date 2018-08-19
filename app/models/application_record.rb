class ApplicationRecord < ActiveRecord::Base
  include NameValues


  self.abstract_class = true
end
