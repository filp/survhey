module SurveysHelper
  COLORS = [
    "#f3582a",
    "#f9724a"
  ]

  def survey_graph_data(survey)
    survey.choices.each_with_index.map do |choice, i|
      switch = i % 2 == 0

      if switch
        color, highlight = COLORS
      else
        highlight, color = COLORS
      end

      {
        value: choice.answers.count,
        label: choice.body,
        color: color,
        highlight: highlight
      }
    end
  end
end
