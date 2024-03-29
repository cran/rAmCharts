#' @title Plotting bullet chart using rAmCharts
#' @description  amBullet computes a bullet chart of the given value.
#' 
#' @param value \code{numeric}, value to display.
#' @param min \code{numeric}, minimum value allowed.
#' @param max \code{numeric}, maximum value allowed.
#' @param val_color \code{character}, color of the bar value, in hexadecimal.
#' @param limit \code{numeric}, target value.
#' @param limit_color \code{character}, color of the target line.
#' @param rates \code{data.frame} with 4 columns: name (character), min (numeric), max (numeric), 
#' and color (character, color in hexadecimal).
#' @param steps \code{logical}, default set to TRUE.
#' @param label \code{character}, label of the bullet.
#' @param horiz \code{logical}, TRUE (default) for an horizontal bullet chart, FALSE for a vertical one.
#' @param ... see \code{\link{amOptions}} for more options.
#' 
#' @examples
#' amBullet(value = 65)
#' 
#' \dontrun{
#' # Other examples available which can be time consuming depending on your configuration.
#' 
#' # Remove steps for background
#' amBullet(value = 65, steps = FALSE)
#' 
#' # Tune the colors with name or HTML code
#' amBullet(value = 65, val_color = "purple", limit_color = "#3c8dbc")
#' 
#' # Change the orientation
#' amBullet(value = 65, steps = FALSE, horiz = FALSE)
#' 
#' # Add text
#' amBullet(value = 65, label = "Evaluation")
#' 
#' # Change min and max values
#' amBullet(value = 65, min = 20, max = 90)
#' }
#'
#'
#' @import pipeR 
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
amBullet <- function(value, min = 0, max = 100, val_color = "#000000",
                     limit = 85, limit_color = "#000000", 
                     steps = TRUE, label = "", horiz = TRUE, rates, ...)
{
  
  if (missing(rates))
    rates <- data.frame(name = c("excelent", "good", "average", "poor", "bad"),
                        min = c(0, 20, 40, 60, 80),
                        max = c(20, 40, 60, 80, 100),
                        color = c("#19d228", "#b4dd1e", "#f4fb16",
                                  "#f6d32b", "#fb7116"),
                        stringsAsFactors = FALSE)
  
  ##Test
  #Test rates
  .testIn(vect = "name", control = colnames(rates))
  .testCharacter(char = rates$name, arg = "rates$name")
  
  .testIn(vect = "min", control = colnames(rates))
  .testNumeric(num = rates$min, arg = "rates$min")
  
  .testIn(vect = "max", control = colnames(rates))
  .testNumeric(num = rates$max, arg = "rates$max")
  
  .testIn(vect = "color", control = colnames(rates))
  .testCharacter(char = rates$color, arg = "rates$color")
  
  .testNumeric(num = value)
  
  .testNumeric(num = min)
  .testNumeric(num = max)
  
  .testCharacter(char = val_color)
  .testNumeric(num = limit)
  
  .testCharacter(char = limit_color)
  
  .testLogical(logi = steps)
  
  .testLogical(logi = horiz)
  
  label <- as.character(label)
  
  
  val_color <- tolower(val_color)
  limit_color <- tolower(limit_color)
  rates$color <- tolower(rates$color)
  
  dataProvider <- data.frame(category = label, t(rates$max - rates$min), stringsAsFactors = FALSE)
  colnames(dataProvider)[-1] <- as.character(rates$name)
  dataProvider$limit <- limit
  dataProvider$full <- max
  dataProvider$bullet <- value
  
  # intialize the chart
  amSerialChart(dataProvider = dataProvider, categoryField = "category",
                rotate = horiz, columnWidth = 1) %>>%
    addValueAxes(minimum = min, maximum = max,
                 stackType = "regular", gridAlpha = 0) %>>%
    addGraph(type = "step", valueField = "limit", columnWidth = 0.5, lineColor = limit_color, 
             lineThickness = 3, noStepRisers = TRUE, stackable = FALSE) %>>%
    (~ chart)
  
  if(steps) {
    sapply(1:nrow(rates), FUN = function(rt) {
      chart <<- addGraph(chart, type = "column", valueField = as.character(rates$name[rt]), fillAlphas = 0.8,
                         lineColor = rates$color[rt], showBalloon = FALSE, columnWidth = 1)
    })
  } else {
    chart <- addGraph(chart, type = "column", valueField = "full", lineAlpha = 0, fillAlphas = 0.8, 
                      fillColors = rates$color, gradientOrientation = ifelse(horiz, "horizontal", "vertical"),
                      showBalloon = FALSE)
  }
  
  chart <- addGraph(chart, type = "column", valueField = "bullet", columnWidth = 0.3, fillAlphas = 1, 
                    lineColor = val_color, clustered = FALSE, stackable = FALSE)
  
  # add argupment 'RType_' for amOptions
  chart <- setProperties(.Object = chart, RType_ = "bullet")
  amOptions(chart, ...)
}