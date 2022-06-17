defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "should return an item when all parameters are valid" do
      response = Item.build("Pepperoni pizza", :pizza, "35.5", 1)

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "should return an error when there is an invalid category" do
      response = Item.build("Pepperoni pizza", :invalid, "35.5", 1)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "should return an error when there is an invalid price" do
      response = Item.build("Pepperoni pizza", :pizza, "invalid_price", 1)

      expected_response = {:error, "Invalid price"}

      assert response == expected_response
    end

    test "should return an error when there is an invalid quantity" do
      response = Item.build("Pepperoni pizza", :pizza, "35.5", 0)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
