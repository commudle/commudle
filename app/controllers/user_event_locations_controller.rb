class UserEventLocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dferg_entry_pass

  def update_selected_location

    UserEventLocation.select_location(@dferg, params[:event_location_id])

  end


  private

  def set_dferg_entry_pass
    @dferg = DataFormEntityResponseGroup.find(params[:dferg])
    @entry_pass = EventEntryPass.find_by(event: @dferg.event_data_form_entity_group.event, user: @dferg.user)

  end





end