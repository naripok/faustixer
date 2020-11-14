defmodule Faustixer.HackerRank do
  use HTTPoison.Base

  def process_request_url(url) do
    "https://hacker-news.firebaseio.com/v0" <> url
  end

  def process_response_body(body) do
    Poison.decode! body
  end

  def get_rank() do
    get! "/topstories.json"
  end

  def get_range() do
    get_rank()
    |> get_body
    |> Enum.take(10)
    |> Enum.map(fn i -> get_history(i) end)
  end

  def get_history(item_id) do
    get! ("/item" <> "/#{item_id}.json")
  end

  def get_body(rep) do
    rep.body
  end

end

  # @expected_fields ~w(
  #   login id avatar_url gravatar_id url html_url followers_url
  #   following_url gists_url starred_url subscriptions_url
  #   organizations_url repos_url events_url received_events_url type
  #   site_admin name company blog location email hireable bio
  #   public_repos public_gists followers following created_at updated_at
  # )


  # 
  # def process_response_body(body) do
  #   body
  #   |> Poison.decode!
  #   # |> Map.take(@expected_fields)
  #   |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  # end
