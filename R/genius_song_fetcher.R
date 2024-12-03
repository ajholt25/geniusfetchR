#' Fetch Song Lyrics
#'
#' Retrieves album tracklist and lyrics for a specific artist and album from Genius.
#' Or the function accepts a vector of artists and a vector of corresponding albums
#' to fetch data for multiple artists and albums.
#'
#' @param artist Character. The name of the artist
#' @param song_title Character. The name of the song
#' @export
#' @examples
#' # Fetch the lyrics for The Rolling Stone's "Paint It Black"
#' genius_song_fetcher("The Rolling Stones", "Paint It Black")



genius_song_fetcher <- function(artist, song_title) {
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

  formatted_song_title <- str_replace_all(song_title, " ", "-")
  formatted_song_title <- tolower(formatted_song_title)

  song_url <- paste0("https://genius.com/", formatted_artist, "-",
                     formatted_song_title, "-lyrics")

  # Fetch the webpage for the song
  page <- read_html(song_url)

  # Extract parent container, [data-lyrics-container]
  parent <- page %>%
    html_nodes("[data-lyrics-container]")

  # Check if the parent node exists
  if (length(parent) == 0) {
    stop("Could not find the lyrics container on the webpage.")
  }

  # Extract children as raw HTML
  htmlRaw <- parent %>%
    html_children() %>%
    as.character()

  # Replace <br> tags with spaces
  htmlClean <- gsub("<br>", " ", htmlRaw, fixed = TRUE)

  # Remove all remaining HTML tags
  lyrics <- gsub("<[^>]+>", "", htmlClean)

  # Combine all text into a single string
  lyrics <- paste(lyrics, collapse = " ")

  # Remove multiple spaces
  lyrics <- gsub("\\s+", " ", lyrics)

  # Remove verse notations if any remaining
  lyrics <- gsub("\\[.*?\\]", "", lyrics)

  # Return the cleaned lyrics
  return(lyrics)
}

