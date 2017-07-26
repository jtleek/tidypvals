All the p-values with tidypvals
=================

The p-value is the [most widely-known statistic](https://simplystatistics.org/2012/01/06/p-values-and-hypothesis-testing-get-a-bad-rap-but-we/). P-values are reported in a large majority of scientific publications that measure and report data. R.A. Fisher is widely credited with inventing the p-value. If he was cited every time a p-value was reported his paper would have, at the very least, 3 million citations* - making it the most highly cited paper of all time. 

The `tidypvals` package organizes a large subset of these published p-values. They have been collected and synthesized from thousands of studies across multiple fields. The resulting data sets can be easily merged, combined, and analyzed. 



### install

This package will (hopefully) end up on Bioconductor soon, but for now you can install it with the devtools package

```S
install.packages('devtools)
library(devtools)
devtools::install_github('jtleek/slipper')
```

### description

The currently available p-value data sets in this package are: 

* `jager2014` - This data set comes from the paper: [An estimate of the science-wise false discovery rate and application to the top medical literature](https://academic.oup.com/biostatistics/article/15/1/1/244509/An-estimate-of-the-science-wise-false-discovery) that first proposed p-value scraping from the medical literature for re-analysis.
* `brodeur2016` - This data set comes from the paper [Star Wars: The empirics strike back](https://www.aeaweb.org/articles?id=10.1257/app.20150044) which collected p-values from the economics literature.
* `head2015` - This data set comes from the paper [The Extent and Consequences of P-Hacking in Science](http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002106) and is an extension of the `jager2014` idea to a much larger collection of biological papers. 
* `chavalarias2016` - This data set comes from the paper [Evolution of Reporting P Values in the Biomedical Literature, 1990-2015](https://jamanetwork.com/journals/jama/fullarticle/10.1001/jama.2016.1952) and is an extension of the `jager2014` idea to a much larger collection of medical papers. 


Each data set is "tidy" data frame and has the following columns: 

* `pvalue` - The reported p-value
* `year` - The year of the publication where the p-value appeared
* `journal` - The journal where the publication appeared
* `field` - The field of the paper, using the categorization in Head et al. 2015.
* `abstract` - Whether the p-value was in the abstract of the paper
* `operator` - Whether the p-value was reported as "lessthan", "greaterthan", or "equals". 
* `doi` - When available the digital object identifier. 
* `pmid` - The pubmed ID for the paper when available


### use

Load the library and then access each data set by name.  

```S
library(tidypvals)
jager2014
```

Data sets can be easily merged, but be careful to avoid duplicated p-values across different data sets. You can see how each data set was obtained and tidied by viewing the corresponding vignette. 

```S
vignette("jager-2014",package="tidypvals")
```