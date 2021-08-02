# -------------------------------------------------------------------------------------------- #
#R SCRIPT PARA ESTIMACIONES DE RIESGO DE FATALIDAD DE INFECCIï¿½N POR SARS-CoV-2 E INTERVALOS DE CONFIANZA EN ESPAï¿½A #
# #
# Este cï¿½digo reproduce los anï¿½lisis realizados en Pastor-Barriuso R, Pï¿½rez-Gï¿½mez B, Hernï¿½n MA, #
# et al. Riesgo de muerte por infecciï¿½n por SARS-CoV-2 en la poblaciï¿½n de Espaï¿½a que vive en comunidades: #
# estudio seroepidemiolï¿½gico a nivel nacional. BMJ 2020; 371: m4509. #
# #
# Los mï¿½todos complementarios en el apï¿½ndice web de este documento proporcionan mï¿½s detalles sobre el #
# cï¿½lculo de estimaciones puntuales e intermedias de los riesgos de muerte por infecciï¿½n y # estandarizado
# ratios de riesgo de muerte por infecciï¿½n. #
# #
# ------------------------------------------------- ------------------------------------------- #

# ------------------------------------------------- -------------------------------------------
# Poblaciï¿½n no institucionalizada por sexo y grupo de edad de 10 aï¿½os (0-9, ..., 70-79,> = 80 aï¿½os)
# a 15 de julio de 2020 (Instituto Nacional de Estadï¿½stica de Espaï¿½a)

data <- matrix(c(1,0,23006948, # All men
                 1,1, 2205512,
                 1,2, 2557872,
                 1,3, 2479132,
                 1,4, 2978715,
                 1,5, 3916706,
                 1,6, 3493827,
                 1,7, 2598212,
                 1,8, 1783664,
                 1,9,  993308,
                 6,0,23880127, # All women
                 6,1, 2078268,
                 6,2, 2396681,
                 6,3, 2404106,
                 6,4, 3012421,
                 6,5, 3877832,
                 6,6, 3563505,
                 6,7, 2803368,
                 6,8, 2138101,
                 6,9, 1605845),
               ncol=3,byrow=T,dimnames=list(NULL,c("sex","age.cat","pop")))

# --------------------------------------------------------------------------------------------
# Seroprevalencia de SARS-CoV-2 con inmunoensayo de micropartï¿½culas quimioluminiscentes por sexo y grupo de edad (estudio ENE-COVID, del 27 de abril al 22 de junio de 2020)
# Nota: Seropositividad para SARS-CoV-2 con inmunoensayo en al menos una ronda (61,098 participantes)
# Nota: Los errores estï¿½ndar y los intervalos de confianza del 95% para las seroprevalencias de SARS-CoV-2 representaron el diseï¿½o de la encuesta compleja ENE-COVID

prev <- matrix(c(1,0,0.0480349,0.0020331,0.0442   ,0.0521844, # All men
                 1,1,0.032491 ,0.0085854,0.0192738,0.0542704,
                 1,2,0.0364694,0.0050465,0.0277637,0.0477708,
                 1,3,0.0575589,0.0060172,0.0468298,0.0705642,
                 1,4,0.0469104,0.0048414,0.0382763,0.057376 ,
                 1,5,0.0533675,0.0040497,0.0459585,0.0618934,
                 1,6,0.0526599,0.0041078,0.0451596,0.0613259,
                 1,7,0.0489133,0.0046771,0.0405125,0.058949 ,
                 1,8,0.0468757,0.0058305,0.0366764,0.0597354,
                 1,9,0.0459045,0.0083506,0.0320389,0.0653654,
                 6,0,0.0502719,0.0019933,0.0465025,0.0543296, # All women
                 6,1,0.0423326,0.0099907,0.0265351,0.0668889,
                 6,2,0.0438495,0.0055863,0.0341074,0.0562123,
                 6,3,0.0571521,0.0061229,0.0462607,0.0704184,
                 6,4,0.0520345,0.0045337,0.0438257,0.0616816,
                 6,5,0.0533281,0.0040707,0.0458839,0.0619017,
                 6,6,0.0517353,0.0039205,0.0445629,0.0599897,
                 6,7,0.0500889,0.0045885,0.0418162,0.059896 ,
                 6,8,0.0462329,0.0052633,0.0369377,0.0577271,
                 6,9,0.0499314,0.0078711,0.036566 ,0.0678381),
               ncol=6,byrow=T,dimnames=list(NULL,c("sex","age.cat","prev","prev.se","prev.ll","prev.ul")))

