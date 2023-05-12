# template <- 'geom_sf_nc_alleghany <- function(...){ geom_sf_countync(county = "alleghany", ...)}'
#
#
#
# write_convenience <- function(template = template,
#                               replace = "alleghany",
#                               replacements = nc_flat$NAME |> tolower(),
#                               file_name = "R/convenience.R"){
#
#
#   data.frame(replacements, template) |>
#     dplyr::mutate(functions = stringr::str_replace_all(template, replace, replacements)) |>
#     dplyr::pull(functions) |>
#     paste(collapse = "
# ") |>
#     writeLines(con = file_name)
#
#
#
# }
#
# write_convenience()
