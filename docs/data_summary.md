# Data Summary

## Raw Data

### `business`

- **ID:** `business_id` (UID string)

- **Name:** `name`

- **Full address:** `address` + `city` + `state` (2 char. state code) + `postal code` strings

- **Geoposition:** `latitude` + `longitude` floats

- **Popularity:** `stars` (float, rounded to half stars) + `review count` (integer)

- **Is open:** `is_open` boolean

  > [!NOTE]
  > Figure out when `is open` refers to

- **Attributes:** `attributes` object containing attributes as either simple key/value or objects e.g. `"Parking": { "garage": false, "street": true, ... }` etc.

- **Categories:** `categories` list of named restaurant types X falls under

- **Hours:** `hours` object containing key/value pairs for per-day open hours, e.g. `"Monday": "10:00-21:00"`

### `checkin`

- **ID:** `business_id` [*ref. `business`*]
- **Dates:** `date` string of comma-separated `YYYY-MM-DD HH:MM:SS`-formatted date strings for each checkin at this business

### `review`

### `tip`

### `user`
