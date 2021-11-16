

library(tidyverse)
library(readxl)

download_location <- "~/Downloads/"
years <- as.list(c("00", "01", "02", "03", "04", "05", "06",
              "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"))

allyears <- lapply(years, function(x){
 temp_df <- read_excel(path =paste0(download_location,"/laucnty",x,".xlsx"), 
                        col_names = FALSE, skip = 5) %>% 
  `colnames<-`(c("LAUS_code", "State_FIPS", "County_FIPS", "County_Name",
                 "Year", "skip", "Labor_Force", "Employed", "Unemployed", "Unemployment_Rate")) %>% 
  select(-skip) %>% 
  mutate(year = paste0("20", x))
})
county_data <- bind_rows(allyears)
write_csv(county_data, paste0(download_location, "/county_unemployment_by_year.csv"))