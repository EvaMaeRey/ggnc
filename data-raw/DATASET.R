## code to prepare `DATASET` dataset goes here

library(sf)
nc <- st_read(system.file("shape/nc.shp", package="sf"))
usethis::use_data(nc, overwrite = TRUE)

create_geometries_reference(sfdata = nc,
                            id_cols = c(NAME, FIPS)) %>%
  dplyr::rename(county_name = NAME,
         fips = FIPS) -> reference_full

usethis::use_data(reference_full, overwrite = TRUE)

nc %>%
  st_drop_geometry() ->
nc_flat

usethis::use_data(nc_flat, overwrite = TRUE)


# county centers for labeling polygons
nc |>
  dplyr::pull(geometry) |>
  sf::st_zm() |>
  sf::st_point_on_surface() ->
  points_sf

#https://github.com/r-spatial/sf/issues/231
do.call(rbind, st_geometry(points_sf)) %>%
  tibble::as_tibble() %>% setNames(c("x","y")) ->
  the_coords

cbind(the_coords, nc) %>%
  dplyr::select(x, y, county_name = NAME, fips = FIPS) ->
nc_county_centers


usethis::use_data(nc_county_centers, overwrite = TRUE)
