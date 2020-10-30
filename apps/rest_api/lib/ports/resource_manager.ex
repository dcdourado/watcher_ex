defmodule RestAPI.Ports.ResourceManager do
  @moduledoc """
  Port to access Authenticator domain commands.
  """

  @typedoc "All possible create_identity responses"
  @type possible_create_identity_response ::
          {:ok, struct()} | {:error, Ecto.Changeset.t() | :invalid_params}

  @type possible_get_identity_responses ::
          {:ok, struct()} | {:error, :not_found | :invalid_params}

  @doc "Delegates to ResourceManager.create_identity/1"
  @callback create_identity(input :: map()) :: possible_create_identity_response()

  @doc "Delegates to ResourceManager.password_allowed?/1"
  @callback password_allowed?(password :: String.t()) :: boolean()

  @callback get_identity(input :: String.t()) :: possible_get_identity_responses()

  @doc "Create a new identity with it's credentials"
  @spec create_identity(input :: map()) :: possible_create_identity_response()
  def create_identity(input), do: implementation().create_identity(input)

  @doc "Returns an user or application identity seaching by the given input"
  @spec get_identity(input :: String.t()) :: possible_get_identity_responses()
  def get_identity(input), do: implementation().get_identity(input)

  @doc "Checks if the given password is strong enough to be used"
  @spec password_allowed?(password :: String.t()) :: boolean()
  def password_allowed?(password), do: implementation().password_allowed?(password)

  defp implementation do
    :rest_api
    |> Application.get_env(__MODULE__)
    |> Keyword.get(:domain)
  end
end
