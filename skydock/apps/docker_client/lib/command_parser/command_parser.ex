defmodule DockerClient.CommandParser do

  def parse_message([ "get", "containers"]) do
    { &DockerClient.CommandHandler.get_containers/2, {} }
  end

  def parse_message([ "start", name_id ]) do
    { &DockerClient.CommandHandler.start_container/2, {name_id} }
  end

  def parse_message([ "stop", name_id ]) do
    { &DockerClient.CommandHandler.stop_container/2, {name_id} }
  end

  def parse_message([ "kill", name_id ]) do
    { &DockerClient.CommandHandler.kill_container/2, {name_id} }
  end

  def parse_message([ "pause", name_id ]) do
    { &DockerClient.CommandHandler.pause_container/2, {name_id} }
  end

  def parse_message([ "unpause", name_id ]) do
    { &DockerClient.CommandHandler.unpause_container/2, {name_id} }
  end

  def parse_message([ "get", "images" ]) do
    { &DockerClient.CommandHandler.get_images/2, {} }
  end

  def parse_message([ "system" ]) do
    { &DockerClient.CommandHandler.get_sys_info/2, {} }
  end

  def parse_message([ "logs", name_id ]) do
    { &DockerClient.CommandHandler.get_logs/2, {name_id} }
  end

  def parse_message([ _ | _ ]) do
    { &DockerClient.TwilioSender.send_response/2, "Invalid Request" }  #TODO: hangle malformed message
  end

  def parse_message(message) do
    message
    |> String.downcase
    |> String.split
    |> DockerClient.CommandParser.parse_message
  end

end
