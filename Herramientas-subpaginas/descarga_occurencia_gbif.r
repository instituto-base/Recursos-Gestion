#Prueba rgbif
#Catalina Marín
#Data manager IBASE

#Preparación
setwd("C:/R/GBIF") #seleccionar carpeta de trabajo
install.packages("rgbif") #instalar paquete rgibf
library(rgbif) #activar paquete
install.packages("usethis") #paquete para instalar credenciales
library(usethis)
usethis::edit_r_environ()

#Primero es necesario tener el identificador de la especie
# o Taxonkey
name_backbone("Roccellinastrum spongoideum")$usageKey

#Descargar datos de ocurrencia
gbif_download <- occ_download(pred("taxonKey", 3402343),
                              format = "SIMPLE_CSV") #descargar los datos
occ_download_wait(gbif_download) #consulta del tiempo de espera

d <- occ_download_get(gbif_download) %>%
  occ_download_import() #visualizar e importar los datos rn un objeto

#datos filtrados de manera básica
gbif_download2<-occ_download(
  pred("taxonKey", 3402343), 
  pred("hasGeospatialIssue", FALSE), #elimina errores geoespaciales predeterminados
  pred("hasCoordinate", TRUE),#solo registros con coordenadas
  pred("occurrenceStatus","PRESENT"), #eliminar registros ausentes
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))), #elimina especímenes vivos y fósiles
  format = "SIMPLE_CSV"
)
occ_download_wait(gbif_download2) #consulta del tiempo de espera
d2 <- occ_download_get(gbif_download2) %>%
  occ_download_import()#guarda la solicitud en un objeto
    
#descarga compleja
occ_download(
  type="and",
  pred("taxonKey", 2436775),
  pred("hasGeospatialIssue", FALSE),#elimina errores geospaciales predeterminados
  pred("hasCoordinate", TRUE),#solo registros con coordenadas
  pred("occurrenceStatus","PRESENT"), #elimina registros ausentes
  pred_gte("year", 1900),#después de/o año 1900 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))), #elimina especímenes fósiles y vivos
  pred_or(
    pred("country","ZA"),
    pred("gadm","ETH")
  ),#en sudáfria o etiopia usando polígonos distintos
  pred_or(
    pred_not(pred_in("establishmentMeans",c("MANAGED","INTRODUCED"))),
    pred_isnull("establishmentMeans")
  ),#la columna estabilshmentMeans no contiene especies gestionadas o introducidas, pero se pueden dejar en blanco
  pred_or(  
    pred_lt("coordinateUncertaintyInMeters",10000),
    pred_isnull("coordinateUncertaintyInMeters")
  ),#coordinateUncertaintyInMeters es menor a 10K metros o es dejado en blanco
  format = "SIMPLE_CSV"
)