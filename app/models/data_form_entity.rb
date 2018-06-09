class DataFormEntity < ApplicationRecord
  belongs_to :data_form
  belongs_to :entity, polymorphic: true
end
