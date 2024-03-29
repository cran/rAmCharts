#' @title Plotting bar chart using rAmCharts
#' @description  amBarplot computes a bar chart of the given values.
#' 
#' @param x \code{character}, column name for x-axis or \code{numeric}, value of the corresponding column.
#' It is optional if argument \code{data} has row names.
#' @param y \code{character}, column name for y-axis or \code{numeric}  vector
#' of the corresponding column. If you want to display a grouped barchart
#' or a stacked barchart, y is a vector of characters or numerics.
#' @param data \code{data.frame}, dataframe with values to display.
#' You can add a column "color" (character, colors in hexadecimal). You can
#' also add a column "description" (character) containing the text you want to
#' display when mouse is on the graphic ('<br>' for a new line). See \link{data_bar}
#' and \link{data_gbar}.
#' @param groups_color \code{character}, vector of colors in hexadecimal, 
#' same length as y.
#' @param xlab \code{character}, label for x-axis.
#' @param ylab \code{character}, label for y-axis.
#' @param horiz \code{logical}, TRUE for an horizontal chart, FALSE for a vertical one
#' If 'horiz' is set to TRUE, the setting 'labelRotation' will be ignored.
#' @param stack_type \code{character}, "regular" if you wish stacked bars, "100" if
#' you want 100 percent stacked bars. Default is set to "none".
#' @param layered \code{logical}, TRUE for layered bars. If TRUE, stack_type must be set
#' to "none".
#' @param show_values \code{logical}, TRUE to display values.
#' @param depth \code{numeric}, if > 0, chart is displayed in 3D. Value between 0 and 100.
#' @param dataDateFormat \code{character}, default set to NULL. Even if your chart parses dates,
#' you can pass them as strings in your dataframe - 
#' all you need to do is to set data date format and the chart will parse dates to date objects.
#' Check this page for available formats.
#' Please note that two-digit years (YY) as well as literal month names (MMM)  are NOT supported in this setting.
#' @param minPeriod Specifies the shortest period of your data.
#' This should be set only if dataDateFormat is not 'NULL'.
#' Possible period values:
#' fff - milliseconds, ss - seconds, mm - minutes, hh - hours, DD - days, MM - months, YYYY - years.
#' It's also possible to supply a number for increments, i.e. '15mm'
#' which will instruct the chart that your data is supplied in 15 minute increments.
#' @param ylim limits for the y axis.
#' @param ... see \link{amOptions} for more options.
#' 
#' @return An object of class \linkS4class{AmChart}.
#' 
#' @details 
#' \strong{Notice about labels:}
#' if the chart has many columns, several labels might be hidden.
#' It depends on the width of the conatainer where the chart is displayed.
#' Zoom on the chart to see if the chart can contain all labels. If not, use the parameter labelRotation.
#' You can also add a cursor to your chart...
#' 
#' 
#' @examples
#' 
#' \dontrun{
#' 
#' # Data
#' data(data_bar)
#' data(data_gbar)
#' 
#' amBarplot(x = "country", y = "visits", data = data_bar, main = "example")
#' 
#' 
#' 
#' # Other examples available which can be time consuming depending on your configuration.
#' 
#' # fixed value axis
#' amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, ylim = c(0, 26))
#' amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, stack_type = "100")
#' 
#' # Test with label rotation
#' amBarplot(x = "country", y = "visits", data = data_bar, labelRotation = -45) 
#' 
#' # Horizontal bar
#' amBarplot(x = "country", y = "visits", data = data_bar, horiz = TRUE, labelRotation = -45)
#' 
#' # 3D bar
#' amBarplot(x = "country", y = "visits", data = data_bar, depth = 15, labelRotation = -45)
#' 
#' # Display values
#' amBarplot(x = "country", y = "visits", data = data_bar, show_values = TRUE, labelRotation = -45)
#' 
#' # Grouped columns
#' amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar)
#' 
#' # Parse dates
#' # Default label: first day of each year
#' amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar,
#'           dataDateFormat = "YYYY", minPeriod = "YYYY")
#' 
#' # Default label: first day of each month
#' amBarplot(x = "month", y = c("income", "expenses"), data = data_gbar,
#'           dataDateFormat = "MM/YYYY", minPeriod = "MM")
#' 
#' amBarplot(x = "day", y = c("income", "expenses"), data = data_gbar,
#'           dataDateFormat = "DD/MM/YYYY")
#'           
#' # Change groups colors
#' amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, 
#'           groups_color = c("#87cefa", "#c7158"))
#' 
#' # Regular stacked bars
#' amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, stack_type = "regular")
#' 
#' # 100% stacked bars
#' amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, stack_type = "100")
#' 
#' # Layered bars
#' amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, layered = TRUE)
#' 
#' # Data with row names
#' dataset <- data.frame(get(x = "USArrests", pos = "package:datasets"))
#' amBarplot(y = c("Murder", "Assault", "UrbanPop", "Rape"), data = dataset, stack_type = "regular")
#' 
#' # Round values
#' amBarplot(x = "year", y = c("in", "ex"), data = data_gbar, precision = 0)
#' }
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
amBarplot <- function(x, y, data, xlab = "", ylab = "", ylim = NULL, groups_color = NULL,
                      horiz = FALSE, stack_type = c("none", "regular", "100"),
                      layered = FALSE, show_values = FALSE, depth = 0, dataDateFormat = NULL,
                      minPeriod = ifelse(!is.null(dataDateFormat), "DD", ""), ...)
{
  #data
  data <- .testFormatData(data)
  stack_type <- match.arg(stack_type)
  .testCharacterLength1(char = xlab)
  .testCharacterLength1(char = ylab)
  .testLogicalLength1(logi = layered)
  .testLogicalLength1(logi = horiz)
  .testLogicalLength1(logi = show_values)
  .testInterval(num = depth, binf = 0, bsup = 100)
  
  # check argument x
  if (missing(x) && !length(rownames(data))) {
    stop("Argument x is not provided and the data.frame does not have row names")
  } else if (missing(x) && length(rownames(data))){
    x <- "xcat_"
    data$xcat_ <- rownames(data)
  } else if (is.character(x) && !(x %in% colnames(data))) {
    stop("Argument x does not correspond to a column name")
  } else if (is.numeric(x) && x > ncol(data)) {
    stop("Error in argument x")
  } else {}
  
  # convert x into character if necessary
  if (is.numeric(x))
    x <- colnames(data)[x]
  # check if the column is compatible
  if (is.factor(data[,x]))
    data[,x] <- as.character(data[,x])
  .testCharacter(char = data[,x])
  
  # check argument y
  y <- match.arg(arg = y, choices = colnames(data), several.ok = TRUE)
  
  sapply(1:length(y), FUN = function(i) {
    if (is.numeric(y[i])) {
      if (y[i] > ncol(data))
        stop("Error in argument x")
      # convert y into character if necessary
      y[i] <<- colnames(data)[y[i]]
    } else if(is.character(y) && !all(y %in% colnames(data))) {
      stop(paste("Cannot extract column(s)", y, "from data"))
    } else {}
    # check if the column is compatible
    if (!is.numeric(data[,y[i]]))
      stop(paste("The column ", y[i], "of the dataframe must be numeric."))
  })
  
  if (layered && stack_type != "none")
    stop("You have to choose : layered or stacked. If layered
         is set to TRUE, stack_type must be equal to 'none'")
  
  if (!is.null(stack_type)) {
    .testCharacter(char = stack_type)
    .testIn(vect = stack_type, control = c("regular", "100", "none"))
  }
  
  stack_type <- switch(stack_type, "100" = "100%", stack_type)
  
  color_palette = c("#67b7dc", "#fdd400", "#84b761", "#cc4748", "#cd82ad", "#2f4074",
                    "#448e4d", "#b7b83f", "#b9783f", "#b93e3d", "#913167")
  
  if (!"color" %in% colnames(data)) {
    if (length(y) == 1) {
      if (!is.null(groups_color)) {
        data$color <- groups_color[1]
      } else {
        data$color <- rep(x = color_palette, length.out = nrow(data))
      }
    } 
  } else {
    if (!is.null(groups_color)) {
      vec_col <- rep(groups_color, nrow(data))
      data$color <- vec_col[1:nrow(data)]
    }
  }
  
  if ((depth3D <- depth) > 0) {
    angle <- 30
  } else {
    angle <- 0
  }

  if (show_values) {
    label_text <- "[[value]]"
  } else {
    label_text <- ""
  }

  if (!is.null(ylim)) {
    ymin <- ylim[1]
    ymax <- ylim[2]
  } else {
    ymin <- NULL
    ymax <- NULL
  }
  pipeR::pipeline(
    amSerialChart(dataProvider = data, categoryField = x, rotate = horiz, 
                  depth3D = depth3D, angle = angle, dataDateFormat = dataDateFormat),
    addValueAxis(title = ylab, position = 'left', stackType = stack_type,
                 minimum = ymin, maximum = ymax, strictMinMax = !is.null(ylim)),
    setCategoryAxis(title = xlab, gridPosition = 'start', axisAlpha = 0, gridAlpha = 0,
                    parseDates = !is.null(dataDateFormat), minPeriod = minPeriod),
    (~ chart)
  )
  
  if (length(y) == 1) {
    if ("description" %in% colnames(data)) {
      tooltip <- '<b>[[description]]</b>'
    } else { 
      tooltip <- '<b>[[value]]</b>'
    }
    
    chart <- addGraph(chart, balloonText = tooltip, fillColorsField = 'color',  fillAlphas = 0.85,
                      lineAlpha = 0.1, type = 'column', valueField = y, labelText = label_text)
  } else {
    if (!is.null(groups_color)) {
      v_col <- rep(x = groups_color, length.out = length(y))
    } else {
      v_col <- rep(x = color_palette, length.out = length(y))
    }
  
    graphs_list <- lapply(X = seq(length(y)), FUN = function (i) {
      if ("description" %in% colnames(data)) {
        tooltip2 <- '<b>[[description]]</b>'
      } else {
        tooltip2 <- paste0(as.character(y[i]),": [[value]]")
      }
      graph_obj <- graph(chart, id = paste0("AmGraph-",i), balloonText = tooltip2, fillColors = v_col[i],
                         legendColor = v_col[i], fillAlphas = 0.85, lineAlpha = 0.1, type = 'column', valueField = y[i],
                         title = y[i], labelText = label_text)
      if (layered) {
        return(setProperties(graph_obj, clustered = FALSE, columnWidth = 0.9/(1.8^(i-1))))
      } else {
        return(graph_obj)
      }
    })
    chart <- setGraphs(chart, graphs = graphs_list)
  }
  
  chart <- setProperties(.Object = chart, RType_ = "barplot")
  amOptions(chart, ...)
}

