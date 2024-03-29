% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chart_amBarplot.R
\name{amBarplot}
\alias{amBarplot}
\title{Plotting bar chart using rAmCharts}
\usage{
amBarplot(
  x,
  y,
  data,
  xlab = "",
  ylab = "",
  ylim = NULL,
  groups_color = NULL,
  horiz = FALSE,
  stack_type = c("none", "regular", "100"),
  layered = FALSE,
  show_values = FALSE,
  depth = 0,
  dataDateFormat = NULL,
  minPeriod = ifelse(!is.null(dataDateFormat), "DD", ""),
  ...
)
}
\arguments{
\item{x}{\code{character}, column name for x-axis or \code{numeric}, value of the corresponding column.
It is optional if argument \code{data} has row names.}

\item{y}{\code{character}, column name for y-axis or \code{numeric}  vector
of the corresponding column. If you want to display a grouped barchart
or a stacked barchart, y is a vector of characters or numerics.}

\item{data}{\code{data.frame}, dataframe with values to display.
You can add a column "color" (character, colors in hexadecimal). You can
also add a column "description" (character) containing the text you want to
display when mouse is on the graphic ('<br>' for a new line). See \link{data_bar}
and \link{data_gbar}.}

\item{xlab}{\code{character}, label for x-axis.}

\item{ylab}{\code{character}, label for y-axis.}

\item{ylim}{limits for the y axis.}

\item{groups_color}{\code{character}, vector of colors in hexadecimal, 
same length as y.}

\item{horiz}{\code{logical}, TRUE for an horizontal chart, FALSE for a vertical one
If 'horiz' is set to TRUE, the setting 'labelRotation' will be ignored.}

\item{stack_type}{\code{character}, "regular" if you wish stacked bars, "100" if
you want 100 percent stacked bars. Default is set to "none".}

\item{layered}{\code{logical}, TRUE for layered bars. If TRUE, stack_type must be set
to "none".}

\item{show_values}{\code{logical}, TRUE to display values.}

\item{depth}{\code{numeric}, if > 0, chart is displayed in 3D. Value between 0 and 100.}

\item{dataDateFormat}{\code{character}, default set to NULL. Even if your chart parses dates,
you can pass them as strings in your dataframe - 
all you need to do is to set data date format and the chart will parse dates to date objects.
Check this page for available formats.
Please note that two-digit years (YY) as well as literal month names (MMM)  are NOT supported in this setting.}

\item{minPeriod}{Specifies the shortest period of your data.
This should be set only if dataDateFormat is not 'NULL'.
Possible period values:
fff - milliseconds, ss - seconds, mm - minutes, hh - hours, DD - days, MM - months, YYYY - years.
It's also possible to supply a number for increments, i.e. '15mm'
which will instruct the chart that your data is supplied in 15 minute increments.}

\item{...}{see \link{amOptions} for more options.}
}
\value{
An object of class \linkS4class{AmChart}.
}
\description{
amBarplot computes a bar chart of the given values.
}
\details{
\strong{Notice about labels:}
if the chart has many columns, several labels might be hidden.
It depends on the width of the conatainer where the chart is displayed.
Zoom on the chart to see if the chart can contain all labels. If not, use the parameter labelRotation.
You can also add a cursor to your chart...
}
\examples{

\dontrun{

# Data
data(data_bar)
data(data_gbar)

amBarplot(x = "country", y = "visits", data = data_bar, main = "example")



# Other examples available which can be time consuming depending on your configuration.

# fixed value axis
amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, ylim = c(0, 26))
amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, stack_type = "100")

# Test with label rotation
amBarplot(x = "country", y = "visits", data = data_bar, labelRotation = -45) 

# Horizontal bar
amBarplot(x = "country", y = "visits", data = data_bar, horiz = TRUE, labelRotation = -45)

# 3D bar
amBarplot(x = "country", y = "visits", data = data_bar, depth = 15, labelRotation = -45)

# Display values
amBarplot(x = "country", y = "visits", data = data_bar, show_values = TRUE, labelRotation = -45)

# Grouped columns
amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar)

# Parse dates
# Default label: first day of each year
amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar,
          dataDateFormat = "YYYY", minPeriod = "YYYY")

# Default label: first day of each month
amBarplot(x = "month", y = c("income", "expenses"), data = data_gbar,
          dataDateFormat = "MM/YYYY", minPeriod = "MM")

amBarplot(x = "day", y = c("income", "expenses"), data = data_gbar,
          dataDateFormat = "DD/MM/YYYY")
          
# Change groups colors
amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, 
          groups_color = c("#87cefa", "#c7158"))

# Regular stacked bars
amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, stack_type = "regular")

# 100\% stacked bars
amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, stack_type = "100")

# Layered bars
amBarplot(x = "year", y = c("income", "expenses"), data = data_gbar, layered = TRUE)

# Data with row names
dataset <- data.frame(get(x = "USArrests", pos = "package:datasets"))
amBarplot(y = c("Murder", "Assault", "UrbanPop", "Rape"), data = dataset, stack_type = "regular")

# Round values
amBarplot(x = "year", y = c("in", "ex"), data = data_gbar, precision = 0)
}

}
\references{
See online documentation \url{https://datastorm-open.github.io/introduction_ramcharts/}
and \link{amChartsAPI}
}
\seealso{
\link{amOptions}, \link{amBarplot}, \link{amBoxplot}, \link{amHist}, \link{amPie},
\link{amPlot}, \link{amTimeSeries}, \link{amStockMultiSet}, \link{amBullet}, \link{amRadar}, 
\link{amWind}, \link{amFunnel}, \link{amAngularGauge}, \link{amSolidGauge}, \link{amMekko},
\link{amCandlestick}, \link{amFloatingBar}, \link{amOHLC}, \link{amWaterfall}
}
