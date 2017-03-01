#Análise de Indicadores de Evasão
#Recorte de Dados
#28/Fev/2017
#Luciano Barosi de Lemos
inicio <- Sys.time()
#################
#BIBLIOTECAS
suppressMessages(library("ggplot2"))
suppressMessages(library("readxl"))
suppressMessages(library("dplyr"))
suppressMessages(library("plyr"))
suppressMessages(library("magrittr"))
suppressMessages(library("gtools"))
suppressMessages(library("Rmpfr"))
################
# Incluindo Funções auxiliares
source("auxiliar.R")
################

#--Definições Globais
#Definindo codigos de Ingresso ENEM + SISU
INGRESSO    <-  c(16,18)

#Códigos de Evasão
Ev.aleatoria      <- c(3, 7)
Ev.desistencia    <- c(4, 6, 14, 21)
Ev.academica      <- c(5, 22)
Ev.concluintes    <- c(1, 10, 20)
Ev.regulares      <- c(0)
Evasoes           <- append(Ev.desistencia, 
                            append(Ev.academica,
                                   append(Ev.concluintes, Ev.regulares)))
                                                               

#Período Inicio
PERIODO <- 2010.1
################
#Período Final
PERIODOF <- 2016.1
#--------------------------------------
####### Lendo Dados

#Alunos
Alunos            <- read.csv("../DADOS/Alunos/Alunos.csv") 

Alunos$CPF        %<>% as.character(as.character())
Alunos$MATRÍCULA  %<>% as.character(as.character())
#Alunos$CPF        %<>% mpfr(. , base = 16)
#Alunos$MATRÍCULA  %<>% mpfr(. , base = 16)

AlunosUnicos      <- Alunos %>% filter(., PERIODO_INGRESSO >= PERIODO, COD_EVASAO %in% Evasoes &
                                COD_INGRESSO %in% INGRESSO) %>% 
                                select(., CPF)  %>% 
                                unique 

# Alunos com PERIODO_EVASAO em branco ainda estão ativos, preenchendo informação do ano da análise.
Alunos$PERIODO_EVASAO <- ifelse(is.na(Alunos$PERIODO_EVASAO), PERIODOF, Alunos$PERIODO_EVASAO)
# Alunos com PERIODO_EVASAO > PERIODOF estavam ativos no periodo da análise
Alunos$PERIODO_EVASAO <- ifelse(Alunos$PERIODO_EVASAO > PERIODOF, PERIODOF, Alunos$PERIODO_EVASAO)

####### Rendimento

Periodos          <- "../DADOS/Rendimento" %>% list.files %>% substr(.,1,5) %>% unique
Files             <- "../DADOS/Rendimento" %>% list.files

Desempenho <- function(periodo){
  periodo <- 20101
  Filenames       <- Files %>% grep(periodo,., fixed = FALSE) %>% lapply(.,function(x) 
    paste("../DADOS/Rendimento/", Files[[x]], sep = ""))
  
  GetFiles        <- lapply(Filenames, function(x){  read.csv2(x, header = TRUE, sep = ",")  })
  
  desempenho  <- do.call(rbind, GetFiles)
  desempenho[is.na(desempenho)] <- 0
  desempenho$Periodo <- periodo
  
  desempenho %<>% select(., Periodo, Cód..Curso, Curso, Aluno, CH.integralizada, CRA, IEA)
  desempenho %<>% filter(., Curso != "Curso")
  
  return(desempenho)
}

DataDesempenho      <- lapply(Periodos, function(x) Desempenho(x))

Dados               <- do.call(rbind, DataDesempenho)
Dados[is.na(Dados)] <- 0


#Formato de variáveis
Dados$CRA               %<>% sub(",",".",.)
Dados$IEA               %<>% sub(",",".",.)
Dados$Periodo           %<>% as.numeric(as.character())
Dados$Cód..Curso        %<>% as.factor()
Dados$CH.integralizada  %<>% as.numeric(as.character())
Dados$CRA               %<>% as.numeric(as.character())
Dados$IEA               %<>% as.numeric(as.character())
#-----------------------------------------------------------
#-----------------------------------------------------------
#------------INÍCIO DA ANÁLISE------------------------------

###### Corrigindo alunos para novo ingresso

