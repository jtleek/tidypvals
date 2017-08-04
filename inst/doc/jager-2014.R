## ----packages------------------------------------------------------------
library(foreign)
library(devtools)
library(dplyr)
library(pryr)
library(readr)
library(stringr)

## ----load_data, eval=FALSE-----------------------------------------------
#  load("pvalueData.rda")
#  journal = rownames(pvalueData)
#  rownames(pvalueData) = NULL
#  pdat = pvalueData %>% data.frame()
#  pdat$journal = journal

## ----load_data_hidden, echo=FALSE----------------------------------------
load("~/data/medicine/pvalueData.rda")
journal = rownames(pvalueData)
rownames(pvalueData) = NULL
pdat = pvalueData %>% data.frame()
pdat$journal = journal

## ----pubmed_to_doi, eval=FALSE-------------------------------------------
#  pmids = read_csv("PMC-ids.csv")
#  glimpse(pmids)

## ----pubmed_to_doi_hidden, echo=FALSE------------------------------------
pmids = read_csv("~/data/medicine/PMC-ids.csv")
glimpse(pmids)

## ----merge_ids-----------------------------------------------------------
pmids$PMID = as.numeric(pmids$PMID)
pdat$pubmedID = as.numeric(as.character(pdat$pubmedID))
pdat = left_join(pdat,pmids,by=c("pubmedID"="PMID"))
glimpse(pdat)

## ------------------------------------------------------------------------
mean(is.na(pdat$DOI))

## ----load_journal_data , eval=FALSE--------------------------------------
#  journals = read_csv("FILES_FOR_DRYAD/1. TEXT_MINING/raw_data/journal.categories.csv")
#  glimpse(journals)

## ----load_journal_data_hidden, echo=FALSE--------------------------------
journals = read_csv("~/data/biology/FILES_FOR_DRYAD/1. TEXT_MINING/raw_data/journal.categories.csv")
glimpse(journals)

## ----set_field-----------------------------------------------------------
pdat = pdat %>% mutate(
  field = case_when(
    journal == "JAMA"  ~ "Medical And Health Sciences",
    journal == "BMJ"  ~ "Medical And Health Sciences",
    journal == "Lancet" ~ "Medical And Health Sciences",
    journal == "American Journal of Epidemiology" ~ "Public Health And Health Services",
    journal == "New England Journal of Medicine" ~ "Medical And Health Sciences" 
  )
)

## ----select--------------------------------------------------------------
jager2014 = pdat %>% mutate(abstract = TRUE) %>% 
  mutate(pmid=pubmedID, doi=DOI) %>%
  mutate(year = as.numeric(as.character(year))) %>%
  mutate(
    operator = case_when(
     pvalueTruncated == 1 ~ "lessthan",
     pvalueTruncated == 0 ~ "equals" 
  )) %>%
  select(pvalue,year,journal,field,
         abstract,operator,doi, pmid) %>%
  as_tibble()

## ----save_pvals----------------------------------------------------------
use_data(jager2014,overwrite=TRUE)

## ----session_info--------------------------------------------------------
session_info()

