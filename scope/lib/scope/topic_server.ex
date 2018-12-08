defmodule TopicServer do

  @impl true
  def init(topic) do
    Phoenix.PubSub.subscribe(Scope.PubSub, topic)
  end
  @impl true
  def handle_call(:new_msg, payload) do
    process(payload.urgency, payload.value)
  end

  def process(:urgent, value) do
    save_msg([urgency: "#{:urgent}", topic: "#{topic}", from: "#{value[:from]}", content: "#{value[:msg]}"])
  end

  def process(:peripheral, value) do
    save_msg([urgency: "#{:peripheral}", topic: "#{topic}", from: "#{value[:from]}", content: "#{value[:msg]}"])
  end

  def process(:normal, value) do
    save_msg([urgency: "#{:peripheral}", topic: "#{topic}", from: "#{value[:from]}", content: "#{value[:msg]}"])
  end

  def save_msg(payload) do
    msg = %Messages.Message{
      content: payload[:content],
      # timestamps: :calendar.universal_time(),
      # from: payload[:from],
      urgency: payload[:urgency],
      server: payload[:topic]
    }
    Messages.Repo.insert(msg)
  end
end