#' Arranja vínculos de alunos individualmente
DadosAluno <- function(cpf){

  
  Aluno       <- Alunos %>% filter(., CPF == cpf)
  vinculos    <- Aluno  %>% select(., CURSO) %>% unique
  
  #'Calcula a Duração dos Vínculos do aluno em cada curso
  duracaoV    <- function(curso){
    
              #' Subset dataframe apenas com vinculos do aluno para curso especificado
              durDF           <- Aluno  %>% filter(., CURSO %in% curso) %>% 
                                            select(., PERIODO_INGRESSO, PERIODO_EVASAO, 
                                                   COD_INGRESSO, COD_EVASAO, MEDIA_INGRESSO, 
                                                   NATURALIDADE, SEXO)
              
              #' Determina intervalo entre os diferentes vínculos
              durDF$IngCirc   <- durDF$PERIODO_INGRESSO %>% 
                                  shifter() %>% 
                                  diffPeriodo(., durDF$PERIODO_EVASAO)
              
              #' Se intervalo é > 4 é outro vínculo
              #' Se intervalo é negativo achou o último vínculo
              pos     <- numeric()
              pos[1]  <- 1
              
              if (length(durDF$PERIODO_INGRESSO) == 1) {
                pos[1] <- 1
              } else {
                for (i in length(durDF$IngCirc)) {
                  if (durDF$IngCirc[[i]] > 4 || durDF$IngCirc[[i]] <= 0){
                    pos[i] <- i
                  }
                }
              }
              ingressos <- numeric()
              evasões   <- numeric()
              coding    <- numeric()
              codevad   <- numeric()
              mediaI    <- numeric()
              
              pos <- pos[!is.na(pos)]
              
              for (i in c(1:length(pos))) {
                if (i == 1){
                  ingressos[i] <- durDF$PERIODO_INGRESSO[[i]]
                  evasões[i]   <- durDF$PERIODO_EVASAO[[pos[i]]]
                  coding[i]    <- durDF$COD_INGRESSO[[i]]
                  codevad[i]   <- durDF$COD_EVASAO[[pos[i]]]
                  mediaI[i]    <- durDF$MEDIA_INGRESSO[[i]]
                } else {
                  ingressos[i] <- durDF$PERIODO_INGRESSO[[pos[i-1]+1]]
                  evasões[i]   <- durDF$PERIODO_EVASAO[[pos[i]]]
                  coding[i]    <- durDF$COD_INGRESSO[[pos[i-1]+1]]
                  codevad[i]   <- durDF$COD_EVASAO[[pos[i]]]
                  mediaI[i]    <- durDF$MEDIA_INGRESSO[[pos[i-1]+1]]
                }
              }
              
              matrizV <- as.data.frame(cbind(ingressos, evasões, coding, codevad, mediaI))
              
              matrizV$NATURALIDADE <- durDF$NATURALIDADE[[1]]
              matrizV$SEXO <- durDF$SEXO[[1]]
              matrizV$CURSO <- curso
              
              return(matrizV)
                        
  }
  
  AlunosV     <- vinculos$CURSO %>% lapply(., function(x) duracaoV(x)) %>% do.call(rbind,.) %>% as.data.frame() 
  AlunosV$CPF <- cpf
  
  return(AlunosV)  
}


#'Arranja vínculos de lista de alunos
DadosAlunos <- function(df){
  
  getdataAluno <- df %>% lapply(., function(x) DadosAluno(x))
  getdataAluno <- do.call(rbind, getdataAluno) %>% as.data.frame()
  
  return(getdataAluno)
  
}

AlunosC     <- DadosAlunos(AlunosUnicos$CPF[800:10000])
AlunosCorreto  <- AlunosC %>% filter(., ingressos >= PERIODO & coding %in% INGRESSO & codevad %in% Evasoes ) 

AlunosCorreto$status <- ifelse( AlunosCorreto$codevad %in% Ev.academica, 
                                "evasão",
                                ifelse( AlunosCorreto$codevad %in% Ev.concluintes, 
                                        "graduado",
                                        ifelse (AlunosCorreto$codevad %in% Ev.desistencia, 
                                                "desistência",
                                                "ativos")))
AlunosCorreto$duracao <- diffPeriodo(AlunosCorreto$evasões, AlunosCorreto$ingressos)
AlunosCorreto$duracao <- ifelse(AlunosCorreto$duracao < 0, 0, AlunosCorreto$duracao)

write.csv(AlunosCorreto, file = "../DADOS/Alunos/Alunoscorrigidos.csv", row.names = TRUE)
#######################################
########################################
fim <- Sys.time()
fim-inicio

#Em woland Time difference of 1.349315 mins

#Limpando
rm(AlunosC, AlunosUnicos, Alunos)
#####################################
# Preparando sequência de desempenho por alunos.
