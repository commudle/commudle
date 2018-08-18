class DataFormEntityResponseGroupsController<ApplicationController
  before_action :set_data_form_entity_response_group, only: [:update_registration_status]


  def update_registration_status
    @dfe_response_group.registration_status_id = params[:registration_status]

    @dfe_response_group.save


  end



  private


  def set_data_form_entity_response_group
    @dfe_response_group = DataFormEntityResponseGroup.find(params[:id])
  end


end