% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class_ValueAxis.R
\name{initialize,ValueAxis-method}
\alias{initialize,ValueAxis-method}
\alias{valueAxis}
\alias{setTitle,ValueAxis,character-method}
\title{Initializes ValueAxis}
\usage{
\S4method{initialize}{ValueAxis}(.Object, title, guides, ...)

valueAxis(...)

\S4method{setTitle}{ValueAxis,character}(.Object, title)
}
\arguments{
\item{.Object}{\linkS4class{ValueAxis}.}

\item{title}{\code{character}.}

\item{guides}{\code{list} of \linkS4class{Guide}.}

\item{...}{Other properties (depend of call function)}
}
\description{
Creates a ValuesAxis or updates its properties.
}
\examples{

guides <- list(guide(fillAlpha = .4), guide(fillAlpha = .5))
new("ValueAxis", title = "Hello !",  gridThickness = 1, guides = guides)


valueAxis(title = "Hello !", axisTitleOffset = 12)

setTitle(.Object = valueAxis(), title = "Hello !")

}
