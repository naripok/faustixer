defmodule Faustixer.Consumer do
  @moduledoc """
  Faustinho Discord bot, Elixir edition
  """

  use Nostrum.Consumer

  alias Nostrum.Api

  import Faustixer.HackerRank

  def start_link do
    Consumer.start_link(__MODULE__)
    IO.puts("Started link.")
  end

  @doc """
  Handle discords events
  """
  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    unless msg.author.bot do
      case msg.content do
        ".hr" ->
          rep = get_range()

          Enum.map(
            rep,
            fn {:ok, x} ->
              IO.puts("#{x.body["url"]}")
              Api.create_message(msg.channel_id, x.body["url"])
            end
          )

        ".raise" ->
          # This won't crash the entire Consumer.
          raise "No problems here!"

        ".sleep" ->
          Api.create_message(msg.channel_id, "Going to sleep...")
          # This won't stop other events from being handled.
          Process.sleep(3000)

        _ ->
          :ignore
      end
    end
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
