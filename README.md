
<!-- README.md is generated from README.Rmd. Please edit that file -->

# geniusfetchR

<!-- badges: start -->
<!-- badges: end -->

The goal of geniusfetchR is to to assist researchers who want to build
lyrical datasets for analysis with a collection of helper functions for
fetching song lyrics, album tracklists, and artist discographies from
Genius or other lyrics websites. It was created as a workaround to
several problems encountered in the geniusr package.

## Installation

You can install the development version of geniusfetchR from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("ajholt25/R-Programming")
```

## Examples

### Fetch album lyrics for a specific artist and album:

``` r
library(geniusfetchR)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(rvest)
library(stringr)
library(xml2)
genius_album_fetcher("Fleetwood Mac", "Rumours")
#> # A tibble: 12 × 5
#>    artist        album   song_title             song_lyrics_url       songLyrics
#>    <chr>         <chr>   <chr>                  <chr>                 <chr>     
#>  1 Fleetwood Mac Rumours Second Hand News       https://genius.com/F… " I know …
#>  2 Fleetwood Mac Rumours Dreams                 https://genius.com/F… " Now, he…
#>  3 Fleetwood Mac Rumours Never Going Back Again https://genius.com/F… " She bro…
#>  4 Fleetwood Mac Rumours Don't Stop             https://genius.com/F… " Yesterd…
#>  5 Fleetwood Mac Rumours Go Your Own Way        https://genius.com/F… " Loving …
#>  6 Fleetwood Mac Rumours Songbird               https://genius.com/F… " And the…
#>  7 Fleetwood Mac Rumours The Chain              https://genius.com/F… " (Fuck) …
#>  8 Fleetwood Mac Rumours You Make Loving Fun    https://genius.com/F… "  I neve…
#>  9 Fleetwood Mac Rumours I Don't Want to Know   https://genius.com/F… " I don't…
#> 10 Fleetwood Mac Rumours Oh Daddy               https://genius.com/F… " Oh, dad…
#> 11 Fleetwood Mac Rumours Gold Dust Woman        https://genius.com/F… " Rock on…
#> 12 Fleetwood Mac Rumours Silver Springs         https://genius.com/F… " You cou…
```

### Fetch lyrics for multiple artists and albums:

``` r
library(geniusfetchR)
library(dplyr)
library(rvest)
library(stringr)
library(xml2)
artists <- c("Fleetwood Mac", "Fleetwood Mac", "The Rolling Stones", "The Rolling Stones")
albums <- c("Rumours", "Tusk", "Let It Bleed", "Sticky Fingers")
genius_album_fetcher(artists, albums)
#> # A tibble: 51 × 5
#>    artist        album   song_title             song_lyrics_url       songLyrics
#>    <chr>         <chr>   <chr>                  <chr>                 <chr>     
#>  1 Fleetwood Mac Rumours Second Hand News       https://genius.com/F… " I know …
#>  2 Fleetwood Mac Rumours Dreams                 https://genius.com/F… " Now, he…
#>  3 Fleetwood Mac Rumours Never Going Back Again https://genius.com/F… " She bro…
#>  4 Fleetwood Mac Rumours Don't Stop             https://genius.com/F… " Yesterd…
#>  5 Fleetwood Mac Rumours Go Your Own Way        https://genius.com/F… " Loving …
#>  6 Fleetwood Mac Rumours Songbird               https://genius.com/F… " And the…
#>  7 Fleetwood Mac Rumours The Chain              https://genius.com/F… " (Fuck) …
#>  8 Fleetwood Mac Rumours You Make Loving Fun    https://genius.com/F… "  I neve…
#>  9 Fleetwood Mac Rumours I Don't Want to Know   https://genius.com/F… " I don't…
#> 10 Fleetwood Mac Rumours Oh Daddy               https://genius.com/F… " Oh, dad…
#> # ℹ 41 more rows
```

### Fetch lyrics for a specific song:

``` r
library(geniusfetchR)
library(dplyr)
library(rvest)
library(stringr)
library(xml2)
genius_song_fetcher("The Rolling Stones", "Paint It Black")
#> [1] " I see a red door and I want it painted black No colours anymore, I want them to turn black I see the girls walk by dressed in their summer clothes I have to turn my head until my darkness goes I see a line of cars and they're all painted black With flowers and my love, both never to come back I see people turn their heads and quickly look away Like a newborn baby, it just happens every day I look inside myself and see my heart is black I see my red door, I must have it painted black Maybe then I'll fade away and not have to face the facts It's not easy facing up when your whole world is black No more will my green sea go turn a deeper blue I could not foresee this thing happening to you If I look hard enough into the setting sun My love will laugh with me before the morning comes I see a red door and I want it painted black No colours anymore, I want them to turn black I see the girls walk by dressed in their summer clothes I have to turn my head until my darkness goes I wanna see it painted, painted black Black as night, black as coal I wanna see the sun, blotted out from the sky I wanna see it painted, painted, painted Painted black "
```
