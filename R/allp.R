#' P-values from Brodeur 2016, Chavalarias 2016, and Head 2015 with
#' overlapping p-values removed. See the "merging" vignette for
#' how this data set is constructed
#'
#'
#' @format A data frame with 2,576,103 rows and 8 columns
#' \describe{
#'  \item{price}{price, in US dollars}
#'  \item{pvalue}{The reported p-value}
#'  \item{year}{The year of the publication where the p-value appeared}
#'  \item{journal}{The journal where the publication appeared}
#'  \item{field}{The field of the paper, using the categorization in Head et al. 2015.}
#'  \item{abstract}{Whether the p-value was in the abstract of the paper}
#'  \item{operator}{Whether the p-value was reported as "lessthan", "greaterthan", or "equals"} 
#'  \item{doi}{When available the digital object identifier}
#'  \item{pmid}{The pubmed ID for the paper when available}
#' }
#' @source \url{https://github.com/jtleek/tidypvals}
"allp"