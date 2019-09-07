# Ejemplo 0 #
library(tidyverse)
starwars %>%
  mutate(
    type = case_when(
      height > 200 | mass > 200 ~ "large",
      species == "Droid"        ~ "robot",
      TRUE                      ~ "other"
    )
  )


# Ejemplo 1 #

library(readxl)

numeros  <- read_excel('Datasets/numeros.xlsx')

# Buscamos el máximo y mínimo por región #
numeros %>% 
  group_by(region) %>% 
  summarise(min = min(valor), max = max(valor))

# Generamos variable indicadora de valor > 200
numeros %>% 
  mutate(valor.50 = case_when(
    valor > 200 ~ 1,
    TRUE ~ 0
  )) 

# Ejemplo 2 #

library(tidyverse)

# CTRL + SHIFT + R
data1 <- tibble(
  nombre = c("Rubén", "Teresa", "Axel", "Pamela"),
  apellido = c("Fuentes", "Martinez", "Baeza", "Gonzalez"),
  valor = c(1, 2, NA, 4)
)
data1

data2 <- tibble(
  nombre = c("Rubén", "Teresa", "Axel", "Pamela", "Pamela"),
  lastname = c("Soza", "Martines", "Baeza", "Gonzalez", "Jimenez"),
  valor2 = c(100, 200, 300, 400, 500)
)

data1
data2

# full_join ---------------------------------------------------------------
# Definicion: júntame todo lo que parea
# (a mi me gusta match)

# A lo inocente sin especificar el "by"
full_join(data1, data2)

full_join(data1, data2, by = c("nombre", "apellido" = "lastname"))


# inner_join --------------------------------------------------------------
# Definicion: déjame solo lo que parea
# (a mi me gusta match)
inner_join(data1, data2, by = c("nombre", "apellido" = "lastname"))


# left_join ---------------------------------------------------------------
# Definicion: deja fija la de la izquierda (la principal)
# y pega lo que exista en la segunda
datat <- left_join(data1, data2, by = c("nombre", "apellido" = "lastname"))


# Ejemplo 3 #

data("table4a")
table4a

table4a %>% 
  mutate(promedio = (`1999` + `2000`)/2)

table4a %>% 
  gather(anios, casos, `1999`, `2000`)

# el menos se interpreta, como TODO menos, lo que tenga menos
table4a %>% 
  gather(anios, casos, -country)

table4a %>% 
  gather(anios, casos, -country) %>% 
  group_by(country) %>% 
  summarise(promedio = mean(casos))

data1 %>% left_join(data2, by = "nombre")

table4a %>% 
  gather(anios, casos, -country) %>% 
  group_by(country) %>% 
  summarise(promedio = mean(casos)) %>% 
  left_join(table4a)

table4a <- table4a %>% 
  mutate(
    `2001` = c(123,3453,234),
    `2002` = c(78678,3423,456)
  )

table4a

table4a %>% 
  mutate(promedio = (`1999` + `2000` + `2001` + `2002`)/4)

table4a %>% 
  gather(anios, casos, `1999`, `2000`)

# el menos se interpreta, como TODO menos, lo que tenga menos
table4a %>% 
  gather(anios, casos, -country)

table4a %>% 
  gather(anios, casos, -country) %>% 
  group_by(country) %>% 
  summarise(promedio = mean(casos))

# mutate(storm, variable = 3)
# storm %>% mutate(variable = 3)

data1 %>% left_join(data2, by = "nombre")

table4a %>% 
  gather(anios, casos, -country) %>% 
  group_by(country) %>% 
  summarise(promedio = mean(casos)) %>% 
  left_join(table4a)

