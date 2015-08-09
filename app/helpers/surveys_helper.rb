module SurveysHelper
  def survey_graph_data(survey)
    data = survey.choices.map do |choice|
      {
        value: choice.answers.count,
        label: choice.body,
        color: "#f3582a",
        highlight: "#f9724a",
      }
    end

    data.to_json
  end
end
