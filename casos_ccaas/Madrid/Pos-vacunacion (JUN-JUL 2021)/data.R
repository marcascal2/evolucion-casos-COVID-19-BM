library(dplyr)

f <- "casos_hosp_uci_def_sexo_edad_provres.csv"
casos <- read.csv(f, sep = ",", na.strings = "", 
                  colClasses = c(rep("factor", 3), "character", rep("integer", 4)))
casos$fecha <- as.Date(casos$fecha, format = "%Y-%m-%d") 
range(casos$fecha)

# Verificar nombre de las variables
var.isciii <- c("provincia_iso", "sexo", "grupo_edad", "fecha", "num_casos", 
                "num_hosp", "num_uci", "num_def")
if (any(names(casos) != var.isciii)) stop('Cambios en las variables')

# Listado de provincias y CCAA 
provincias <- read.csv2(file = "iso_ccaa_provincia.csv", na.strings = "", 
                        colClasses = "character", header = TRUE) 
# Convertir a factor manteniendo el orden
provincias <- provincias %>% mutate(across(.fns =  ~ factor(.x, levels = unique(.x)))) # mutate_if


# Antes del 02/03/2021 se empleaba 'ME' en lugar de 'ML' para Melilla
levels(casos$provincia_iso) <- gsub("ME", "ML", levels(casos$provincia_iso))
# Verificar niveles de provincia_iso
if (!all(levels(casos$provincia_iso) %in% levels(provincias$provincia_iso))) 
  stop('Cambios en provincia_iso: ',
       setdiff(levels(casos$provincia_iso), levels(provincias$provincia_iso)))

# Añadir "provincia", "iso" (CCAA) y "ccaa"
casos <- casos %>% left_join(provincias, by="provincia_iso")

# -------------------------------------------------------------------------------------------------------------------------
# TRANSFORMACI�N DE VALORES DE CADENAS EN VALORES NUM�RICOS PARA LA APLICACI�N DE BALLMAPPER

if (!all(levels(casos$sexo) == c("H", "M", "NC"))) 
  stop('Cambios en niveles del factor sexo')
levels(casos$sexo) <- c(1, 2, 0) # Siendo 1='Hombres ; 2='Mujeres' ; 0='No Aplica'

if (!all(levels(casos$grupo_edad) == c("0-9", "10-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80+", "NC"))) 
  stop('Cambios en niveles del factor edad')
levels(casos$grupo_edad) <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, -1)

save(casos, file = "casos_prov.RData")

attr(casos, "url") <- "https://cnecovid.isciii.es/covid19/resources/casos_hosp_uci_def_sexo_edad_provres.csv"

save(casos, file = "casos_prov.RData")

#----------------------------------------------------- Casos por CCAA -----------------------------------------------------

casos_ccaa <- casos %>% rename(edad = grupo_edad) %>%
  group_by(fecha, iso, sexo, edad) %>% 
  summarise(confirmados=sum(num_casos), hospitalizados=sum(num_hosp), uci=sum(num_uci), 
            fallecidos=sum(num_def), .groups = 'drop')

# Ordenar y guardar
casos_ccaa <- casos_ccaa %>% arrange(fecha, iso, sexo, edad)

save(casos_ccaa, file ="casos_ccaa.RData")

#----------------------------------------------------- Tratamiento datos de comunidades --------------------------------------------------

## PERIODO DE MARZO Y ABRIL DE 2021
data <- subset(casos_ccaa, fecha>="2021-06-01")
data <- subset(data, fecha<="2021-07-30")

## ELIMINAMOS FILAS QUE NO APORTAN DATOS RELEVANTES
data <- subset(data, sexo!=0)
data <- subset(data, edad!=-1)
data <- subset(data, iso!='NA')

## CONVERTIMOS LA ULTIMA COLUMA CATEG�RICA EN NUM�RICA
if (!all(levels(data$iso) == c("AN", "AR", "AS", "CN", "CB", "CL", "CM", "CT", "EA", "VC", "EX", "GA", "IB", "RI", "MD", "MC", "NC", "PV"))) 
  stop('Cambios en niveles del factor iso')
levels(data$iso) <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)

## COMUNIDAD DE MADRID
data <- subset(data, iso == 15)

data <- group_by(data, iso, sexo, edad) %>% 
  summarize(confirmados=sum(confirmados), hospitalizados=sum(hospitalizados), uci=sum(uci), fallecidos=sum(fallecidos))

data <- data.frame(Reduce(cbind,data))
colnames(data) <- c('iso', 'sexo', 'edad', 'confirmados', 'hospitalizados', 'uci', 'fallecidos')

save(data, file ="data.RData")
write.table(data, file="data.csv", quote=F, sep=";", row.names=T)