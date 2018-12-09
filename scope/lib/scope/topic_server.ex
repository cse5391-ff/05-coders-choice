defmodule TopicServer do
  use GenServer

  @topic

  @impl true
  def init(topic) do
    Phoenix.PubSub.subscribe(Scope.PubSub, topic)
  end

  @impl true
  def handle_call(:new_msg, _from, payload) do
    process(payload.urgency, payload.value)
  end

  def handle_call(:add_usr, user, key) do
    GenServer.start_link(UserServer, user, key)
  end

  def process(:urgent, value) do
    GenServer.multi_call(nodes \\ [node() | Node.list()], name, request, timeout \\ :infinity)
    save_msg([urgency: "#{:urgent}", topic: "#{value[:topic]}", from: "#{value[:from]}", content: "#{value[:msg]}"])
  end

  def process(:peripheral, value) do
    save_msg([urgency: "#{:peripheral}", topic: "#{value[:topic]}", from: "#{value[:from]}", content: "#{value[:msg]}"])
  end

  def process(:normal, value) do
    save_msg([urgency: "#{:peripheral}", topic: "#{value[:topic]}", from: "#{value[:from]}", content: "#{value[:msg]}"])
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
