library(tidyverse)
library(readxl)
library(purrr)
library(stringr)
library(dplyr)

boy.file.names <- list.files(full.names = TRUE)
boy.file.names
excel_sheets(boy.file.names[[1]])

get.data.sheet.name <- function(file, pattern) {
  str_subset(excel_sheets(file), pattern)
}

map(boy.file.names, get.data.sheet.name, pattern = "Table 1")

tmp <- read_excel(
  boy.file.names[1],
  sheet = get.data.sheet.name(boy.file.names[1], pattern = "Table 1"),
  skip = 6

)

glimpse(tmp)

read.baby.names <- function(file) {
  sheet.name <- str_subset(excel_sheets(file), "Table 1")
  read_excel(file, sheet = sheet.name, skip = 6)
}


read.baby.names( boy.file.names[1])

boysNames = map(boy.file.names, read.baby.names)




