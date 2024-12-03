#' Fetch Album Tracklist and Lyrics
#'
#' Retrieves album tracklist and lyrics for a specific artist and album from Genius.
#' Or the function accepts a vector of artist and a vector of corresponding album
#' to fetch data for multiple artist and album.
#'
#' @param artists Character. The name of the artist, or a vector of artist names.
#' @param albums Character. The name of the album, or a vector of album names.
#' Each album in a vector much match the artist.
#' @return A tibble with track titles, lyrics, and metadata for all specified artist
#'   and album.
#' @importFrom geniusr genius_token get_album_tracklist_search
#' @export
#' @examples
#' # Fetch the tracklist and lyrics for Nirvana's album Nevermind
#' genius_album_fetcher("Nirvana", "Nevermind")


genius_album_fetcher <- function(artists, albums) {

  library(geniusr)
  library(rvest)
  library(xml2)
  library(dplyr)
  library(stringr)
  library(tibble)

  # Check if user has set their Genius API token
  if (is.null(genius_token(force = FALSE))) {
    stop("Please set your Genius API key using genius_token('your_api_key_here') before using this function.")
  }

  # Create an empty tibble to hold artist, title, URL, and lyrics
  playlist <- tibble(
    artist = character(),
    album = character(),
    song_title = character(),
    song_lyrics_url = character(),
    songLyrics = character())

  # Outer loop: iterate over artists
  for(i in seq_along(artists)){
    # get current artist and corresponding album
    artist <- artists[i]
    album <- albums[i]


      # get the tracklist for the current artist and album
      tracklist <- get_album_tracklist_search(artist, album)

      # add artist, album, song title, url to playlist. remove song number
      tracklist <- tracklist %>%
        select(-song_number) %>%
        mutate(artist = artist, album = album)

      # bind rows of tracklist to playlist to search for lyrics
      playlist <- bind_rows(playlist, tracklist)

      for(j in seq_len(nrow(playlist))){

        # separate current URL from list
        songURL <- playlist$song_lyrics_url[j]
        ## scrape the lyrics from the web

        # Read the HTML content of the URL with the rvest pkg
        page <- read_html(songURL)

        # Extract parent container, [data-lyrics-container]
        parent <- page %>%
          html_nodes("[data-lyrics-container]")


        # Extract children as raw HTML
        htmlRaw <- parent %>%
          html_children() %>%
          as.character()
        htmlRaw

        # Replace <br> tags with spaces
        htmlClean <- gsub("<br>", " ", htmlRaw, fixed = TRUE)
        htmlClean

        # Remove all remaining HTML tags
        lyrics <- gsub("<[^>]+>", "", htmlClean)
        lyrics

        # Combine all text into a single string
        lyrics <- paste(lyrics, collapse = " ")

        # remove multiple (redundant/extra) spaces
        lyrics <- gsub("\\s+", " ", lyrics)

        # remove verse notations if any remaining
        lyrics <- gsub("\\[.*?\\]", "", lyrics)

        # Add the lyrics to the tracklist tibble
        # assign the song lyrics to the matching song
        playlist$songLyrics[j] <- lyrics
      } # end inner loop

      } # end outer loop
  return(playlist)
}
