#' P-values from Head et al. 2015 PLoS Biology, please see vignette
#' for more details about how the data were collected and processed.
#'
#'
#' @format A data frame with 2,131,454 rows and 8 columns
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
#' @source \url{http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002106}
"head2015"