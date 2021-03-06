#!/usr/bin/env coffee
require("../proof") 26, ({ tz, utc }) ->
  @equal tz("1970-01"), 0, "parse 1970 month"
  @equal tz("1970-01-01"), 0, "parse 1970 date"
  @equal tz("1980-01"), utc(1980, 0, 1), "month with hyphens"
  @equal tz("1980-01-02"), utc(1980, 0, 2), "day with hyphens"
  @equal tz("198001"), Date.UTC(1980, 0, 1),"month"
  @equal tz("19800102"), Date.UTC(1980, 0, 2), "day"
  @equal tz("1980-01T02"), Date.UTC(1980, 0, 1, 2), "month and hours with hyphens and delimiter"
  @equal tz("1980-01 02"), Date.UTC(1980, 0, 1, 2), "month and hours with hyphens"
  @equal tz("1980-01-03T02"), Date.UTC(1980, 0, 3, 2), "hours with hyphens and delimiter"
  @equal tz("1980-01-03 02"), Date.UTC(1980, 0, 3, 2), "hours with hyphens"
  @equal tz("198001T02"), Date.UTC(1980, 0, 1, 2), "month and hours with delimiter"
  @equal tz("198001 02"), Date.UTC(1980, 0, 1, 2), "month and hours"
  @equal tz("19800103T02"), Date.UTC(1980, 0, 3, 2), "hours with delimiter"
  @equal tz("19800103 02"), Date.UTC(1980, 0, 3, 2), "hours"
  @equal tz("19800103T0215"), Date.UTC(1980, 0, 3, 2, 15), "minutes with delimiter"
  @equal tz("19800103 0215"), Date.UTC(1980, 0, 3, 2, 15), "minutes"
  @equal tz("1980-01-03T02:15"), Date.UTC(1980, 0, 3, 2, 15), "minutes with hyphens, colons and delimiter"
  @equal tz("1980-01-03 02:15"), Date.UTC(1980, 0, 3, 2, 15), "minutes with hyphens and colons"
  @equal tz("19800103 021521"), Date.UTC(1980, 0, 3, 2, 15, 21), "seconds"
  @equal tz("19800103T021521"), Date.UTC(1980, 0, 3, 2, 15, 21), "seconds with delimiter"
  @equal tz("1980-01-03 02:15:21"), Date.UTC(1980, 0, 3, 2, 15, 21), "seconds with hyphens and colons"
  @equal tz("1980-01-03T02:15:21"), Date.UTC(1980, 0, 3, 2, 15, 21), "seconds with hyphens, colons, and delimiter"
  @equal tz("19800103T021521.2"), Date.UTC(1980, 0, 3, 2, 15, 21, 2), "milliseconds with delimiter"
  @equal tz("19800103 021521.2"), Date.UTC(1980, 0, 3, 2, 15, 21, 2), "milliseconds"
  @equal tz("1980-01-03T02:15:21.2"), Date.UTC(1980, 0, 3, 2, 15, 21, 2),
         "milliseconds with hyphens, colons and delimiter"
  @equal tz("1980-01-03 02:15:21.2"), Date.UTC(1980, 0, 3, 2, 15, 21, 2), "milliseconds with hyphens and colons"