# Merge population with seroprevalence data
data <- merge(data,prev,by=c("sex","age.cat"))
rm(prev)

# --------------------------------------------------------------------------------------------
# Nï¿½mero estimado de infecciones por SARS-CoV-2 en la poblaciï¿½n no institucionalizada por sexo y grupo de edad

data$infect <-    data$pop*data$prev
data$infect.se <- data$pop*data$prev.se
data$infect.ll <- data$pop*data$prev.ll
data$infect.ul <- data$pop*data$prev.ul

cbind(format(data$pop/1000,digits=1,nsmall=1,trim=T,big.mark=","),                         # Population (thousands)
      paste(format(100*data$prev,digits=0,nsmall=1,trim=T)," (",                           # Seroprevalence (%) (95% CI)
            format(100*data$prev.ll,digits=0,nsmall=1,trim=T)," to ",
            format(100*data$prev.ul,digits=0,nsmall=1,trim=T),")",sep=""),
      paste(format(data$infect/1000,digits=0,nsmall=1,trim=T,big.mark=",")," (",           # Infections (thousands) (95% CI)
            format(data$infect.ll/1000,digits=0,nsmall=1,trim=T,big.mark=",")," to ",
            format(data$infect.ul/1000,digits=0,nsmall=1,trim=T,big.mark=","),")",sep=""))
# --------------------------------------------------------------------------------------------
# Nï¿½mero de defunciones con COVID-19 confirmado en poblaciï¿½n no institucionalizada hasta el 15 de julio de 2020 por sexo y grupo de edad (SiViES)

death <- matrix(c(1,0,12317, # All men
                  1,1,3,
                  1,2,3,
                  1,3,18,
                  1,4,48,
                  1,5,192,
                  1,6,705,
                  1,7,1904,
                  1,8,4145,
                  1,9,5299,
                  6,0,6911,  # All women
                  6,1,2,
                  6,2,3,
                  6,3,17,
                  6,4,29,
                  6,5,103,
                  6,6,318,
                  6,7,749,
                  6,8,1986,
                  6,9,3704),
                ncol=3,byrow=T,dimnames=list(NULL,c("sex","age.cat","death.covid")))

# Merge death data
data <- merge(data,death,by=c("sex","age.cat"))
rm(death)

format(data$death.covid,digits=1,nsmall=0,trim=T,big.mark=",")

# --------------------------------------------------------------------------------------------
# Nï¿½mero de muertes por todas las causas en exceso en la poblaciï¿½n no institucionalizada por sexo y grupo de edad (13 de marzo al 22 de mayo de 2020, MoMo)

death <- matrix(c(1,0,15480, # All men
                  1,1,32,
                  1,2,0,
                  1,3,0,
                  1,4,3,
                  1,5,168,
                  1,6,601,
                  1,7,2065,
                  1,8,5114,
                  1,9,7497,
                  6,0,9298,  # All women
                  6,1,11,
                  6,2,22,
                  6,3,10,
                  6,4,71,
                  6,5,91,
                  6,6,369,
                  6,7,875,
                  6,8,2646,
                  6,9,5203),
                ncol=3,byrow=T,dimnames=list(NULL,c("sex","age.cat","death.excess")))

# Merge death data
data <- merge(data,death,by=c("sex","age.cat"))
rm(death)

format(data$death.excess,digits=1,nsmall=0,trim=T,big.mark=",")

# --------------------------------------------------------------------------------------------
## install.packages("dplyr")
library(dplyr) #Leer la librería
data <- select(data, sex, age.cat, pop, prev, infect, death.covid, death.excess) #Seleccion de columnas que queremos
data <- data[-c(1, 11), ]

save(data, file = "casos.RData")
write.table(data, file="data.csv", quote=F, sep=";", row.names=T)