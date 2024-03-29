#' @title AmObject class
#' @author datastorm-open
#' @description This is a virtual class for representing any Am** class
#' 
#' @slot listeners \code{list} containining the listeners to add to the object.
#' The list must be named as in the official API. Each element must be a character string. 
#' @slot otherProperties \code{list}
#' containing other avalaible properties not yet implemented in the package.
#' @slot value \code{numeric}.
#' 
#' @export
setClass(Class = "AmObject",
         representation = representation(
           value = "numeric",
           listeners = "list",
           otherProperties = "list", "VIRTUAL"))

#' @title Visualize with show
#' @description Display the object in the console.
#' @param object \linkS4class{AmObject}.
#' @examples
#' library(pipeR)
#' amPieChart(valueField = "value", titleField = "key", backgroundColor = "#7870E8") %>>%
#'   setDataProvider(data.frame(key = c("FR", "US"), value = c(20,10))) %>>%
#'   setExport(position = "bottom-left")
#' @export
#' 
setMethod(f = "show", signature = "AmObject",
          definition = function(object)
          {
            cat("~", class(object),"~\n")
            print(listProperties(object))
          })

#' @title Visualize with print
#' @description Display the object in the console.
#' @param x \linkS4class{AmChart}.
#' @param withDetail \code{logical}, TRUE to display details.
#' @param ... Other properties.
#' @examples
#' print(new("AmChart", categoryField = "variables", type = "serial"))
#' print(new("AmChart", categoryField = "variables", type = "serial"), withDetail = FALSE)
#' @details If the object possess a 'dataProvider' property, it will be hidden in the console.
#' To see if it's correctly registered use '@dataProvider'.
#' @export
#' 
setMethod(f = "print", signature = "AmObject",
          definition = function(x, withDetail = TRUE,...)
          {
            if (withDetail) {
              cat("~ ", class(x)," object (with detail) ~\n\n")
              
              cat("Referenced properties:\n")
              ls <- listProperties(x)
              cat(paste(grep(pattern = "RType_", x = names(ls), value = TRUE, invert = TRUE), collapse = ", "))
              
              cat("\n- Detail:\n")
              if (exists(x = "dataProvider", where = ls))
                ls["dataProvider"] <- NULL
              print(ls)
            } else {
              cat("~ ", class(x)," object (without detail)~\n\n")
              cat("Referenced properties:\n")
              ls <- listProperties(x)
              cat(paste(grep(pattern = "RType_", x = names(ls), value = TRUE, invert = TRUE), collapse = ", "))
            }
            cat("\n")
          })

# > @listeners: setters ####

#' @title AmObject methods
#' @description Methods for inherited classes.
#' @param .Object \code{\linkS4class{AmObject}}.
#' @param name \code{character}, name of the listener.
#' @param expression \code{character}, associated function event.
#' @return The updated object.
#' @examples
#' \dontrun{
#' addListener(.Object = amPieChart(),
#'             name = "clickSlice" ,
#'             expression = "function(event){ alert('ok !'); }")
#'             
#' addListener(.Object = amLegend(),
#'             name = "select",
#'             expression = paste0("function onSelect (properties) {",
#'                                 "alert('selected nodes: ' + properties.nodes);",
#'                                 "}"))
#' }
#' @rdname methods-AmObject
#' @export
#' 
setGeneric(name = "addListener", def = function(.Object, name, expression) { standardGeneric("addListener")})
#' @rdname methods-AmObject
setMethod(f = "addListener", signature = c("AmObject", "character", "character"),
          definition = function(.Object, name, expression)
          {
            .Object@listeners[[ eval(name) ]] <- htmlwidgets::JS(expression)
            validObject(.Object)
            return(.Object)
          })


# > @otherProperties: resetProperties ####


