defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "save the user when all parameters are valid" do
      parameters = %{
        name: "John Doe",
        address: "Random street, 66",
        email: "johndoe@mail.com",
        cpf: "12345678900",
        age: 29
      }

      response = CreateOrUpdate.call(parameters)

      expected_response = {:ok, "User created or update succesfully"}

      assert response == expected_response
    end

    test "return an error when there are invalid parameters" do
      parameters = %{
        name: "John Doe",
        address: "Random street, 66",
        email: "johndoe@mail.com",
        cpf: "12345678900",
        age: 10
      }

      response = CreateOrUpdate.call(parameters)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
