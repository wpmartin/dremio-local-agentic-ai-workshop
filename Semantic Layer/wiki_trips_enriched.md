## Data Documentation for Enriched NYC Taxi Trips

This production-level data product, `trips_enriched`, details taxi rides in [New York City](https://en.wikipedia.org/wiki/New_York_City) providing pickup information, trip cost, trip distance, and other information. 

It has been enriched with weather data from a weather station based in New York City.


| status           | description                                                  |
|------------------|--------------------------------------------------------------|
| location_name    | The location of the measured weather information.            |
| pickup_date      | The pickup date of the taxi trip (YYYY-MM-DD).               |
| pickup_time      | The pickup time of the taxi trip (HH24:MI:SS).               |
| passenger_count  | The number of passengers for the taxi trip.                  |
| trip_distance    | The total distance travelled during the trip (miles).        |
| fare_amount      | The fare amount of the taxi trip ($).                        |
| tip_amount       | The tip amount of the taxi trip ($).                         |
| total_amount     | The total cost of the taxi trip, combined fare and tip ($).  |
| average_wind     | The measured avergage windspeed.                             |
| precipitation    | The measured precipitation.                                  |
| snow             | The measured snowfall.                                       |
| snow_depth       | The measured depth of fallen snow on the ground.             |
| temp_min         | The minimum observed temperature (fahrenheit)                |
| temp_max         | The maximum observed temperature (fahrenheit)                |
