## ----load_data-----------------------------------------------------------
library(tidypvals)
library(ggjoy)
library(devtools)
library(dplyr)
library(ggplot2)

## ----allpvals------------------------------------------------------------
aj1 = anti_join(head2015,chavalarias2016)
aj2 = anti_join(chavalarias2016,head2015)
sj1 = semi_join(head2015,chavalarias2016)
allp = rbind(aj1,aj2,sj1)

## ----economics-----------------------------------------------------------
allp = rbind(allp,brodeur2016)

## ----economics_save_hidden, echo=FALSE-----------------------------------
use_data(allp,overwrite=TRUE)

## ----filter_out_fields---------------------------------------------------
modefunc = function(x){
  d = density(x)
  return(d$x[which.max(d$y)])
}
allp = allp %>% filter(!is.na(field)) %>%
  filter(field != "Multidisciplinary") %>%
  filter(field != "Other") %>%
  group_by(field) %>% 
  mutate(averagep = modefunc(pvalue)) %>%
  ungroup() %>%
  arrange(averagep) %>%
  mutate(field=factor(field,levels=unique(field))) %>%
  filter(pvalue <= 1)

## ------------------------------------------------------------------------
ggplot(allp,aes(x = pvalue, y = field)) + geom_joy(bandwidth=0.01,fill="lightblue") + theme_joy(grid=FALSE)

## ----session_info--------------------------------------------------------
session_info()

