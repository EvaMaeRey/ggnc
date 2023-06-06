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
