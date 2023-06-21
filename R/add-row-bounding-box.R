

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

create_geometries_reference <- function(sfdata = nc,
                                        id_cols = c(NAME, FIPS),
                                        geometry = geometry){

  sfdata %>%
    add_row_bounding_box() %>%
    dplyr::select({{id_cols}}, xmin, ymin, xmax, ymax, geometry)

}


create_compute_panel_template <- function(){

'compute_county <- function(data, scales, state = NULL, county = NULL){


  if(!is.null(state)){

    state %>% tolower() -> state

    reference_full %>%
      dplyr::filter(.data$state_name %in% state) ->
      reference_filtered
  }

  if(!is.null(county)){

    county %>% tolower() -> county

    reference_filtered %>%
      dplyr::filter(.data$county_name %in% county) ->
      reference_filtered

  }

  reference_filtered %>%
    dplyr::select("fips", "geometry", "xmin",
                  "xmax", "ymin", "ymax") ->
    reference_filtered

  data %>%
    tidyr::inner_join(reference_filtered) %>%
    dplyr::mutate(group = -1)

}' %>% cat()


}


create_ggproto_template <- function(){

  'StatCounty <- ggplot2::ggproto(`_class` = "StatCounty",
                               `_inherit` = ggplot2::Stat,
                               # required_aes = c("fips"), #breaks when required!?
                               # setup_data = my_setup_data,
                               compute_panel = compute_county,
                               default_aes = ggplot2::aes(geometry = ggplot2::after_stat(geometry))
)' %>% cat()


}


# create_geom_template()
create_geom_template <- function(){

'geom_sf_county <- function(
  mapping = NULL,
  data = NULL,
  position = "identity",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE, ...) {
  ggplot2::layer(
    stat = StatCounty,  # proto object from step 2
    geom = ggplot2::GeomSf,  # inherit other behavior
    data = data,
    mapping = mapping,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}' %>% cat()

}
