## ----packages------------------------------------------------------------
library(foreign)
library(devtools)
library(dplyr)
library(pryr)
library(readr)

## ----load_data, eval=FALSE-----------------------------------------------
#  pdat = read_csv("FILES_FOR_DRYAD/1. TEXT_MINING/raw_data/p.values.csv")
#  glimpse(pdat)

## ----load_data_hidden, echo=FALSE----------------------------------------
pdat = read_csv("~/data/biology/FILES_FOR_DRYAD/1. TEXT_MINING/raw_data/p.values.csv")
glimpse(pdat)

## ----load_journal_data , eval=FALSE--------------------------------------
#  journals = read_csv("FILES_FOR_DRYAD/1. TEXT_MINING/raw_data/journal.categories.csv")
#  glimpse(journals)

## ----load_journal_data_hidden, echo=FALSE--------------------------------
journals = read_csv("~/data/biology/FILES_FOR_DRYAD/1. TEXT_MINING/raw_data/journal.categories.csv")
glimpse(journals)

## ------------------------------------------------------------------------
mean(pdat$journal.name %in% journals$Title)
mean(pdat$journal.name %in% journals$Abbreviation)
mean(pdat$journal.name %in% journals$Abbreviation | pdat$journal.name %in% journals$Title)

## ----merge---------------------------------------------------------------
pdat = left_join(pdat,journals,by=c("journal.name"="Abbreviation"))

## ----pubmed_to_doi, eval=FALSE-------------------------------------------
#  pmids = read_csv("PMC-ids.csv")
#  glimpse(pmids)

## ----pubmed_to_doi_hidden, echo=FALSE------------------------------------
pmids = read_csv("~/data/medicine/PMC-ids.csv")
glimpse(pmids)

## ----merge_pmids---------------------------------------------------------
mm = match(pdat$first.doi,pmids$DOI)
pdat = cbind(pdat,pmids[mm,])

## ----pvals_na------------------------------------------------------------
table(is.na(pdat$p.value))

## ----select--------------------------------------------------------------
head2015 = pdat %>% mutate(pvalue=p.value) %>%
  mutate(journal = journal.name,pmid=PMID) %>%
  mutate(abstract=(section=="abstract"), doi=first.doi) %>%
  mutate(field=Category) %>%
  mutate(
    operator = case_when(
     operator == "<" | operator == "≤" ~ "lessthan",
     operator == "=" ~ "equals" ,
     operator == ">" | operator == "≥" ~ "greaterthan"
  )) %>%
  select(pvalue,year,journal,field
         ,abstract,operator,doi,pmid) %>%
  filter(!is.na(pvalue)) %>%
  as_tibble()

## ----save_pvals----------------------------------------------------------
use_data(head2015,overwrite=TRUE)

## ----session_info--------------------------------------------------------
session_info()

