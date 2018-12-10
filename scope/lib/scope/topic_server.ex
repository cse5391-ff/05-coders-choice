defmodule TopicServer do
  use GenServer

  @topic

  import Ecto.Query

  @impl true
  def init(topic) do
    Phoenix.PubSub.subscribe(Scope.PubSub, topic)
  end

  @impl true
  def handle_call(:new_msg, _from, payload) do
    process(payload.urgency, payload.value)
  end

  def handle_call(:add_usr, user, key) do
    {:ok, pid} = GenServer.start_link(UserServer, user, key)
  end

  def handle_call(:return_msgs, from, state) do
    # Create a query
    query = from u in "messages",
    where: u.topic == @topic,
    select: u.message

    query = Repo.all(query)
    |>handle_query
    GenServer.call(from, :res, query)
  end

  def handle_query(result) do
    result
    |> grab_urgent
    |> grag_peripheral
    |> grap_normal
  end

  def grab_urgent(load, ) do

  end

  def grab_peripheral(load) do

  end

  def grab_normal(load) do

  end

  def process(:urgent, value) do
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
