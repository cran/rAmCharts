#' @title Plotting pie chart
#' 
#' @description  amPie computes a pie chart of the given value.
#' @param data \code{data.frame}, dataframe with at least 2 columns : 
#' label (character), value (numeric). See \code{\link{data_pie}}
#' You can add a third column "color" (character, colors in hexadecimal).
#' @param show_values \code{logical}, TRUE to display values.
#' @param depth \code{numeric}, if > 0, chart is displayed in 3D, value
#' between 0 and 100
#' @param inner_radius \code{numeric}, value between 0 and 100
#' @param ... see \code{\link{amOptions}} for more options.
#' 
#' @examples
#' data("data_pie")
#' amPie(data = data_pie)
#' 
#' \dontrun{
#' # Other examples available which can be time consuming depending on your configuration.
#' 
#' # Don't display values
#' amPie(data = data_pie, show_values = FALSE)
#' 
#' # 3D pie
#' amPie(data = data_pie, depth = 10)
#' 
#' # Donut chart
#' amPie(data = data_pie, inner_radius = 50)
#' 
#' # All parameters
#' amPie(data = data_pie, inner_radius = 50, depth = 10, show_values = FALSE)
#' }
#' @rdname amPie
#' 
#' 
#' @seealso \link{amOptions}, \link{amBarplot}, \link{amBoxplot}, \link{amHist}, \link{amPie},
#' \link{amPlot}, \link{amTimeSeries}, \link{amStockMultiSet}, \link{amBullet}, \link{amRadar}, 
#' \link{amWind}, \link{amFunnel}, \link{amAngularGauge}, \link{amSolidGauge}, \link{amMekko},
#' \link{amCandlestick}, \link{amFloatingBar}, \link{amOHLC}, \link{amWaterfall}
#' 
#' @export
#'
#' @references See online documentation \url{https://datastorm-open.github.io/introduction_ramcharts/}
#' and \link{amChartsAPI}
#' 

amPie <- function(data, show_values = TRUE, depth = 0, inner_radius = 0, ...) {
  
  ##Test
  #data
  data <- .testFormatData(data)
  
  #label
  .testIn(vect = "label", control = colnames(data))
  if(is.factor(data$label)) {
    data$label <- as.character(data$label)
  }
  .testCharacter(char = data$label, arg = "data$label")
  
  #label
  .testIn(vect = "value", control = colnames(data))
  .testNumeric(num = data$value, arg = "data$value")
  
  .testLogicalLength1(logi = show_values)
  .testInterval(num = depth, binf = 0, bsup = 100)

  .testNumericLength1(num = inner_radius)
  .testInterval(num = inner_radius, binf = 0, bsup = 100)
  
  if(!"color" %in% colnames(data)) {
   
    vec_col <- tolower(utils::head(rep(c("#67b7dc", "#fdd400", "#84b761", "#cc4748", 
                                  "#cd82ad", "#2f4074", "#448e4d", "#b7b83f", 
                                  "#b9783f", "#b93e3d", "#913167"), 5), 
                            nrow(data)))
    data$color <- vec_col
  }else{
    .testCharacter(char = data$color)
  }
  
  if(depth > 0) {
    res <- amPieChart(dataProvider = data, valueField = "value", titleField = "label", startDuration = 0,
                      colorField = "color", labelsEnabled = show_values, depth3D = depth,
                      angle = 15, innerRadius = paste(inner_radius,"%"))
  } else {
    res <- amPieChart(dataProvider = data, valueField = "value", titleField = "label", startDuration = 0,
                      colorField = "color", labelsEnabled = show_values,
                      innerRadius = paste(inner_radius,"%"))
  }
  
  
  res <- amOptions(res, ...)
  res
}
