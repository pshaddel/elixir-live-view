defmodule LiveViewStudioWeb.TopSecretLiveTest do
  use LiveViewStudioWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import LiveViewStudio.AccountsFixtures

  test "redirects to login page if user is not logged in", %{conn: conn} do
    {:error, {:redirect, %{to: "/users/log_in"}}} = live(conn, "/topsecret")
  end

  test "renders restricted page if user is logged in", %{conn: conn} do
    user = user_fixture()

    {:ok, view, _html} =
      conn
      |> log_in_user(user)
      |> live("/topsecret")

    assert render(view) =~ "Top Secret"
  end
end
