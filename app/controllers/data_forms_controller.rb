class DataFormsController < ApplicationController
  before_action :set_data_form, only: [:edit, :update]
  before_action :access_permissions, only: [:edit, :update]


  def index

    @data_forms = DataForm.where(user_id: current_user.id)
  end

  def new
    @data_form = DataForm.new

    1.times do
      question = @data_form.questions.build
      5.times {question.question_choices.build}
    end

  end

  def create
    @data_form = DataForm.new(data_form_params)
    @data_form.user = current_user


    if @data_form.save
      redirect_to action: :index, notice: "Successfully created survey."
    else
      render :new
    end

  end

  def edit
  end

  def update

    byebug

    @data_form.update_attributes(data_form_params)


    if @data_form.save
      redirect_to action: :index, notice: "Successfully created survey."
    else
      render :edit
    end


  end


  private

  def set_data_form
    @data_form = DataForm.find(params[:id])
  end


  def access_permissions
    if @data_form.user_id != current_user.id
      throw_error(ErrorNotification::UNAUTHORIZED)
    end
  end

  def data_form_params
    params.require(:data_form).permit(:name, :kommunity_id, questions_attributes: [:id, :title, :question_type_id, :_destroy, question_choices_attributes: [:id, :title, :_destroy]])
  end

end
