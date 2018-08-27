## create the latitude-elevation
lat_elev_profile <- function(file) {
  require(raster)
  require(rgdal)
  options(digits=10)
  rasterOptions(format = "GTiff",
                todisk = TRUE)
  #'~/Documents/GIS_Layers/aster_dtm_v2_twn_wgs84.tif'
  dtm <- raster::raster(file)
  
  dtm_p <- raster::rasterToPoints(dtm)
  rm("dtm")
  invisible(gc())
  
  dtm_lat_elev <- as.data.frame(dtm_p[,2:3])
  colnames(dtm_lat_elev) = c('y', 'z')
  rm("dtm_p")
  invisible(gc())
  
  # use stats::aggregate to calculate the maximum elevational values along latitudinal gradients
  lat_elev_profile <- stats::aggregate(dtm_lat_elev['z'], by = dtm_lat_elev['y'], FUN = max)
  rm("dtm_lat_elev")
  invisible(gc())
  
  return(lat_elev_profile)
}
