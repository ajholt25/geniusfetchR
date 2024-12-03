#' Fetch Discography for An Artist
#'
#' Retrieves an album list for a specific artist from Genius with the year of release
#'
#' @param artist Character. The name of the artist.
#' @return A tibble with album titles and release year.
#' @export
#' @examples
#' # Fetch the discography for The Rolling Stones
#' genius_discography_fetcher("The Rolling Stones")

genius_discography_fetcher <- function(artist){

  library(geniusr)
  library(rvest)
  library(xml2)
  library(dplyr)
  library(stringr)
  library(tibble)

  # Construct the Genius URL
  # replace spaces with hyphens
  formatted_artist <- str_replace_all(artist, " ", "-")
  # format so that only the first word is capitalized
  formatted_artist <- str_to_sentence(formatted_artist)

  discog_url <- paste0("https://genius.com/", "artists/", formatted_artist, "/albums")

  page <- read_html(discog_url)
  album_text <- page %>%
    html_nodes(".kbIuNQ") %>%
    html_text(trim = TRUE)

  # Regex (?=\\b\\w+ \\d{1,2}, \\d{4}\\b) shows where the date starts
  album_text <- str_split(album_text, "(?<=\\d{4})", simplify = TRUE)[1,]

  # match everything bup to year year and extract
  album_name <- str_extract(album_text, ".*(?=\\d{4})")
  # pull release year into new column
  release_year <- str_extract(album_text, "\\d{4}.*$")

  # create a custom regex pattern to search
  regex_date <- "(January|February|March|April|May|June|July|August|September|October|November|December) \\d{1,2}, \\d{4}"

  # remove remaining date parts from the album name
  album_name <- str_remove(album_text, regex_date)  # Remove matched date text
  album_name <- str_trim(album_name)              # Clean up extra spaces

  # Clean up whitespace
  album_name <- str_trim(album_name)
  release_year <- str_trim(release_year)

  # put everything into a tibble
  discography <- tibble(
    artist = artist,
    album = album_name,
    release_year = release_year
  )


    # Return the discography
    return(discography)
}
