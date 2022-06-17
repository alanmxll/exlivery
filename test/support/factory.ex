defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  def user_factory do
    %User{
      name: "John Doe",
      email: "johndoe@mail.com",
      cpf: "12345678900",
      age: 29,
      address: "Random street, 66"
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "Pepperoni pizza",
      quantity: 1,
      unity_price: Decimal.new("35.5")
    }
  end
end
