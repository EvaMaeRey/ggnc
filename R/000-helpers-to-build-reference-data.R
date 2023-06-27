#' Title
#'
#' @param bbox
#'
#' @return
#' @export
#'
#' @examples
bbox_to_df <- function(bbox = sf::st_bbox(nc)){

  data.frame(xmin = bbox[[1]],
             ymin = bbox[[2]],
             xmax = bbox[[3]],
             ymax = bbox[[4]])

}


## function to build min max column for each row
#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
#' library(sf)
#' nc <- st_read(system.file("shape/nc.shp", package="sf"))

#' add_row_bounding_box(nc)
add_row_bounding_box <- function(data = nc){

  for (i in 1:nrow(data)){

    if(i == 1){df <- data[i,] %>% sf::st_bbox() %>% bbox_to_df() }else{

      dplyr::bind_rows(df,
                       data[i,] %>% sf::st_bbox() %>% bbox_to_df()) ->
        df
    }

    df

  }

  dplyr::bind_cols(df, data)

}

#' Title
#'
#' @param sfdata
#' @param id_cols
#' @param geometry
#'
#' @return
#' @export
#'
#' @examples
create_geometries_reference <- function(sfdata = nc,
                                        id_cols = c(NAME, FIPS),
                                        geometry = geometry){

  sfdata %>%
    add_row_bounding_box() %>%
    dplyr::select({{id_cols}}, xmin, ymin, xmax, ymax, geometry)

}


# county centers for labeling polygons
#' Title
#'
#' @return
#' @export
#'
#' @examples
prepare_polygon_labeling_data <- function(data_sf = nc, id_cols){

  data_sf |>
  dplyr::pull(geometry) |>
  sf::st_zm() |>
  sf::st_point_on_surface() ->
  points_sf

#https://github.com/r-spatial/sf/issues/231
do.call(rbind, st_geometry(points_sf)) %>%
  tibble::as_tibble() %>% setNames(c("x","y")) ->
  the_coords

cbind(the_coords, data_sf) %>%
  dplyr::select(x, y, {{id_cols}})

}

