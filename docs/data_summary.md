# Data Summary

## Raw Data

### `business`

- **ID:** `business_id`

- **Name:** `name`

- **Full address:** `address` + `city` + `state` + `postal code`

- **Geoposition:** `latitude` + `longitude`

- **Popularity:** `stars` + `review count`

- **Is open:** `is_open` 

  > [!NOTE]
  > Figure out when `is open` refers to

- **Attributes:** `attributes` oject containing attributes as either simple key/value or objects e.g. `"Parking": { "garage": false, "street": true, ... }` etc.

- **Categories:** `categories` list of restaurant types X falls under

- **Hours:** `hours` objects with key/value pairs for per-day open hours

### `checkin`

- **ID:** `business_id` [*ref. `business`*]
- **Dates:** `date` string of comma-separated `YYYY-MM-DD HH:MM:SS`-formatted date strings for each checkin at this business

### `review`

### `tip`

### `user`
