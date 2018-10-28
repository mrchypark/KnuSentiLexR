library(dplyr)
library(tibble)
library(jsonlite)
library(stringr)

tar <- "https://github.com/park1200656/KnuSentiLex/blob/master/KnuSentiLex/data/SentiWord_info.json?raw=true"
path <- "./data-raw/SentiWord_info.json"

download.file(tar, path)

dic <- fromJSON(path) %>%
  as_tibble() %>%
  mutate(
    polarity = as.numeric(polarity)
    , ngram = stringr::str_count(word, " ") + 1
    ) %>%
  filter(ngram < 4) %>%
  select(word, polarity)

use_data(dic, overwrite = T)
