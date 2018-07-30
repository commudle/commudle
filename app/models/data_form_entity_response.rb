class DataFormEntityResponse < ApplicationRecord
  belongs_to :user
  belongs_to :data_form_entity
  has_many :data_form_entity_response_values
  # parent is either a question or a choice




  def self.create_or_find_user_response(data_form_entity,  user, response_params)

    form_response = DataFormEntityResponse.find_or_create_by(user_id: user.id, data_form_entity_id: data_form_entity.id)

    form_response.create_or_update_question_response(response_params)

  end


  def create_or_update_question_response(response_params)
    question_ids = response_params.keys

    questions = Question.joins(:question_type).where("questions.id in (?)", question_ids.map(&:to_i)).select("questions.id, question_types.name")

    questions.each do |question|

      # mark all the existing user responses as inactive because it might be possible that the type of a question changes
      DataFormEntityResponseValue.where(data_form_entity_response: self, question_id: question.id).update(active: false)
      current_response = response_params[question.id.to_s]
      if !current_response.blank?
        case question.name

          when "short_answer", "long_answer", "number"
            user_response = DataFormEntityResponseValue.create(data_form_entity_response: self, question_id: question.id, text_response: current_response)

          when "single_choice"
            user_response = DataFormEntityResponseValue.create(data_form_entity_response: self, question_id: question.id, question_choice_id: current_response.to_i)
          when "multiple_choice"
            current_response = current_response.reject { |c| c.empty? }
            current_response.each do |cr|
              user_response = DataFormEntityResponseValue.create(data_form_entity_response: self, question_id: question.id, question_choice_id: cr.to_i)
            end


          else


        end


      end

    end

  end


  def get_response_hash

    existing_response = self

    user_response_hash = Hash.new


    existing_response.data_form_entity.data_form.questions.each do |question|
      user_response_hash[question.id] = ""
      qresponses = existing_response.data_form_entity_response_values.select{ |qres| (qres.active && qres.question_id == question.id) }
      if !qresponses.blank?
        case question.question_type.name
          when "short_answer", "long_answer", "number"
            user_response_hash[question.id] = qresponses[0].text_response

          when "single_choice"
            user_response_hash[question.id] = qresponses[0].question_choice_id
          else
            user_response_hash[question.id] = qresponses.map(&:question_choice_id)
        end
      end
    end
    return user_response_hash
  end


end
