# Actividades Clase 1 #

# Actividad 1 #
impares <- seq(1, by = 2, length.out = 1000)
subset <- impares[c(1,10,100,1000)]
sum(sqrt(subset))

subset %>%
  sqrt() %>% 
  sum() %>% 
  abs()


# Actividad 2 #
library(tidyverse)
# Libre, hay que buscar BD #

# Actividad 3 #
Encuesta <- read_excel('encuesta.xlsx')
Encuesta %>% 
  select(P3,P8,P9,P154,P156) %>%
  filter(P9 == "Hombre", P3 == "Región de Valparaíso") %>%
  arrange(P8) %>%
  mutate(PRSC = P156/max(P156)) %>%
  group_by(P154) %>%
  summarise(mean(PRSC))
