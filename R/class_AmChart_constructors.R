#' @examples
#' \dontrun{
#' amChart(type = "pie")
#' }
#' @rdname initialize-AmChart
#' @export
#' 
amChart <- function(allLabels, arrows, axes, balloon, categoryAxis, categoryField,
                    chartCursor, chartScrollbar, creditsPosition, dataProvider,
                    graph, graphs, guides, legend, segmentsField, theme, titles,
                    trendLines, type, valueAxes, valueAxis,...)
{
  # "http://www.amcharts.com/lib/3/images/"
  object <- new(Class="AmChart")
  if (!missing(allLabels)) object <- setAllLabels(object, allLabels)
  if (!missing(arrows)) object <- setArrows(object, arrows)
  if (!missing(axes)) object <- setAxes(object, axes)
  if (!missing(balloon)) object <- setBalloon( object, balloon)
  if (!missing(categoryAxis)) object <- setCategoryAxis(object, categoryAxis)
  if (!missing(categoryField)) object<- setCategoryField(object, categoryField)
  if (!missing(creditsPosition)) object <- setCreditsPosition(object, creditsPosition)
  if (!missing(chartCursor)) object <- setChartCursor(object, chartCursor)
  if (!missing(chartScrollbar)) object <- setChartScrollbar(object, chartScrollbar)
  if (!missing(dataProvider)) object <- setDataProvider(object, dataProvider)
  if (!missing(graph)) object <- setGraph( object, graph)
  if (!missing(graphs)) object <- setGraphs(object, graphs)
  if (!missing(guides)) object <- setGuides(object, guides)
  if (!missing(legend)) object <- setLegend( object, legend)
  if (!missing(segmentsField)) object@segmentsField <- segmentsField
  if (!missing(type)) object <- setType( object, type)
  if (!missing(theme)) object@theme <- theme
  if (!missing(titles)) object <- setTitles(object, titles)
  if (!missing(trendLines)) object <- setTrendLines(object, trendLines)
  if (!missing(valueAxes)) object <- setValueAxes(object, valueAxes)
  if (!missing(valueAxis)) object <- setValueAxis(object, valueAxis)
  
  object@otherProperties <- c(object@otherProperties, ...)
  validObject(object)
  return(object)
}

#' @details amAngularGaugeChart is a shortcut for instantiating AmChart of type \code{gauge}.
#' @examples
#' \dontrun{
#' amAngularGaugeChart()
#' }
#' @rdname initialize-AmChart
#' @export
amAngularGaugeChart <- function(arrows, titles, axes, ...)
{
  object <- amChart(arrows = arrows, titles = titles, axes = axes, type = "gauge", ...)
  validObject(object)
  return(object)
}

#' @details amFunnelChart is a shortcut
#' for instantiating AmChart of type \code{funnel}.
#' @param marginLeft \code{character}, left margin of the chart.
#' @param marginRight \code{character}, right margin of the chart.
#' @examples
#' \dontrun{
#' amFunnelChart(marginLeft = 15)
#' }
#' @rdname initialize-AmChart
#' @export
amFunnelChart <- function(dataProvider, marginLeft = 10, marginRight = 10,...)
{
  object <- amChart(dataProvider = dataProvider, marginLeft = marginLeft, marginRight = marginRight,
                    type = "funnel", ...)
  validObject(object)
  return(object)
}

#' @details amRadarChart is a shortcut
#' for instantiating AmChart of type \code{radar}.
#' @examples
#' \dontrun{
#' amRadarChart()
#' }
#' @rdname initialize-AmChart
#' @export
amRadarChart <- function(allLabels,
                         balloon,
                         categoryField,
                         creditsPosition,
                         dataProvider,
                         graphs,
                         guides,
                         legend,
                         titles,
                         valueAxes, ...)
{
  object <- amChart(allLabels = allLabels, balloon = balloon,
                    categoryField = categoryField, creditsPosition = creditsPosition,
                    dataProvider = dataProvider, graphs = graphs, guides = guides,
                    legend = legend, titles = titles, valueAxes = valueAxes, type = "radar",...)
  validObject(object)
  return(object)
}

#' @details amSerialChart is a shortcut constructor 
#' for instantiating AmChart of type \code{serial}.
#' @examples
#' \dontrun{
#' amSerialChart(creditsPostion = "top-right")
#' }
#' @rdname initialize-AmChart
#' @export
amSerialChart <- function(allLabels, balloon, categoryAxis, categoryField, chartCursor,
                          chartScrollbar, creditsPosition, dataProvider, graphs, guides,
                          legend, titles, trendLines, valueAxes, ...)
{
  object <- amChart(allLabels = allLabels, balloon = balloon, categoryAxis = categoryAxis,
                    categoryField = categoryField, chartCursor = chartCursor,
                    chartScrollbar = chartScrollbar, creditsPosition = creditsPosition,
                    dataProvider = dataProvider, graphs = graphs, guides = guides, legend = legend,
                    titles = titles, trendLines = trendLines,
                    valueAxes = valueAxes, type = "serial",...)
  validObject(object)
  return(object)
}

#' @details amPieChart is a shortcut constructor
#' for instantiating AmChart of type \code{pie}.
#' @examples
#' \dontrun{
#' amPieChart()
#' }
#' @rdname initialize-AmChart
#' @export
amPieChart <- function(allLabels,
                       balloon,
                       creditsPosition,
                       dataProvider,
                       legend,
                       titles, ...)
{
  object <- amChart(allLabels = allLabels, balloon = balloon, creditsPosition = creditsPosition,
                    dataProvider = dataProvider, legend = legend, titles = titles,
                    type = "pie", ...)
  validObject(object)
  return(object)
}

#' @details amGanttChart is a constructor
#' for instantiating AmChart of type \code{gantt}.
#' @examples
#' \dontrun{
#' amGanttChart(segmentsField = "segments")
#' }
#' @rdname initialize-AmChart
#' @export
amGanttChart <- function(categoryField,
                         dataProvider,
                         graph,
                         segmentsField,
                         valueAxis,...)
{
  object <- amChart( categoryField = categoryField, dataProvider = dataProvider,
                     graph = graph, segmentsField = segmentsField, valueAxis = valueAxis,
                     type = "gantt", ... )
  validObject(object)
  return(object)
}

#' @details amXYChart is a shortcut constructor
#' for instantiating AmChart of type \code{xy}.
#' @examples
#' \dontrun{
#' amXYChart()
#' }
#' @rdname initialize-AmChart
#' @export
amXYChart <- function(creditsPosition, dataProvider, graphs, ...)
{
  object <- amChart(creditsPosition = creditsPosition, dataProvider = dataProvider,
                    graphs = graphs, type = "xy", ...)
  validObject(object)
  return(object)
}




