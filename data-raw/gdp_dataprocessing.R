# data-raw/gdp_dataprocessing.R
# Data import and processing pipeline

library(readr)
library(readxl)
library(dplyr)
library(stringr)
library(tidyr)

years <- paste(2015:2023, sep = ",")


#GDP Deflator
gdp_deflator_raw <- read_excel("data-raw/GDP_Deflator.xls",
                               skip = 2)

gdp_deflator <- gdp_deflator_raw |>
  filter(`Country Name`=="Netherlands") |>
  select(`Country Name`, `Country Code`, years) |>
  rename(country_name = `Country Name`,
         country_code = `Country Code`)
colnames(gdp_deflator) = paste0(".",colnames(gdp_deflator))


#Nominal regional GDP
#Source CBS this is total GDP

regional_gdp_raw <- read_delim("data-raw/Regional_GDP.csv",
                           delim = ";", escape_double = FALSE, trim_ws = TRUE)

gdp_regional_nominal <- regional_gdp_raw |>
  mutate(Periods = str_replace(Periods, "\\*$", ""),
         Regions = str_replace(Regions, "\\(PV\\)", "")) |>
  pivot_wider(names_from = Periods,
              values_from = `GDP (market prices) (million euros)`) |>
  rename(region = Regions)
colnames(gdp_regional_nominal) <- paste0(".", colnames(gdp_regional_nominal))

#Real regional GDP

gdp_regional_real <- gdp_regional_nominal |>
  mutate(
    `.2015` = `.2015`/gdp_deflator$`.2015`[1],
    `.2016` = `.2016`/gdp_deflator$`.2016`[1],
    `.2017` = `.2017`/gdp_deflator$`.2017`[1],
    `.2018` = `.2018`/gdp_deflator$`.2018`[1],
    `.2019` = `.2019`/gdp_deflator$`.2019`[1],
    `.2020` = `.2020`/gdp_deflator$`.2020`[1],
    `.2021` = `.2021`/gdp_deflator$`.2021`[1],
    `.2022` = `.2022`/gdp_deflator$`.2022`[1],
  ) |>
  drop_na()







# This should be the last line.
# Note that names are unquoted.
# I like using overwrite = T so everytime I run the script the
# updated objects are saved, but the default is overwrite = F
usethis::use_data(gdp_regional_nominal,
                  gdp_regional_real,
                  gdp_deflator,
                  overwrite = T)
