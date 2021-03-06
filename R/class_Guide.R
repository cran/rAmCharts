#' @include class_AmObject.R utils_basicClassUnions.R
NULL

#' @title Guide class
#' @author datastorm-open
#' 
#' @description Creates a horizontal/vertical guideline-/area for
#' amSerialChart, amXYChart and amRadarChart charts,
#' automatically adapts it's settings from the axes if none has been specified.
#' @details Run \code{api("Guide")} for more information and all avalaible properties.
#' 
#' @slot fillAlpha \code{numeric}.
#' Specifies if a grid line is placed on the center of a cell or on the beginning of a cell.
#' Possible values are: "start" and "middle" This setting doesn't work if parseDates is set to TRUE.
#' @slot valueAxis \linkS4class{ValueAxis}.
#' As you can add guides directly to the chart, you might need to specify 
#' which value axis should be used.
#' @slot listeners \code{list} containining the listeners to add to the object.
#' The list must be named as in the official API. Each element must be a character string.
#' @slot otherProperties \code{list}
#' containing other avalaible properties not yet implemented in the package.
#' @slot value \code{numeric}.
#' 
#' @export
setClass(Class = "Guide", contains = "AmObject",
         representation = representation(fillAlpha = "numeric", valueAxis = "listOrCharacter"))

#' @title Initializes a Guide
#' @description Uses the constructor to create the object
#' or update an existing one with the setters.
#' 
#' @param .Object \linkS4class{Guide}
#' @param fillAlpha \code{numeric}, 
#' specifies if a grid line is placed on the center of a cell or on the beginning of a cell.
#' Possible values are: "start" and "middle"
#' This setting doesn't work if parseDates is set to TRUE.
#' @param valueAxis \linkS4class{ValueAxis} class.
#' As you can add guides directly to the chart, you might need to specify 
#' which value axis should be used.
#' @param value \code{numeric}.
#' @param ... other properties of Guide.
#' 
#' @examples
#' # --- method initialize
#' new("Guide", fillAlpha = 0.1, gridThickness = 1, value = 1)
#' 
#' @export
#' @rdname initialize-Guide
#' 
setMethod(f = "initialize", signature = c("Guide"),
          definition = function(.Object, fillAlpha, valueAxis, value, ...)
          {            
            if (!missing(fillAlpha)) {
              .Object@fillAlpha <- fillAlpha
            } else {}
            if (!missing(valueAxis)) {
              .Object@valueAxis <- listProperties(valueAxis)
            } else {}
            if (!missing(value)) {
              .Object@value <- value
            } else {}
            .Object <- setProperties(.Object, ...)
            
            validObject(.Object)
            return(.Object)
          })

# CONSTRUCTOR ####

#' @rdname initialize-Guide
#' 
#' @examples
#' # --- constructor
#' guide(fillAlpha = .4, value = 1)
#' guide(fillAlpha = .4, adjustBorderColor = TRUE, gridThickness = 1)
#' 
#' @export
#' 
guide <- function(fillAlpha, valueAxis, value, ...) {
  .Object <- new(Class="Guide")
  if (!missing(fillAlpha)) {
    .Object <- setFillAlpha(.Object = .Object, fillAlpha = fillAlpha)
  } else {}
  if (!missing(valueAxis)) {
    .Object <- setValueAxis(.Object = .Object, valueAxis = valueAxis)
  } else {}
  if (!missing(value)) {
    .Object@value <- value
  } else {}
  .Object <- setProperties(.Object, ...)
  
  validObject(.Object)
  return(.Object)
}

