# Ejemplos Clase 1#

# Ejemplo 1 #

# Calcular la tangente de la raiz del coseno de 1 #
x <- 1
# Opción 1
tan(sqrt(cos(1)))
# Opción 2
x %>% 
  cos() %>% 
  sqrt() %>% 
  tan()

# Ejemplo 2 #
library(readxl)
encuesta <- read_excel("Clase 1/data/encuesta.xlsx")

# Ejemplo 3 # 

# 1
url  <- 'https://raw.githubusercontent.com/rstudio/EDAWR/master/data-raw/storms.csv'
download.file(url, "storms.csv", mode = "wb")

storms <- read.csv("G:/Mi unidad/Universidad/Cursos/Computación Estadística con R/Clase1/Scripts/data/storms.csv")


library(tidyverse)
storms %>% # ctrl + shift + m
  filter(pressure >= 1010, wind < 50) %>% 
  summarise(promedio = mean(wind), sd = sd(wind))








datos_wind <- storms %>% 
  filter(pressure >= 1010, wind < 50) %>% 
  summarise(promedio = mean(wind), sd = sd(wind))

# 2
storms <- storms %>% 
  mutate(pressure2 = pressure / 1000)

# 3
storms %>% 
  select(-pressure) %>%
  arrange(desc(date))

# Ejemplo 4 #

numeros  <- read_excel('Clase 1/data/numeros.xlsx')
numeros %>% 
  group_by(region) %>% 
  summarise(min = min(valor), max = max(valor))

# Ejemplo 5