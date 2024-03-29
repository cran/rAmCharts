% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class_ChartCursor.R,
%   R/class_ChartCursor_setters.R
\name{initialize,ChartCursor-method}
\alias{initialize,ChartCursor-method}
\alias{chartCursor}
\alias{setOneBalloonOnly}
\alias{setOneBalloonOnly,ChartCursor,logical-method}
\alias{setValueLineAxis}
\alias{setValueLineAxis,ChartCursor,ValueAxisOrCharacterOrMissing-method}
\title{Initializes a ChartCursor}
\usage{
\S4method{initialize}{ChartCursor}(.Object, oneBalloonOnly, valueLineAxis, ...)

chartCursor(animationDuration = 0.3, oneBalloonOnly, valueLineAxis, ...)

setOneBalloonOnly(.Object, oneBalloonOnly)

\S4method{setOneBalloonOnly}{ChartCursor,logical}(.Object, oneBalloonOnly)

setValueLineAxis(.Object, valueLineAxis = NULL, ...)

\S4method{setValueLineAxis}{ChartCursor,ValueAxisOrCharacterOrMissing}(.Object, valueLineAxis = NULL, ...)
}
\arguments{
\item{.Object}{\linkS4class{ChartCursor}.}

\item{oneBalloonOnly}{\code{logical}, 
if TRUE, border color will be changed when user rolls-over the slice, graph, 
etc, instead of background color.}

\item{valueLineAxis}{\linkS4class{ValueAxis}.
If you set valueLineBalloonEnabled to TRUE,
but you have more than one axis, you can use this property
to indicate which axis should display balloon.}

\item{...}{other properties of ChartCursor.
Run : api("ChartCursor") for more information.}

\item{animationDuration}{\code{numeric}, duration of animation of a line, in seconds.}
}
\value{
(updated) .Object of class \linkS4class{ChartCursor}.
}
\description{
Initializes or updates a \linkS4class{ChartCursor}.
}
\examples{
new("ChartCursor", oneBalloonOnly = TRUE)

chartCursor()
chartCursor(oneBalloonOnly = TRUE)

setOneBalloonOnly(.Object = chartCursor(), oneBalloonOnly = TRUE)
setValueLineAxis(.Object = chartCursor(), id = "valueAxis1",
                 title = "Hello !", axisTitleOffset = 12)
# equivalent to:
valueLineAxis_obj <- valueAxis(id = "valueAxis1", title = "Hello !", axisTitleOffset = 12)
setValueLineAxis(.Object = chartCursor(), valueLineAxis  = valueLineAxis_obj)
# or iff 'valueLineAxis_obj' has already been added to the chart:
setValueLineAxis(.Object = chartCursor(), valueLineAxis  = "valueAxis1")
}
