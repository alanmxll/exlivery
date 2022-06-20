defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "save/1" do
    test "should save the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "should return an user when an user is found" do
      :user
      |> build(cpf: "12345678900")
      |> UserAgent.save()

      response = UserAgent.get("12345678900")

      expected_response =
        {:ok,
         %User{
           address: "Random street, 66",
           age: 29,
           cpf: "12345678900",
           email: "johndoe@mail.com",
           name: "John Doe"
         }}

      assert response == expected_response
    end

    test "should return an error when an user is not found" do
      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
