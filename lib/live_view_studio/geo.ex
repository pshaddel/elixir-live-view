defmodule LiveViewStudio.Geo do
  @doc """
  Returns a random lat/lng coordinate within the given radius
  of a location.

  Adapted from https://gis.stackexchange.com/questions/25877/generating-random-locations-nearby

  ## Example

      iex> randomNearbyLatLng(39.74, -104.99, 3)
      {39.7494, -105.0014}
  """
  def randomNearbyLatLng(lat, lng, radiusKm, precision \\ 4) do
    radiusRad = radiusKm / 111.3

    u = :rand.uniform()
    v = :rand.uniform()

    w = radiusRad * :math.sqrt(u)
    t = 2 * :math.pi() * v

    x = w * :math.cos(t)
    y1 = w * :math.sin(t)

    # Adjust the x-coordinate for the shrinking
    # of the east-west distances
    latRads = lat / (180 / :math.pi())
    x1 = x / :math.cos(latRads)

    newLat = Float.round(lat + y1, precision)
    newLng = Float.round(lng + x1, precision)

    {newLat, newLng}
  end

  @doc """
  Returns a random lat/lng coordinate within the Denver area.
  """
  def randomDenverLatLng do
    randomNearbyLatLng(39.74, -104.99, 3)
  end
end
