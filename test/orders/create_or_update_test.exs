defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      cpf = "12345678900"
      user = build(:user, cpf: cpf)

      Exlivery.start_agents()
      UserAgent.save(user)

      item_1 = %{
        category: :pizza,
        description: "Pizza of pepperoni",
        quantity: 1,
        unity_price: "35.50"
      }

      item_2 = %{
        category: :japonese,
        description: "Atum Temaki",
        quantity: 1,
        unity_price: "31.50"
      }

      {:ok, user_cpf: cpf, item_1: item_1, item_2: item_2}
    end

    test "should save the order when all parameters are valid", %{
      user_cpf: cpf,
      item_1: item_1,
      item_2: item_2
    } do
      parameters = %{user_cpf: cpf, items: [item_1, item_2]}

      response = CreateOrUpdate.call(parameters)

      assert {:ok, _uuid} = response
    end

    test "should return an error when there is no an user with given cpf", %{
      item_1: item_1,
      item_2: item_2
    } do
      parameters = %{user_cpf: "000000000000", items: [item_1, item_2]}

      response = CreateOrUpdate.call(parameters)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "should return an error when there are invalid items", %{
      user_cpf: cpf,
      item_1: item_1,
      item_2: item_2
    } do
      parameters = %{user_cpf: cpf, items: [%{item_1 | quantity: 0}, item_2]}

      response = CreateOrUpdate.call(parameters)

      expected_response = {:error, "Invalid items"}

      assert response == expected_response
    end

    test "should return an error when there aren't items", %{user_cpf: cpf} do
      parameters = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(parameters)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
