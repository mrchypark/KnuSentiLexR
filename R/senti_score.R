#' sentiments score
#'
#' calculate sentiments scores using KnuSentiLex sentiments words dictionary.
#'
#' @param sentences target sentences
#' @importFrom tokenizers tokenize_ngrams
#' @importFrom stringr str_count
#' @importFrom purrr map_dbl map
#' @export
senti_score <- function(sentences) {
  ngrams <- purrr::map(sentences, ~ token_ngram(.x))
  res <- purrr::map_dbl(ngrams, ~ sum(scoring(.x), na.rm = T))
  return(res)
}

#' sentiments magnitude
#'
#' calculate sentiments magnitude using KnuSentiLex sentiments words dictionary.
#'
#' @param sentences target sentences
#' @importFrom tokenizers tokenize_ngrams
#' @importFrom stringr str_count
#' @importFrom purrr map_dbl map
#' @export
senti_magnitude <- function(sentences) {
  ngrams <- purrr::map(sentences, ~ token_ngram(.x))
  res <- purrr::map_dbl(ngrams, ~ sum(!is.na(scoring(.x)), na.rm = T))
  return(res)
}

token_ngram <- function(sentence){
  tokenizers::tokenize_ngrams(sentence, n = stringr::str_count(sentence, " ") + 1, n_min = 1)[[1]]
}

scoring <- function(word) {
  data(list = "dic", package = "KnuSentiLexR", envir = environment())
  dic[match(word, dic$word), "polarity"]
}
