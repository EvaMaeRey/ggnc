readLines("R/01-geom-sf-nc-county.R") -> geom_script
readLines("R/02-stamp-sf-nc-county.R") -> stamp_script
readLines("R/03-geom-sf-nc-county-labels.R") -> labels_script

usethis::use_data(geom_script, overwrite = TRUE)
usethis::use_data(stamp_script, overwrite = TRUE)
usethis::use_data(labels_script, overwrite = TRUE)


readLines("data-raw/DATASET.R") -> dataset_script

usethis::use_data(dataset_script, overwrite = TRUE)

