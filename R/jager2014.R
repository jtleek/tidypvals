#' P-values from Jager et al. 2014 Biostatistics, please see vignette
#' for more details about how the data were collected and processed.
#'
#'
#' @format A data frame with 15,653 rows and 8 columns
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
#' @source \url{https://academic.oup.com/biostatistics/article/15/1/1/244509/An-estimate-of-the-science-wise-false-discovery}
"jager2014"