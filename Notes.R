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

glimpse(boysNames)

col_names = colnames(boysNames[[1]])

col_names

boysNames[[1]] <- select(boysNames[[1]], "Name...2" , "Name...6", "Count...3", "Count...7" )
boysNames[[1]]

boysNames[[1]] <- drop_na(boysNames[[1]])
boysNames[[1]]

testBoyNames <- boysNames[[2]]
typeof(testBoyNames)
testBoyNames <- select(testBoyNames, str_subset(colnames(testBoyNames), "Count"), str_subset(colnames(testBoyNames), "Name"))

testBoyNames

condense.baby.names <- function(data.frame)  {
  select(data.frame, str_subset(colnames(data.frame), "Count"), str_subset(colnames(data.frame), "Name"))
}

boyNames <- map(boysNames, condense.baby.names)

x <- 0
for (df in boyNames) {
  x = x + 1
  df <- df[,c(3,1,4,2)]
  boyNames[[x]] <- df
}

boyNames 

map(boyNames, drop_na)

# bayNames <- boyNames[c(3,1,4,2)]
# 
# names(boyNames[[1]][1]) <- ""
# 
boyNames[[1]]<- boyNames[[1]][,c(3,1,4,2)]
boyNames[[1]]










