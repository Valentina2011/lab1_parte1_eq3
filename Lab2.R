
# Remover todos los objetos del "Environment"
rm(list = ls())
options("scipen"=100, "digits"=4)

# Cargas librerías a utilizar
suppressMessages(library(plotly)) # Graficas interactivas
suppressMessages(library(Quandl)) # Descargar Precios
suppressMessages(library(PortfolioAnalytics)) # Teoría Moderna de Portafolios
suppressMessages(library(ROI)) # Optimizacion para portafolio
suppressMessages(library(knitr))  # Opciones de documentación + código
suppressMessages(library(kableExtra)) # Tablas en HTML

options(knitr.table.format = "html") 

# Cargar el token de QUANDL
Quandl.api_key("gs9s3mNF22osh3Phkdet")
Capital_Inicial <- 10000

funcion <- function(i){
  f<-paste("IVV_holdings_",i,".csv",header = T, sep = ",")
  datos_ETF <- read.csv(f)
  
  primero<-which(x=datos_ETF[,1]== "Ticker")
  ultimo<-length(datos_ETF[,1])
  
  tk <- datos_ETF[(primero+1):ultimo,1]
  w <- as.numeric(datos_ETF[(primero+1):ultimo,4])
  date <- datos_ETF[2,2]
  price <- as.numeric(datos_ETF[(primero+1):ultimo,5])
  titulos <- as.numeric(datos_ETF[,6])
  
  return(data.frame(tk,w,date,price,titulos))
}

datos<- list()

for(i in 1:12){
  datos[[i]] <- funcion(i)
}

#Funcion para descagar precios
Bajar_Precios <- function(c, tk, Fecha_In, Fecha_Fn) {
  Datos <- Quandl.datatable("WIKI/PRICES", qopts.columns=c, ticker=tk, date.gte=Fecha_In, date.lte=Fecha_Fn, paginate = TRUE)
  return(data.frame(Datos))
}

cs<-c("adj_close","ticker","date")

#valentina
#rueda rios valentina
#bbssjfhdhf
