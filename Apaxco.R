library(tidyverse)

edomex <- read.csv("datoscenso2020edomex.csv")

dim(edomex)

# Filtramos para obtener datos solo del Municipio de Apaxco

apaxco <- filter(edomex, NOM_MUN == "Apaxco")

# De los Datos de Apaxco nos interesa la población por localidad.
# Seleccionamos solo nombre de la localidad y población total

poblacion <- select(apaxco, NOM_LOC, POBTOT)

# El data set estimado incluye la población total, lo que no es útil para
# nuestro objetivo. Por lo que se excluye la fila que contiene ese dato.

poblacion <- poblacion[poblacion$NOM_LOC!="Total del Municipio", ]

# El objeto población cambió de 18 a 17 observaciones.
# Lo ordenamos en funcion de la Población, en orden descendente

poblacion <- arrange(poblacion, desc(POBTOT))

ggplot(poblacion) + geom_col(aes(x=NOM_LOC, y= POBTOT))

# Para que la gráfica ordene de mayor a menor en función de la población.

ggplot(poblacion) + 
  geom_col(aes(x=reorder(NOM_LOC, POBTOT), y= POBTOT, fill = NOM_LOC))

# Cambiamos la orientación de los ejes.

ggplot(poblacion) + 
  geom_col(aes(x=reorder(NOM_LOC, POBTOT), y= POBTOT, fill = NOM_LOC)) +
  coord_flip()

# Quitamos las etiquetas de la derecha.

ggplot(poblacion) + 
  geom_col(aes(x=reorder(NOM_LOC, POBTOT), y= POBTOT, fill = NOM_LOC)) +
  coord_flip() +theme(legend.position = "none")

# Agregamos etiquetas de número a las columnascon geom_text.

ggplot(poblacion) + 
  geom_col(aes(x=reorder(NOM_LOC, POBTOT), y= POBTOT, fill = NOM_LOC)) +
  coord_flip() +theme(legend.position = "none") +
  geom_text(aes(x =  reorder(NOM_LOC, POBTOT), y = POBTOT, label = POBTOT))

# Agegamos título, subtítulo, fuente
ggplot(poblacion) + 
  geom_col(aes(x=reorder(NOM_LOC, POBTOT), y= POBTOT, fill = NOM_LOC)) +
  coord_flip() +theme(legend.position = "none") +
  geom_text(aes(x = reorder(NOM_LOC, POBTOT), y = POBTOT, label = POBTOT)) +
  labs(title = "Apaxco, Estado de México",
       subtitle = "Población por localidad. 2020",
       caption = "INEGI. Censo General de Población y Vivienda 2020") + 
  theme(axis.title.y=element_blank()) + ylab("Población") + xlab("Localidad")

ggplot(poblacion) + 
  geom_col(aes(x=reorder(NOM_LOC, POBTOT), y= POBTOT, fill = NOM_LOC)) +
  coord_flip() +theme(legend.position = "none") +
  geom_text(aes(x = reorder(NOM_LOC, POBTOT), y = POBTOT, label = POBTOT),
            size = 4) +
  labs(title = "Apaxco, Estado de México",
       subtitle = "Población por localidad. 2020",
       caption = "Fuente: Elaboración propia con datos de INEGI, 
       Censo de Población  y Vivienda 2020") + 
  ylab("Población") + xlab("Localidad")

ggplot(poblacion) + 
  geom_col(aes(x=reorder(NOM_LOC, POBTOT), y= POBTOT, fill = NOM_LOC)) +
  coord_flip() +theme(legend.position = "none") +
  geom_text(aes(x = reorder(NOM_LOC, POBTOT), y = POBTOT, label = POBTOT),
            position = position_dodge(width = 1), size = 4,
            vjust = 0.5, hjust = 0) +
  labs(title = "Apaxco, Estado de México",
       subtitle = "Población por localidad. 2020",
       caption = "Fuente: Elaboración propia con datos de INEGI, 
       Censo de Población  y Vivienda 2020") + 
  ylab("Población") + xlab("Localidad")