#' @examples
#' 
#' \dontrun{
#' library(pipeR)
#' amPlot(runif(10)) %>>% resetProperties("categoryAxis") %>>% print(withDetail = FALSE)
#' }
#' 
#' @details Former properties will be overwritten.
#' @rdname methods-AmObject
#' @export
#' 
setGeneric(name = "resetProperties", def = function(.Object, ...) {standardGeneric("resetProperties")})
#' @rdname methods-AmObject
setMethod(f = "resetProperties", signature = c(.Object = "AmObject"),
          definition = function(.Object, ...)
          {
            invisible(sapply(X = ..., FUN = function (slot_name) {
              new_value <- new(class(slot(object = .Object, name = slot_name)))
              slot(object = .Object, name = slot_name, check = TRUE) <<- new_value
            }))
            validObject(.Object)
            return(.Object)
          })

# > @otherProperties: setProperties ####

#' @param list_prop (Optional) \code{list} containing properties to set.
#' The former properties will be overwritten.
#' @param ... other properties
#' @examples
#' 
#' \dontrun{
#' library(pipeR)
#' # either you can set a list
#' ls <- list(categoryAxis = list(gridPosition = "start"), fontSize = 15)
#' amSerialChart() %>>% setProperties(list = ls)  %>>% print()
#' 
#' # or you can set one or more properties
#' amPieChart() %>>% setProperties(handDrawn = TRUE, fontSize = 15) %>>% print()
#' 
#' # overwrite a property
#' amPieChart() %>>%  setProperties(fontSize = 15) %>>%  setProperties(fontSize = 12) %>>% print()
#' 
#' # Carefull if you try to set a property which is a slot...
#' # in that case, use the setter methods 'setXX' or 'addXX' which check the validity
#' 
#' amPieChart() %>>% setProperties(type = "serial") %>>% print()
#' 
#' 
#' amPieChart() %>>% setExport()
#' 
#' }
#' @details Former properties will be overwritten.
#' @rdname methods-AmObject
#' @export
#' 
setGeneric(name = "setProperties", def = function(.Object, list_prop, ...){standardGeneric("setProperties")})
#' @rdname methods-AmObject
setMethod(f = "setProperties", signature = c(.Object = "AmObject"),
          definition = function(.Object, list_prop, ...)
          {
            if (missing(list_prop)) {
              newProperties <- list(...)
              # Different cases have to be considered since the properties
              # may be referenced as slots, in that case a warning is sent.
              lapply(X = names(newProperties), FUN = function(prop) {
                if (prop %in% slotNames(.Object)) {
                  # if it's a slot and the prop is not "value", a warning is sent
                  if (prop != "value")
                    warning("You should use setter for property '", prop, "'")
                  slot(.Object, prop, check = TRUE) <<- newProperties[[prop]]
                } else {
                  .Object@otherProperties[[prop]] <<- newProperties[[prop]]
                }
                invisible()
              })
            } else if (is.list(list_prop))
              .Object@otherProperties <- list_prop
            
            validObject(.Object)
            return(.Object)
          })

# > listProperties ####

#' @title List properties of an S4 object
#' @description Each S4 class implements the method to list its properties
#' (usefull to update complex properties).
#' @param .Object any class object of the package
#' @return A list containing all the chart's properties.
#' @examples
#' 
#' \dontrun{
#' amChart(type = "serial")
#' }
#' 
#' @rdname listProperties-AmObject
#' @export
#' 
setGeneric(name = "listProperties", def = function(.Object) {standardGeneric("listProperties")})
#' @rdname listProperties-AmObject
setMethod(f = "listProperties", signature = "AmObject",
          definition = function(.Object)
            {
            if (length(.Object@otherProperties))
              properties <- .Object@otherProperties
            else
              properties <- list()
            
            if (length(.Object@value))
              properties[["value"]] <- .Object@value
            
            if (length(.Object@listeners)) 
              properties <- c(properties, listeners = .Object@listeners)
            
            # get all slot declared in the class except the package specific ones
            slot_names <- names(getSlots(class(.Object)))
            real_slots_i <- grep("properties", slot_names, ignore.case = TRUE, invert = TRUE)
            # iterate over all slots which can be passed to htmlwidgets as is
            for (i in real_slots_i) {
              slot_name_loop <-  slot_names[i]
              slot_value_loop <- slot(object = .Object, name = slot_name_loop)
              if (length(slot_value_loop))
                properties[[slot_name_loop]] <- slot_value_loop
            }
            
            return(properties)
          })
