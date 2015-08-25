module SurveysHelper
  COLORS = {
    normal: "#f3582a",
    highlight: "#f9724a",
    own_choice: "#52668b",
    own_choice_highlight: "#6a7b98"
  }.freeze

  def survey_graph_data(survey)
    answer = survey.answer_by(current_user)

    survey.choices.map do |choice|
      own_choice = answer && answer.choice == choice

      {
        value: choice.answers.count,
        label: choice.body + (own_choice ? " (your answer)" : ""),
        color: own_choice ? COLORS[:own_choice] : COLORS[:normal],
        highlight: own_choice ? COLORS[:own_choice_highlight] : COLORS[:highlight]
      }
    end
  end
end
