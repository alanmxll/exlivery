defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "should return an user when all parameters are valid" do
      response =
        User.build(
          "Random street, 66",
          "John Doe",
          "johndoe@mail.com",
          "12345678900",
          29
        )

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "should return an error when are invalid parameters" do
      response =
        User.build(
          "Random street",
          "Jane Doe",
          "janedoe@mail.com",
          "12345678900",
          15
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
