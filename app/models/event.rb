class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :kommunity
  belongs_to :user

  has_many :data_form_entities, as: :entity



  def registration_form_link_text(dfe)
    if self.registration_form_id == dfe.id
      return "Remove From Registration Form"

    else
      return "Set As Registration Form"
    end

  end



end
