#' Fetch Text or Lyrics from a Web Page
#'
#' Retrieves text or lyrics from a webpage other than Genius.
#'
#' @param url Character. The url of the web page to scrape text from.
#'
#' #' @examples
#' Fetch the text for Book 2 of the Iliad
#' webfetcheR("https://www.theoi.com/Text/HomerIliad2.html)

webfetcheR <- function(url) {
  library(geniusr)
  library(rvest)
  library(xml2)
  library(dplyr)
  library(stringr)
  library(tibble)

  # Read the HTML content of the URL
  page <- read_html(url)

  # Extract text from <p> tags
  elements <- page %>%
    html_nodes("p") %>%  # Locate <p> tags
    html_text(trim = TRUE)  # Extract text and trim spaces

  # Combine all extracted text into a single string
  text <- paste(elements, collapse = " ")

  # Remove redundant spaces
  text <- gsub("\\s+", " ", text)

  # Return the cleaned text
  return(text)
}
