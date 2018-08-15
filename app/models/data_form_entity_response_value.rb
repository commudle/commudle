class DataFormEntityResponseValue < ApplicationRecord
  belongs_to :data_form_entity_response
  belongs_to :question
  belongs_to :question_choice, optional: true




  def self.get_response_text(question, data_form_entity_response)
    qresponses = DataFormEntityResponseValue.joins(
        "LEFT OUTER JOIN question_choices ON data_form_entity_response_values.question_choice_id = question_choices.id"
    ).where(
        'active = ? and data_form_entity_response_values.question_id = ? and data_form_entity_response_id = ?',
        true, question.id, data_form_entity_response.id
    ).select("question_choices.title, text_response")

    if qresponses.length > 0
      case question.question_type.name
        when "short_answer", "long_answer", "number"
          return qresponses[0].text_response.html_safe
        when "single_choice"
          return qresponses[0].title.html_safe
        else
          return qresponses.map(&:title).join("<br>").html_safe
      end
    end

    return ".."

  end

end
