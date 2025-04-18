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

- **ID:** `business_id` (UID string) [*ref. `business`*]

- **Dates:** `date` string of comma-separated `YYYY-MM-DD HH:MM:SS`-formatted date strings for each checkin at this business

### `review`
 
 Review data including user_id that wrote the review and business_id for the review is for.

- **Review ID:** `review_id`(UID string)

- **User ID:** `user_id` (UID string)

- **Business ID:** `business_id` (UID string)

- **Rating:** `stars` integer rating given by the user for the business

- **Date:** `date` when the review is given. Formatted as `YYYY-MM-DD` (string)

- **Review:** `text` the review text

- **Votes:** `useful` + `funny` + `cool`  number of votes received for the review in the given categories (integer)

### `tip`

From Yelp:

> Tips are a way to pass along some key information about a business

- **User ID:** `user_id` (UID string) [*ref. `user`*]

- **Business ID:** `business_id` (UID string) [*ref. `business`*]

- **Text:** `text` stores text of the tip 

- **Date:** `YYYY-MM-DD`-formated `date` field

- **Compliment count:** `compliment_count` integral 

### `user`
