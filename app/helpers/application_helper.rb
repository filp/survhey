module ApplicationHelper
  OMG_RANDUM_MESSAGES = [
    "loves you",
    "makes surveys easy, fast and fun",
    "is good for your health",
    "exceeds your expectations",
    "is good at the thing it does",
    "is exactly what you dreamed of",
    "is better",
    "watches you sleep",
    "has tickets to that thing you like",
    "wishes you called more often",
    "will be there for you",
    "thrice a day keeps the doctor away"
  ].freeze

  def current_user
    @current_user
  end

  def title(title)
    content_for(:page_title, title)
  end

  def icon(name, klass = nil)
    content_tag(:span, "", class: ["font-icon li-#{name}", klass].compact.join(" "))
  end

  def emojify(content)
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" class="emoji"  />)
      else
        match
      end
    end.html_safe if content.present?
  end

  def totally_randum_spork_message
    OMG_RANDUM_MESSAGES.sample
  end
end
