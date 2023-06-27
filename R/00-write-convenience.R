# template <- 'stamp_sf_nc_alleghany <- function(fill = "red", ...){ stamp_sf_countync(county = "alleghany", fill = fill, ...)}'
#
#
# county_names <- c("ashe"        ,"alleghany"   ,"surry"       ,"currituck"   ,
#                   "northampton" ,"hertford"    ,"camden"      ,"gates"       ,
#                   "warren"      ,"stokes"      ,"caswell"     ,"rockingham"  ,
#                   "granville"   ,"person"      ,"vance"       ,"halifax"     ,
#                   "pasquotank"  ,"wilkes"      ,"watauga"     ,"perquimans"  ,
#                   "chowan"      ,"avery"       ,"yadkin"      ,"franklin"    ,
#                   "forsyth"     ,"guilford"    ,"alamance"    ,"bertie"      ,
#                   "orange"      ,"durham"      ,"nash"        ,"mitchell"    ,
#                   "edgecombe"   ,"caldwell"    ,"yancey"      ,"martin"      ,
#                   "wake"        ,"madison"     ,"iredell"     ,"davie"       ,
#                   "alexander"   ,"davidson"    ,"burke"       ,"washington"  ,
#                   "tyrrell"     ,"mcdowell"    ,"randolph"    ,"chatham"     ,
#                   "wilson"      ,"rowan"       ,"pitt"        ,"catawba"     ,
#                   "buncombe"    ,"johnston"    ,"haywood"     ,"dare"        ,
#                   "beaufort"    ,"swain"       ,"greene"      ,"lee"         ,
#                   "rutherford"  ,"wayne"       ,"harnett"     ,"cleveland"   ,
#                   "lincoln"     ,"jackson"     ,"moore"       ,"mecklenburg" ,
#                   "cabarrus"    ,"montgomery"  ,"stanly"      ,"henderson"   ,
#                   "graham"      ,"lenoir"      ,"transylvania","gaston"      ,
#                   "polk"        ,"macon"       ,"sampson"     ,"pamlico"     ,
#                   "cherokee"    ,"cumberland"  ,"jones"       ,"union"       ,
#                   "anson"       ,"hoke"        ,"hyde"        ,"duplin"      ,
#                   "richmond"    ,"clay"        ,"craven"      ,"scotland"    ,
#                   "onslow"      ,"robeson"     ,"carteret"    ,"bladen"      ,
#                   "pender"      ,"columbus"    ,"new hanover" ,"brunswick"  )
#
# write_convenience <- function(template = template,
#                               replace = "alleghany",
#                               replacements = county_names,
#                               file_name = "R/convenience.R"){
#   data.frame(replacements, template) |>
#     dplyr::mutate(functions = stringr::str_replace_all(template, replace, replacements)) |>
#     dplyr::pull(functions) |>
#     paste(collapse = "
# ") |>
#     writeLines(con = file_name)
# }
# write_convenience()
