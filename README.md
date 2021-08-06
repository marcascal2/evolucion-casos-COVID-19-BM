# Evolucion de casos COVID-19 con TDA
[Este repositorio](https://github.com/marcascal2/evolucion-casos-COVID-19-TDA.git) facilita el acceso al código utilizado para el análisis de datos oficiales del COVID-19 en España a través de la aplicación del algoritmo Ball Mapper (BM). El análisis cuenta con dos estudios por separado. 

El primero se realiza sobre los datos extraídos de un estudio previo y trata sobre la seroprevalencia del virus en la población. Dichos datos se han extraído de el [Estudio Nacional de sero-Epidemiología de la infección por SARS-CoV-2 en España](https://portalcne.isciii.es/enecovid19/) y se almacenan en la carpeta ***/seroprevalencia***.

Para dicho estudio, se utiliza el archivo en R proporcionado por el propio [Portal del CNE](https://portalcne.isciii.es/enecovid19/), modificando el código conforme nos interesa para el estudio. Eliminando columnas y filas irrelevantes para nuestro objetivo, quedando el [archivo editado](https://github.com/marcascal2/evolucion-casos-COVID-19-TDA/blob/main/seroprevalencia/data.R).

El segundo estudio se basa en los datos oficiales del COVID-19 en España disponibles a través del [repositorio](https://github.com/rubenfcasal/COVID-19). En este repositorio se puede encontrar tanto información relativa a los datos utilizados, como la explicación de los distintos archivos que se generan tras ejecutar el código proporcionado. Todos los archivos referentes a este segundo estudio se encuentran organizados en la carpeta ***/casos_ccaas***

En nuestro caso, se ha hecho uso de uno de los archivos incluidos en el repositorio mencionado [COVID-19-actualizar.R](https://github.com/rubenfcasal/COVID-19/blob/master/COVID-19-actualizar.R), realizando los cambios oportunos para el tratamiento de datos según nuestros intereses:

* [Comunidades](https://github.com/marcascal2/evolucion-casos-COVID-19-TDA/tree/main/casos_ccaas/Comunidades%20(MAR-ABR%202020)): Caso para todos los datos de todas las Comunidades Autónomas recogidos durante el periodo entre el 1 de marzo de 2020 y el 30 de abril de 2020.
* [Madrid. Pre-vacunación (MAR-ABR 2020)](https://github.com/marcascal2/evolucion-casos-COVID-19-TDA/tree/main/casos_ccaas/Madrid/Pre-vacunacion%20(MAR-ABR%202020)): Caso sobre todos los datos de la Comunidad de Madrid recogidos durante el periodo entre el 1 de marzo de 2020 y el 30 de abril de 2020.
* [Madrid. Pos-vacunación (MAR-ABR 2021)](https://github.com/marcascal2/evolucion-casos-COVID-19-TDA/tree/main/casos_ccaas/Madrid/Pos-vacunacion%20(MAR-ABR%202021)): Caso sobre todos los datos de la Comunidad de Madrid recogidos durante el periodo entre el 1 de marzo de 2021 y el 30 de abril de 2021.
* [Madrid. Pos-vacunación (JUN-JUL 2021)](https://github.com/marcascal2/evolucion-casos-COVID-19-TDA/tree/main/casos_ccaas/Madrid/Pos-vacunacion%20(JUN-JUL%202021)): Caso sobre todos los datos de la Comunidad de Madrid recogidos durante el periodo entre el 1 de junio de 2021 y el 31 de julio de 2021.
