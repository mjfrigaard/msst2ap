% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/selectVarApp.R
\name{selectVarApp}
\alias{selectVarApp}
\title{Select Variable App}
\usage{
selectVarApp(filter = is.numeric)
}
\arguments{
\item{filter}{variables to list. \emph{This will be set by the caller of the module, so doesn’t need to be reactive}}
}
\value{
shiny app
}
\description{
This module function comes from the \href{https://mastering-shiny.org/scaling-modules.html#case-study-selecting-a-numeric-variable}{Case study: selecting a numeric variable} section of Mastering Shiny.
}
\section{Reactive values}{

The only changes to this application include a call to \code{verbatimTextOutput()} in the UI, which renders the contents of \code{reactiveValuesToList()} in the server. The \code{renderPrint()} output contains the \code{inputId}s for the modules in the application.
}

