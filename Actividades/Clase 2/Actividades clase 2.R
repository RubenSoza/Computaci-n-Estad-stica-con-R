# Actividades Clase 2 #

# Actividad 1 #
library(readxl)
library(tidyverse)
Encuesta <- read_excel('Datasets/encuesta.xlsx')
Encuesta %>% 
  select(P3,P8,P9,P154,P156) %>%
  filter(P9 == "Hombre", P3 == "Región de Valparaíso") %>%
  arrange(P8) %>%
  mutate(PRSC = P156/max(P156)) %>%
  group_by(P154) %>%
  summarise(mean(PRSC))

