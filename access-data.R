# access-data
library(zip)
library(purrr)
library(readr)
library(data.table)
library(RCurl)
library(curl)
library(lobstr)
dl.year <- function(year){
  URL <- paste0("https://www7.fdic.gov/sod/download/ALL_",year,".ZIP")
  curl_download(url=URL,destfile=paste0("data/ALL_",year,".ZIP"))
  unzip(paste0("data/ALL_",year,".ZIP"),exdir = "data")
}

for (i in 1994:2019) { 
  dl.year(i)
}

temp <- list.files(path="data", pattern="*.csv",full.names=TRUE)

df <- data.table::rbindlist(
  map(temp,read_csv),fill=TRUE
)

View(head(df))
obj_size(df)

