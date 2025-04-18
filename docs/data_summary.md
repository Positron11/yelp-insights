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
 
 Review data including user_id that wrote the review and business_id for the review is for.

- **Review ID:** `review_id`(22 character unique review string)

- **User ID:** `user_id` (22 character unique review string)

- **Business ID:** `business_id` (22 character unique review string)

- **Rating:** `stars` integer rating given by the user for the business

- **Date:** `date` when the review is given. Format- `YYYY-MM-DD` (string)

- **Review:** `text` the review itself in text

- **Votes:** `useful` + `funny` + `cool`  number of votes received for the review in the given categories (integer)


### `tip`

### `user`

Data related to user including their friend mapping.

- **ID:** `user_id` (UID string)

- **Name:** `name` user's first name (string)

- **Review Count:** `review_count` number of reviews the user has written (integer)

- **Yelp user since:** `yelping_since` date since when the user joined yelp (string, `YYYY-MM-DD`)

- **Friends:** `friends` array containing `user_id` of user's friends (array of strings)

- **Votes:** `useful` + `funny` + `cool` total number of votes of each type which the user has gathered (`integer`)

- **Fans:** `fans` number of fans the user has (`integer`)

- **Elite:** `elite` array containing the years when the user was elite (array of integers)

> [!NOTE] 
> Does 'elite' mean a subscriber of some sort?

- **Average Stars:** `average_stars` average rating of all the reviews (`float`)

- **Compliments:** `compliment_hot`
  - `compliment_more`
  - `compliment_profile`
  - `compliment_cute` 
  - `compliment_list`
  - `compliment_note`
  - `compliment_plain`
  - `compliment_cool`
  - `compliment_funny`
  - `compliment_write`
  - `compliment_photos`

  Number of the particular kinds of compliments received by the user   (`integer`)

> [!NOTE]
> What do profile, cute, note, plain, write compliments mean>