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

  OMG_RANDUM_COMMENTS_SO_RANDUM = [
    "you made the right choice",
    "what were you thinking?",
    "that's a pretty solid choice",
    "we think that was a good choice",
    "I would've picked the other option"
  ].freeze

  OMG_RANDUM_QUESTIONS_SPORK = [
    "Where should we get lunch?",
    "Have you ever danced in the rain?",
    "Did you enjoy our last meeting?",
    "Where should we travel next?",
    "Who's winning the [sports] game tonight?",
    "Sequels or prequels?"
  ].freeze

  def page_title
    [content_for(:page_title), "survhey.io"].join(" — ")
  end

  def current_user
    @current_user
  end

  def title(title)
    content_for(:page_title, title)
  end

  def icon(name, klass = nil)
    content_tag(:span, "", class: ["font-icon li-#{name}", klass].compact.join(" "))
  end

  def totally_random_question_placeholder
    OMG_RANDUM_QUESTIONS_SPORK.sample
  end

  def totally_randum_spork_message
    OMG_RANDUM_MESSAGES.sample
  end

  def totally_randum_answer_comment
    OMG_RANDUM_COMMENTS_SO_RANDUM.sample
  end
end
