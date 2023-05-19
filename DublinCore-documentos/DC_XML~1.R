#Transformar metadatos Dublin Core en XML#
#Catalina Marín para IBASE#
#Creado con chatGPT#

####Configuración Inicial####

setwd("C:/R/METADATOS/Dublin Core") #definir ambiente de trabajo
#Instalar paquetes#
install.packages("XML")
# Cargar paquetes#
library(XML)
###Transformar archivos####
# Read in table data
tabla <- read.csv("DB ejemplo.csv", header = TRUE, sep = ";", encoding="UTF-8")

# Crea un nuevo archivo XML
xmlDoc <- newXMLDoc()

# Crea el nodo raíz "metadata" con el espacio de nombres "http://www.openarchives.org/OAI/2.0/metadata"
rootNode <- newXMLNode("metadata",
                       xmlns = "http://www.w3.org/2001/XMLSchema-instance", 
                       doc = xmlDoc)

# Crea el nodo hijo "dc" con el espacio de nombres "http://purl.org/dc/elements/1.1/"
dcNode <- newXMLNode("dc", xmlns = "http://purl.org/dc/elements/1.1/", parent = rootNode)

# Agrega cada elemento y valor como un nodo hijo del nodo "dc"
for (i in 1:nrow(tabla)) {
  newXMLNode(tabla[i, 1], tabla[i, 2], parent = dcNode)
}
# Guarda el archivo XML
saveXML(xmlDoc, file = "dbejemplo.xml",
prefix = '<?xml version="1.0"?>', 
encoding = "UTF-8",
indent = TRUE)
  xmlDoc
  rootNode
  