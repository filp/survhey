module ReactHelper
  def react_component(name, props = {})
    content_tag("div",
      "",
      "data-react-class" => name,
      "data-react-props" => props.to_json
    )
  end
end
