
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggnc

<!-- badges: start -->

<!-- badges: end -->

The goal of ggnc is to allow you to easily create maps of North Carolina
Counties from flat data. Flat files will contain ids and characteristics
of a county, but not the longitude and latitudes that define the
parimeters of the counties.

North Carolina is the worked example in the sf package, for this reason,
ggnc as an extension package deserves special attention and polishing as
a possible reference point for other projects like ggfips, ggbrazil,
ggswitzerland, ggunitedstates, etc.

## Installation

You can install the development version of ggnc from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("EvaMaeRey/ggnc")
```

## Contrasting the base ggplot2 approach and the ggnc approach…

This is a basic example which shows you how to solve a common problem:

``` r
library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.0     ✔ readr     2.1.4
#> ✔ forcats   1.0.0     ✔ stringr   1.5.0
#> ✔ ggplot2   3.4.1     ✔ tibble    3.2.0
#> ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
#> ✔ purrr     1.0.1     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
library(ggnc)
## basic example code
```

The base ggplot2 approach is to use an sf object as a data input. This
sf object contains a special geometry column with information on the
geographic shape information.

``` r
class(nc)
#> [1] "sf"         "data.frame"
names(nc)
#>  [1] "AREA"      "PERIMETER" "CNTY_"     "CNTY_ID"   "NAME"      "FIPS"     
#>  [7] "FIPSNO"    "CRESS_ID"  "BIR74"     "SID74"     "NWBIR74"   "BIR79"    
#> [13] "SID79"     "NWBIR79"   "geometry"

nc %>% 
  ggplot() + 
  geom_sf() + 
  aes(fill = SID74)  ->
classic_approach

classic_approach
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

However, sometimes analysts will only have flat files as an initial
starting point. They won’t have this special geometry column at their
disposal. ggnc anticipates this starting point – and nevertheless makes
it easy to create a map.

``` r
library(tidyverse)
nc_flat %>%
  ggplot() +
  aes(fips = FIPS) +
  geom_sf_countync() + 
  aes(fill = SID74)  ->
flat_file_friendly_approach

flat_file_friendly_approach
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

# more dynamic color

``` r
last_plot() + 
  aes(fill = SID74) +
  scale_fill_viridis_c()
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

# highlighting via in-situ subsetting

``` r
last_plot() + 
  geom_sf_countync(county = "Ashe", color = "red", lwd = .5)
#> Joining with `by = join_by(fips)`
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

``` r


last_plot() + 
  geom_sf_countync(county = c("Alleghany", "Warren"), 
                   color = "plum", lwd = .5)
#> Joining with `by = join_by(fips)`
#> Joining with `by = join_by(fips)`
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-5-2.png" width="100%" />

# using stamp convenience function.

``` r
nc_flat %>% 
  select(FIPS, BIR74:NWBIR79) %>% 
  pivot_longer(-FIPS) %>% 
  group_by(name) %>%
  mutate(value_sds = (value - mean(value, na.rm = T))/sd(value, na.rm = T)) %>%
  mutate(rank = rank(value)) %>%
  ggplot() + 
  aes(fips = FIPS) +
  aes(fill = rank) + 
  geom_sf_countync() +
  facet_wrap(~name)
#> Joining with `by = join_by(fips)`
#> Joining with `by = join_by(fips)`
#> Joining with `by = join_by(fips)`
#> Joining with `by = join_by(fips)`
#> Joining with `by = join_by(fips)`
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

``` r

nc_flat %>% 
  ggplot() + 
  aes(fips = FIPS) + 
  geom_sf_countync() +
  ggnc:::stamp_sf_nc_alamance(fill = "darkred") + 
  ggnc:::stamp_sf_nc_beaufort(fill = "green")
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-6-2.png" width="100%" />

# Annotation

``` r
ggnc::nc_flat %>%
  ggplot() +
  aes(fips = FIPS, label = NAME) +
  geom_label_nc_county()
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />

``` r

ggnc::nc_flat %>%
 ggplot() +
 aes(fips = FIPS, label = NAME) +
 geom_sf_countync() +
 geom_label_nc_county()
#> Joining with `by = join_by(fips)`
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-7-2.png" width="100%" />

