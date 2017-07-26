## ----packages------------------------------------------------------------
library(foreign)
library(devtools)
library(dplyr)
library(pryr)

## ----load_data, eval=FALSE-----------------------------------------------
#  pdat = read.dta("final_stars_supp.dta")
#  glimpse(pdat)

## ----load_data_hidden, echo=FALSE----------------------------------------
pdat = read.dta("~/data/economics/final_stars_supp.dta")
glimpse(pdat)

## ----na_pvals------------------------------------------------------------
table(is.na(pdat$p_value_num))

## ----na_tstats-----------------------------------------------------------
tstat_pvals = 2*(1-pnorm(pdat$t_stat_raw))
table(is.na(tstat_pvals))

## ----compare-------------------------------------------------------------
quantile((tstat_pvals - pdat$p_value_num),na.rm=T)
plot(tstat_pvals, pdat$p_value_num,pch=19)

## ----nomatch-------------------------------------------------------------
ind = which(abs(tstat_pvals - pdat$p_value_num) > 0.05)
pdat[ind,] %>% select(journal_id,article_page,first_author)

## ------------------------------------------------------------------------
pdat = pdat[-ind,]

## ----select--------------------------------------------------------------
brodeur2016 = pdat %>% mutate(pvalue=2*(1-pnorm(t_stat_raw)),journal = journal_id) %>%
  mutate(field="economics", abstract=FALSE) %>%
  mutate(operator = NA, doi = NA, pmid=NA) %>%
  select(pvalue,year,journal,field,
         abstract,operator,doi,pmid) %>%
  filter(!is.na(pvalue))

## ----save_pvals----------------------------------------------------------
use_data(brodeur2016,overwrite=TRUE)

## ----session_info--------------------------------------------------------
session_info()

