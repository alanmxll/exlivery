defmodule Exlivery.Factory do
  use ExMachina

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
end
