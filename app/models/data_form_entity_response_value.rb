class DataFormEntityResponseValue < ApplicationRecord
  belongs_to :data_form_entity_response
  belongs_to :question
  belongs_to :question_choice, optional: true




  def self.get_response_value(data_form_entity_response, question_id, question_type)
    qresponses = d.data_form_entity_response_values.select{ |qres| (qres.active && qres.question_id == question_id) }

    case question_type
      when "short_answer", "long_answer", "number", "single_choice"
        return qresponses[0]
      else
        return qresponses
    end
  end

end
