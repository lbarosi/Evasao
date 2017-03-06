suppressMessages(library("ggplot2"))
suppressMessages(library("ggthemes"))
suppressMessages(library("dplyr"))
suppressMessages(library("plyr"))
suppressMessages(library("magrittr"))
suppressMessages(library("gtools"))
#####################################
# Gráficos preliminares

#Lendo Dados
AlunosCorreto <- read.csv("./DADOS/Alunos/Alunoscorrigidos.csv")

AlunosCorreto$ingressos %<>% as.factor()
AlunosCorreto$evasões %<>% as.factor()
ggplot(filter(AlunosCorreto, status != "ativos"), aes(evasões, fill = status)) + geom_bar(stat = "count", position = "identity") +
  facet_grid(ingressos~.)


coorteEvasores <- ggplot(filter(AlunosCorreto, status != "ativos" & duracao > 1), aes(evasões, fill = status)) + geom_bar(stat = "count", position = "identity") +
  facet_grid(ingressos~.)+
  ggtitle("Composição da população de Evasores - Coortes de Ingresso") +
  labs(x = "Período Evasão", y = "Alunos") +
  theme_economist_white() + 
  theme(strip.text.y = element_text(size = 8))+
  theme(axis.text.x = element_text(size = 8))+
  theme(axis.text.y = element_text(size = 8))+
  theme(legend.position = "bottom") +
  theme(legend.text = element_text(size = 6))+
  guides(fill=guide_legend(nrow=1,byrow=TRUE)) +
  scale_fill_brewer(palette = "Set2")
