library(tidyverse)
library(janitor)
library(readxl)
library(lubridate)
#Load solar data for June, 2023
production_June <-
  read_excel("Data/sunpower_export_20230601_20230630.xlsx") |>
  clean_names() |>
  rename(date = period)
summary(production_June)
summary(production_June$solar_production_k_wh)
#Clean period
production_June_2 <- 
  production_June |>
  mutate(
    # Clean the string by removing unnecessary text
    date = str_replace(date, "Thursday, ", ""),
    date = str_replace(date, "Friday, ", ""),
    date = str_replace(date, "Saturday, ", ""),
    date = str_replace(date, "Sunday, ", ""),
    date = str_replace(date, "Monday, ", ""),
    date = str_replace(date, "Tuesday, ", ""),
    date = str_replace(date, "Wednesday, ", ""),
    #I made this regular expression using https://regex101.com/
    date = str_replace(date, "(.*-.*) -.*$", "\\1"),
    date = parse_date_time(date, "mdy HMp")
    )

summary(production_June_2$date)
#plot the relationship between date and production in kwh
plot(production_June_2$date, production_June_2$solar_production_k_wh, type ="l")



