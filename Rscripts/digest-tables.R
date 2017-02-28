#!/usr/bin/Rscript
options(java.parameters = "-Xmx6096m")
library(readxl)
library(digest)
library(xlsx)
library(magrittr)
###########
#Hash de Tabelas

#Alunos

Alunos <- read.csv("../../DADOS-PESSOAIS/DADOS/Alunos/Alunos.csv", sep = ",")


Alunos$COD_INGRESSO %<>% as.numeric()
Alunos$COD_EVASAO %<>% as.numeric()
#------------------
Alunos$CPF <- sapply(Alunos$CPF, digest, algo = "md5")
Alunos$MATRÍCULA <- sapply(Alunos$MATRÍCULA, digest, algo = "md5")

write.csv(as.data.frame(Alunos), "../DADOS/Alunos/Alunos.csv", row.names = FALSE)

cat("\n HASH de Alunos disponível em ../DADOS/Alunos/Alunos.csv \n")


#Desempenho

files       <- list.files("../../DADOS-PESSOAIS/DADOS/Desempenho","ChCRAAnos")

files       <- sapply(files, function(x) {
  paste("../../DADOS-PESSOAIS/DADOS/Desempenho/",x, sep = "" )
    }
  ) 
n <- length(files)

for (i in c(1:n)){
  if(file.size(files[[i]]) != 0){
    getfiles <- read.csv(files[[i]], skip = 1)
    getfiles$Aluno <- sapply(getfiles$Aluno, digest, algo = "md5")
    nome <- substr(files[[i]],39,nchar(files[[i]]))
    nome <- paste("../DADOS/Rendimento/",nome, sep = "")
    nome %<>% substr(.,1,nchar(.)-4) %>% paste(.,".csv",sep="")
    
    write.csv(as.data.frame(getfiles), nome, row.names = FALSE)
    cat(paste("\n", i,"/",n," HASH disponível: ", nome, "\n", sep = ""))
    rm(getfiles)}
}

######################################################################