``` r

 ggnc::nc_flat %>%
 ggplot() +
 aes(fips = FIPS, label = SID74, fill = SID74) +
 geom_sf_countync() +
 geom_label_nc_county(color = "oldlace")
#> Joining with `by = join_by(fips)`
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-7-3.png" width="100%" />

``` r
 
 ggnc::nc_flat %>%
 ggplot() +
 aes(fips = FIPS, fill = SID74,
     label = paste0(NAME, "\n", SID74)) +
 geom_sf_countync() +
 geom_label_nc_county(lineheight = .7,
 size = 2, check_overlap= T, color = "oldlace")
#> Joining with `by = join_by(fips)`
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-7-4.png" width="100%" />

## mostly there\!

``` r
identical(flat_file_friendly_approach, classic_approach)
#> [1] FALSE
library(patchwork)

flat_file_friendly_approach + classic_approach
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-8-1.png" width="100%" />

``` r

flat_file_friendly_approach / classic_approach
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-8-2.png" width="100%" />

``` r
layer_data(classic_approach) %>% head()
#>      fill                       geometry PANEL group      xmin      xmax
#> 1 #142E47 MULTIPOLYGON (((-81.47276 3...     1    -1 -84.32385 -75.45698
#> 2 #132B43 MULTIPOLYGON (((-81.23989 3...     1    -1 -84.32385 -75.45698
#> 3 #1A3955 MULTIPOLYGON (((-80.45634 3...     1    -1 -84.32385 -75.45698
#> 4 #142E47 MULTIPOLYGON (((-76.00897 3...     1    -1 -84.32385 -75.45698
#> 5 #204464 MULTIPOLYGON (((-77.21767 3...     1    -1 -84.32385 -75.45698
#> 6 #1D3E5D MULTIPOLYGON (((-76.74506 3...     1    -1 -84.32385 -75.45698
#>       ymin     ymax linetype alpha stroke
#> 1 33.88199 36.58965        1    NA    0.5
#> 2 33.88199 36.58965        1    NA    0.5
#> 3 33.88199 36.58965        1    NA    0.5
#> 4 33.88199 36.58965        1    NA    0.5
#> 5 33.88199 36.58965        1    NA    0.5
#> 6 33.88199 36.58965        1    NA    0.5
layer_data(flat_file_friendly_approach) %>% head()
#> Joining with `by = join_by(fips)`
#>      fill                       geometry PANEL group      xmin      xmax
#> 1 #142E47 MULTIPOLYGON (((-81.47276 3...     1    -1 -81.74107 -81.23989
#> 2 #132B43 MULTIPOLYGON (((-81.23989 3...     1    -1 -81.34754 -80.90344
#> 3 #1A3955 MULTIPOLYGON (((-80.45634 3...     1    -1 -80.96577 -80.43531
#> 4 #142E47 MULTIPOLYGON (((-76.00897 3...     1    -1 -76.33025 -75.77316
#> 5 #204464 MULTIPOLYGON (((-77.21767 3...     1    -1 -77.90121 -77.07531
#> 6 #1D3E5D MULTIPOLYGON (((-76.74506 3...     1    -1 -77.21767 -76.70750
#>       ymin     ymax linetype alpha stroke
#> 1 36.23436 36.58965        1    NA    0.5
#> 2 36.36536 36.57286        1    NA    0.5
#> 3 36.23388 36.56521        1    NA    0.5
#> 4 36.07282 36.55716        1    NA    0.5
#> 5 36.16277 36.55629        1    NA    0.5
#> 6 36.23024 36.55629        1    NA    0.5

layer_scales(classic_approach) %>% head()
#> $x
#> <ScaleContinuousPosition>
#>  Range:  -84.3 -- -75.5
#>  Limits: -84.3 -- -75.5
#> 
#> $y
#> <ScaleContinuousPosition>
#>  Range:  33.9 -- 36.6
#>  Limits: 33.9 -- 36.6
layer_scales(flat_file_friendly_approach) %>% head()
#> Joining with `by = join_by(fips)`
#> $x
#> <ScaleContinuousPosition>
#>  Range:  -84.3 -- -75.5
#>  Limits: -84.3 -- -75.5
#> 
#> $y
#> <ScaleContinuousPosition>
#>  Range:  33.9 -- 36.6
#>  Limits: 33.9 -- 36.6

layer_grob(classic_approach)[[1]]
#> pathgrob[GRID.pathgrob.928]
layer_grob(flat_file_friendly_approach)[[1]]
#> Joining with `by = join_by(fips)`
#> pathgrob[GRID.pathgrob.929]
```

## greedy aes behavior in all sf layers makes for clunkier interface

