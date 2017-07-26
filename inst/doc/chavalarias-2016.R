## ----packages------------------------------------------------------------
library(foreign)
library(devtools)
library(dplyr)
library(pryr)
library(readr)
library(stringr)

## ----load_database, eval=FALSE-------------------------------------------
#  my_db = src_mysql(
#    dbname = "medline_full_txt_pv",
#    user = "root",
#    password = "*****",
#    host = "127.0.0.1")

## ----select_db, eval=FALSE-----------------------------------------------
#  raw_data = my_db %>% tbl("medline_full_txt_pv") %>%
#    select(PMID,sign,value,logvalue,DP,first,format,abs) %>% collect()

## ----filter_first, eval=FALSE--------------------------------------------
#  raw_data = raw_data %>% filter(first == 1)
#  glimpse(raw_data)

## ----load_raw_hidden, echo=FALSE-----------------------------------------
raw_data = read_csv("~/data/medicine/raw_data.csv")
glimpse(raw_data)

## ----pubmed_to_doi, eval=FALSE-------------------------------------------
#  pmids = read_csv("PMC-ids.csv")
#  glimpse(pmids)

## ----pubmed_to_doi_hidden, echo=FALSE------------------------------------
pmids = read_csv("~/data/medicine/PMC-ids.csv")
glimpse(pmids)

## ----merge_ids-----------------------------------------------------------
pmids$PMID = as.integer(pmids$PMID)
raw_data = left_join(raw_data,pmids)
glimpse(raw_data)

## ------------------------------------------------------------------------
mean(is.na(raw_data$DOI))
pdat = raw_data %>% filter(!is.na(DOI))
rm(raw_data)
rm(pmids)

## ----load_journal_data , eval=FALSE--------------------------------------
#  journals = read_csv("FILES_FOR_DRYAD/1. TEXT_MINING/raw_data/journal.categories.csv")
#  glimpse(journals)

## ----load_journal_data_hidden, echo=FALSE--------------------------------
journals = read_csv("~/data/biology/FILES_FOR_DRYAD/1. TEXT_MINING/raw_data/journal.categories.csv")
glimpse(journals)

## ------------------------------------------------------------------------
mean(pdat$`Journal Title` %in% journals$Title)
mean(pdat$`Journal Title` %in% journals$Abbreviation)
mean(pdat$`Journal Title` %in% journals$Abbreviation | pdat$`Journal Title` %in% journals$Title)

## ----merge---------------------------------------------------------------
pdat = left_join(pdat,journals,by=c("Journal Title"="Abbreviation"))
rm(journals)

## ----check_formats-------------------------------------------------------
table(pdat$format)

pdat %>% filter(format=="10exp") %>% head(5) %>% 
  mutate(nump = as.numeric(value)) %>% select(value,nump)

pdat %>% filter(format=="exp") %>% head(5) %>% 
  mutate(nump = as.numeric(value)) %>% select(value,nump)
  
pdat %>% filter(format==".int") %>% head(5) %>% 
     mutate(nump = as.numeric(value)) %>% select(value,nump)

## ----reformat_pvals------------------------------------------------------
pdat = pdat %>% mutate(pvalue = as.numeric(value))

## ----select--------------------------------------------------------------
chavalarias2016 = pdat %>% mutate(journal = `Journal Title`)%>%
  mutate(abstract=(abs==0), doi=DOI) %>%
  mutate(year = DP, pmid=PMID) %>% 
  mutate(field=Category) %>%
  mutate(
    operator = case_when(
     str_detect(sign, "<") | str_detect(sign, "less") ~ "lessthan",
     sign == "="  | sign == "==" ~ "equals" ,
     str_detect(sign, ">") ~ "greaterthan"
  )) %>%
  select(pvalue,year,journal,field,
         abstract,operator,doi,pmid) %>%
  filter(!is.na(pvalue))

## ----save_pvals----------------------------------------------------------
use_data(chavalarias2016,overwrite=TRUE)

## ----session_info--------------------------------------------------------
session_info()

