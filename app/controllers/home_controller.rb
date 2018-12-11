class HomeController < ApplicationController
  before_action :access_allowed?



  def home

    @upcoming_events = Event.includes(event_data_form_entity_groups: :data_form_entities).upcoming
    @recent_past_events = Event.includes(event_data_form_entity_groups: :data_form_entities).recent_past


    @kommunities = Kommunity.all.order(:created_at)

  end



end
