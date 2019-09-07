# Ejemplo 1 #

library(gapminder)
library(tidyverse)

data(gapminder)

gapminder

glimpse(gapminder)

View(gapminder)


# Ejemplo 1 ---------------------------------------------------------------
# P: ¿Antes de ejecutar, que hace la siguiente instruccion?
paises <- gapminder %>% 
  filter(year == max(year))
paises


ggplot(data = paises)


ggplot(data = paises) + 
  geom_point(mapping = aes(x = lifeExp, y = gdpPercap))


ggplot(data = paises) + 
  geom_point(mapping = aes(x = lifeExp, y = gdpPercap), color = "blue")


ggplot(data = paises) + 
  geom_point(mapping = aes(x = lifeExp, y = gdpPercap, size = pop), color = "blue")


ggplot(data = paises) + 
  geom_point(mapping = aes(x = lifeExp, y = gdpPercap, size = pop, color = continent))

ggplot(data = paises) + 
  geom_point(mapping = aes(x = lifeExp, 
                           y = gdpPercap, 
                           size = pop, 
                           color = continent)) +
  facet_wrap(vars(continent)) + 
  theme(plot.subtitle = element_text(vjust = 1), 
    plot.caption = element_text(vjust = 1), 
    axis.text = element_text(family = "Bookman"), 
    plot.title = element_text(family = "serif")) +
  labs(title = "Esperanza de Vida vs GDP per cápita", 
    x = "Esperanza de Vida", y = "GDP per cápita")

?ggplot

# Ejemplo 2: Existen MAS geoms --------------------------------------------
chile <- gapminder %>% 
  filter(country == "Chile")
chile

paises

ggplot(data = chile)




paises %>% 
  group_by(continent) %>% 
  summarise(sum_cont = sum(gdpPercap))








# Tiene sentido?
ggplot(data = chile) +
  geom_point(aes(x = lifeExp, y = gdpPercap))

# ¿y si usamos otras variables?
ggplot(data = chile) +
  geom_point(aes(x = year, y = gdpPercap), size = 2)

# otro geom!
ggplot(data = chile) +
  geom_point(aes(x = year, y = gdpPercap), size = 2) +
  geom_line(aes(x = year, y = gdpPercap))



# Ejemplo 3: Yay! Ahora con todo el continente ----------------------------
# Repitamoslo con Ameira
america <- gapminder %>% 
  filter(continent == "America")
america

gapminder %>% 
  count(continent)

america <- gapminder %>% 
  filter(continent == "Americas")
america

ggplot(data = america) +
  geom_point(aes(x = year, y = gdpPercap), size = 2) +
  geom_line(aes(x = year, y = gdpPercap))
# P: ¿Esta bien segun lo que escribimos?

ggplot(data = america) +
  geom_line(aes(x = year, y = gdpPercap, group = country))


# Ejemplo 4: Los datos pueden venir de mas partes -------------------------
ggplot(data = chile) +
  geom_line(aes(x = year, y = gdpPercap, group = country), color = "red", size = 2)

# es igual a;
ggplot() +
  geom_line(aes(x = year, y = gdpPercap, group = country), color = "red", size = 2, data = chile)


# entonces
ggplot(data = america) +
  geom_line(aes(x = year, y = gdpPercap, group = country), color = "gray70") + 
  geom_line(aes(x = year, y = gdpPercap, group = country), color = "red", size = 2, data = chile)

# Customizacion -----------------------------------------------------------
ggplot(data = america) +
  geom_line(aes(x = year, y = gdpPercap, group = country), color = "gray90", size = 1.2, alpha = 0.5) + 
  geom_line(aes(x = year, y = gdpPercap, group = country), color = "red", size = 3, data = chile) + 
  theme_dark()



# Otros ejemplos ----------------------------------------------------------
library(scales) # esto es para la funcion comma
comma(123345567)

ggplot(paises) + 
  geom_point(aes(lifeExp, gdpPercap, size = pop, color = continent), alpha = 0.7) +
  scale_color_viridis_d(option = "A") + 
  scale_y_sqrt(name = "GDP per Capita", labels = comma, limits = c(NA, NA)) +
  scale_x_continuous(name = "Esperanza de vida", labels = comma, limits = c(NA, NA)) +
  scale_size(labels = comma, range = c(3, 10), breaks = c(100, 1000, 2000)*1e6) +
  labs(title = "Esperanza de vida y GDP per capita ") +
  theme_minimal()


continentes <- paises %>% 
  count(continent)
continentes

ggplot(continentes) +
  geom_col(aes(continent, n, fill = continent), width = 0.5) + 
  scale_fill_viridis_d(guide = FALSE) +
  labs(
    title = "Africa tiene más países que el resto de continentes",
    subtitle = "Un interesante subtitulo para contexto y dar detalles quizás puede ser\nmás largo pero quien soy yo para decir que se debe y lo que no",
    caption = "Importante mencionar la fuente, en caso contrario no me creen",
    x = "Contienentes",
    y = "Países"
  ) + 
  theme(plot.subtitle = element_text(size = 9))

# Ejemplo 2 #

# Histograma Score Socio-económico #

Encuesta <- read_excel("G:/Mi unidad/Universidad/Cursos/Computación Estadística con R/Datasets/encuesta.xlsx")

# Histograma del Score Socioeconómico #

grafico <- ggplot(data = Encuesta, aes(x = P156))
grafico + geom_histogram()
grafico + geom_histogram(binwidth = 30)
grafico + geom_histogram(binwidth = 30, 
                         color = "blue")
grafico + geom_histogram(binwidth = 30, 
                         color = "violetred",
                         fill = "turquoise4")
grafico + geom_histogram(binwidth = 30, 
                         color = "violetred",
                         fill = "turquoise4") + 
  ggtitle("P156")

grafico + geom_histogram(binwidth = 30, 
                         color = "violetred",
                         fill = "turquoise4") + 
  ggtitle("P156") + theme_light()

grafico + geom_histogram(binwidth = 30, 
                         color = "violetred",
                         fill = "turquoise4") + 
  ggtitle("P156") + theme_gray()

# Boxplot del score según región #
grafico2 <- ggplot(data = Encuesta, 
                   aes(x = P3, y = P156))
grafico2 + geom_boxplot(color = "darkblue", 
                        fill = "skyblue")

grafico3 <- ggplot(data = Encuesta, 
                   aes(x = P3, y = P156, 
                       fill = P3))
grafico3 + geom_boxplot()

grafico3 + geom_boxplot() + 
  theme(legend.position = "none")

grafico3 + geom_boxplot(alpha = 0.5) + 
  theme(legend.position = "none")

grafico3 + geom_boxplot(alpha = 0.5) + 
  theme(legend.position = "none", 
        axis.text.x = element_text(angle = 90, hjust = 1)) 

grafico3 + geom_boxplot(alpha = 0.5) + 
  theme(legend.position = "none") + coord_flip()

# Frecuencia del estado civil
grafico4 <- ggplot(data = Encuesta, aes(x = P13))

grafico4 + geom_bar()

grafico4 + geom_bar() + coord_flip()

# Agregamos una paleta de colores #
grafico5 <- ggplot(data = Encuesta, 
                   aes(x = P13, fill = P13))

grafico5 + geom_bar() + coord_flip() + 
  scale_fill_brewer(palette = "Set3") +
  theme(legend.position = "none")

grafico5 + geom_bar(stat = "identity") + coord_flip() + 
  scale_fill_brewer(palette = "Set2") +
  theme(legend.position = "none")


