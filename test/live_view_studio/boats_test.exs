defmodule LiveViewStudio.BoatsTest do
  use LiveViewStudio.DataCase

  alias LiveViewStudio.Boats

  describe "boats" do
    alias LiveViewStudio.Boats.Boat

    @valid_attrs %{
      image: "some image",
      model: "some model",
      price: "some price",
      type: "some type"
    }
    @update_attrs %{
      image: "some updated image",
      model: "some updated model",
      price: "some updated price",
      type: "some updated type"
    }
    @invalid_attrs %{image: nil, model: nil, price: nil, type: nil}

    def boat_fixture(attrs \\ %{}) do
      {:ok, boat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Boats.create_boat()

      boat
    end

    test "list_boats/0 returns all boats" do
      boat = boat_fixture()
      assert Boats.list_boats() == [boat]
    end

    test "list_boats/1 returns boats filtered by type" do
      fishing = boat_fixture(type: "fishing")
      _sporting = boat_fixture(type: "sporting")

      criteria = [type: "fishing"]

      assert Boats.list_boats(criteria) == [fishing]
    end

    test "list_boats/1 returns boats filtered by price" do
      one_dollar = boat_fixture(price: "$")
      two_dollars = boat_fixture(price: "$$")

      criteria = [prices: ["$"]]

      assert Boats.list_boats(criteria) == [one_dollar]

      criteria = [prices: ["$", "$$"]]

      assert Boats.list_boats(criteria) == [one_dollar, two_dollars]
    end

    test "list_boats/1 returns boats filtered by type and price" do
      fishing_A = boat_fixture(price: "$", type: "fishing")
      _fishing_B = boat_fixture(price: "$$", type: "fishing")
      fishing_C = boat_fixture(price: "$$$", type: "fishing")
      _sporting = boat_fixture(price: "$$", type: "sporting")

      criteria = [type: "fishing", prices: ["$", "$$$"]]

      assert Boats.list_boats(criteria) == [fishing_A, fishing_C]
    end

    test "get_boat!/1 returns the boat with given id" do
      boat = boat_fixture()
      assert Boats.get_boat!(boat.id) == boat
    end

    test "create_boat/1 with valid data creates a boat" do
      assert {:ok, %Boat{} = boat} = Boats.create_boat(@valid_attrs)
      assert boat.image == "some image"
      assert boat.model == "some model"
      assert boat.price == "some price"
      assert boat.type == "some type"
    end

    test "create_boat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Boats.create_boat(@invalid_attrs)
    end

    test "update_boat/2 with valid data updates the boat" do
      boat = boat_fixture()
      assert {:ok, %Boat{} = boat} = Boats.update_boat(boat, @update_attrs)
      assert boat.image == "some updated image"
      assert boat.model == "some updated model"
      assert boat.price == "some updated price"
      assert boat.type == "some updated type"
    end

    test "update_boat/2 with invalid data returns error changeset" do
      boat = boat_fixture()
      assert {:error, %Ecto.Changeset{}} = Boats.update_boat(boat, @invalid_attrs)
      assert boat == Boats.get_boat!(boat.id)
    end

    test "delete_boat/1 deletes the boat" do
      boat = boat_fixture()
      assert {:ok, %Boat{}} = Boats.delete_boat(boat)
      assert_raise Ecto.NoResultsError, fn -> Boats.get_boat!(boat.id) end
    end

    test "change_boat/1 returns a boat changeset" do
      boat = boat_fixture()
      assert %Ecto.Changeset{} = Boats.change_boat(boat)
    end
  end
end
