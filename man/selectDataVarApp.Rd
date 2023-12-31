% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/selectDataVarApp.R
\name{selectDataVarApp}
\alias{selectDataVarApp}
\title{Data and variable shiny app}
\usage{
selectDataVarApp(filter = is.numeric)
}
\arguments{
\item{filter}{variable filter (i.e., \code{is.numeric} or \code{is.character})}
}
\value{
shiny app
}
\description{
This module function comes from the \href{https://mastering-shiny.org/scaling-modules.html#modules-inside-of-modules}{Modules inside of modules} section of Mastering Shiny.
}
\section{Reactive values}{

The only changes to this application include a call to \code{verbatimTextOutput()} in the UI, which renders the contents of \code{reactiveValuesToList()} in the server. The \code{renderPrint()} output contains the \code{inputId}s for the modules in the application.
}

