#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
create_labels_script <- function(path = "R/labels.R"){
  writeLines(labels_script)
}

#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
create_stamp_script <- function(path = "R/stamp.R"){
  writeLines(stamp_script, con = path)
}

#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
create_geom_script <- function(path = "R/geom.R"){
  writeLines(stamp_script, con = path)
}

#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
create_dataset_script <- function(path = "data-raw/DATASET.R"){
  writeLines(dataset_script, con = path)
}