I need to look for a better example/refine the issue.

``` r
nc_flat %>% 
  ggplot() +
  aes(x = AREA, y = PERIMETER) +
  geom_point(aes(fips = NULL)) + 
  aes(fips = fips)
```

<img src="man/figures/README-unnamed-chunk-10-1.png" width="100%" />

## might be nice to keep *all* of the reference geometries

Haven’t been able to do that, throwing error. The result with partial
data to be displayed.

``` r
nc_flat %>% 
  slice_sample(n = 50, replace = F) %>% 
  ggplot() + 
  aes(fips =FIPS) +
  geom_sf_countync() + 
  aes(fill = SID74)
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-11-1.png" width="100%" />

``` r

nc %>% 
  mutate(SID74 = ifelse(SID74>15, NA, SID74)) %>% 
  ggplot() + 
  geom_sf() +
  aes(fill = SID74)
```

<img src="man/figures/README-unnamed-chunk-11-2.png" width="100%" />

``` r

nc_flat %>% 
  filter(SID74 <= 15) %>% 
  ggplot() + 
  aes(fips =FIPS) +
  geom_sf_countync() + 
  aes(fill = SID74)
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-11-3.png" width="100%" />

``` r

nc_flat %>% 
  filter(SID74 <= 15) %>% 
  ggplot() + 
  aes(fips =FIPS) +
  stamp_sf_countync(fill = "darkgrey") +
  geom_sf_countync() + 
  aes(fill = SID74)
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-11-4.png" width="100%" />

``` r

nc_flat %>% 
  mutate(SID74 = ifelse(SID74 > 15, NA, SID74)) %>% 
  ggplot() + 
  aes(fips = FIPS) +
  geom_sf_countync() + 
  aes(fill = SID74)
#> Joining with `by = join_by(fips)`
```

<img src="man/figures/README-unnamed-chunk-11-5.png" width="100%" />

# this right join attempt throws an error. Not sure why how to address. But also thinking maybe inner join is the right default at least.

``` r
compute_county_nc <- function(data, scales, county = NULL){

  reference_filtered <- reference_full
  #
  if(!is.null(county)){

    county %>% tolower() -> county

    reference_filtered %>%
      dplyr::filter(.data$county_name %>%
                      tolower() %in%
                      county) ->
      reference_filtered

  }

  # to prevent overjoining
  reference_filtered %>%
    dplyr::select("fips", "geometry", "xmin",
                  "xmax", "ymin", "ymax") ->
    reference_filtered


  data %>%
    dplyr::right_join(reference_filtered, by = join_by(fips)) %>%
    dplyr::mutate(group = -1) %>%
    dplyr::select(-fips)

}


StatCountync <- ggplot2::ggproto(`_class` = "StatCountync",
                               `_inherit` = ggplot2::Stat,
                               compute_panel = compute_county_nc,
                               default_aes = ggplot2::aes(geometry =
                                                            ggplot2::after_stat(geometry)))

geom_sf_countync <- function(
                                 mapping = NULL,
                                 data = NULL,
                                 position = "identity",
                                 na.rm = FALSE,
                                 show.legend = NA,
                                 inherit.aes = TRUE, ...
                                 ) {

                                 c(ggplot2::layer_sf(
                                   stat = StatCountync,  # proto object from step 2
                                   geom = ggplot2::GeomSf,  # inherit other behavior
                                   data = data,
                                   mapping = mapping,
                                   position = position,
                                   show.legend = show.legend,
                                   inherit.aes = inherit.aes,
                                   params = rlang::list2(na.rm = na.rm, ...)),
                                   coord_sf(default = TRUE)
                                 )

                 }

nc_flat %>% 
  filter(SID74 <= 15) %>% 
  ggplot() + 
  aes(fips =FIPS) +
  geom_sf_countync() + 
  aes(fill = SID74)
#> Error in `scale_apply()`:
#> ! `scale_id` must not contain any "NA"
```

    Backtrace:
     1. base (local) `<fn>`(x)
     2. ggplot2:::print.ggplot(x)
     4. ggplot2:::ggplot_build.ggplot(x)
     5. layout$train_position(data, scale_x(), scale_y())
     6. ggplot2 (local) train_position(..., self = self)
     7. self$facet$train_scales(...)
     8. ggplot2 (local) train_scales(...)
     9. ggplot2:::scale_apply(layer_data, x_vars, "train", SCALE_X, x_scales)
