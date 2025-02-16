defmodule Authenticator.Ports.ResourceManager do
  @moduledoc """
  Port to access ResourceManager domain commands.
  """

  @typedoc "All possible responses"
  @type possible_responses :: {:ok, identity :: struct()} | {:error, :not_found | :invalid_params}

  @doc "Delegates to ResourceManager.get_identity/1"
  @callback get_identity(input :: map()) :: possible_responses()

  @doc "Authenticates the subject using Resource Owner Flow"
  @spec get_identity(input :: map()) :: possible_responses()
  def get_identity(input), do: implementation().get_identity(input)

  defp implementation do
    :authenticator
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:domain)
  end
end
