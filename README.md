# **Estudo de Indicadores de Evasao**


## Objetivo

1. A Evasão é um fenômeno generalizado nas IES.
2. Ainda que se reconheça que a evasão é um fenômeno multifatorial que está relacionado primariamente com uma escolha individual do aluno, ela representa uma preocupação para a gestão acadêmica, quer seja pelo que representa nas fontes de financiamento, quer seja pela função social que as IES devem cumprir.
3. O conhecimento prévio da possibilidade de evasão de um aluno pode permitir ações específicas, no nível do curso, que possam ajudar a mitigar o problema, nos casos em que essa ação esteja em poder da IES.
4. Não há nenhuma forma a prioristica para determinar se a evasão acadêmica pode ser mitigada ou não.
5. Existe uma crença generalizada de que a evasão pode ser prevista, com um número suficiente de dados.
6. Resultados preliminares da literatura permitem acreditar que sejas possível focar em um conjunto de indicadores acadêmicos como preditores, sem a necessidade de questionários amples de variáveis de natureza mais subjetiva.

## Hipóteses Principais

1. O conceito de evasão é bastante amplo e é fundamental que um trabalho deixe claro qual é a definição de trabalho.
2. O conceito de evasão considerado é o conceito de **evasão de curso**, também chamado de microevasão na literatura. O aluno é considerado evadido se não concluiu o seu curso, independentemente do tempo que levou para isso.
3. O foco do trabalho é o aluno individual, não havendo preocupação da previsão de uma taxa de evasão para o curso específico. Dessa forma não é necesário que se adote uma das definições específicas de evasão de curso existentes na literatura.
4. A evasão está relacionada com a interação do aluno com o curso/instituição, sendo um ato em que o aluno é protagonista. Nesse sentido a evasão é modelada de maneira semelhante ao modelo de suicídio de Durkheim, com modelos existentes bastante amplos e descritivos como os modelos de Tinto, Bean e Cabrera.
5. Nesse sentido, podemos considerar a evasão como composta por motivos econômicos, vocacionais ou acadêmicos.
6. Consideramos evasão a decisão do aluno em prosseguir seus estudos no mesmo curso. Essa escolha é uma escolha racional repetida a cada semestre, tendo diversos motivadores. Supomos que os diversos motivadores não ocorrem instantaneamente, sendo uma avaliação racional ao longo do tempo, que imprime assinaturas específicas no desempenho acadêmico do aluno que podem ser estudadas, classificadas, e previstas.
7. Parece possível diferenciar a evasão em tipos com características diversas entre si.
8. É importante considerar que os alunos percorrem um curso em que as características de desempenho acadêmico sejam prioritariamente devidas ao seu esforço pessoal. Ou seja, a distribuição de notas de cada disciplina ao longo do tempo deve ser uma distribuição de probabilidade fixa, para que possamos considerar que os alunos percorrem o mesmo curso.
9. Cada curso contém um grande número de disciplinas e parece que podemos assumir que as decisões dos alunos apresentam características amplas que podem ser modeladas para todos os cursos simultaneamente, ainda que seja importante observar se a modelagem considerando o tipo de curso possa trazer elementos novos.
10. A decisão de evasão é uma decisão refletida que depende da histórica acadêmica do aluno, mas indicadores acadêmicos referentes a um único período podem captar dados suficientes para a análise da evasão, a medida em que refletem os dados do histórico do aluno.

## Tipos de Evasão

1. **Evasão do Primeiro Período**: Não há motivo para acreditar que essa evasão tenha uma modelagem muito diferente das outras no que diz respeito a escolha de um agente racional, contudo existem muito poucas informações acadêmicas para esses alunos e ela é numericamente superior aos outros períodos. Considerar a evasão de primeiro período pode tornar a aprendizagem de um sistema mais difícil e enviesada com o tempo de curso, caso esse seja um classificador.
2. **Evasão aleatória**: Algumas formas de evasão claramente não se enquadram no esquema de evasão descrito acima, porque dependem de ainda outros fatores, como a evasão por falecimento e a evasão por medida judicial.
3. **Evasão por desistência**: Uma forma de evasão que considera o desejo do aluno em sair de seu curso, quer pela desistência voluntária de seu vínculo, pelo abandono do seu curso ou por mobilidade para outra IES ou Curso.
4. **Evasão por Motivos Acadêmicos**: as regras das instituições apresentam conjuntos de restrições que os alunos devem cumprir para manter seus vínculos com a Universidade. Notadamente, na caso da UFCG, os alunos podem ser desligados ao reprovar por três vezes na mesma disciplina ou por atingir o tempo máximo do curso.

## Investigações Preliminares

1. Escolha do recorte da base de dados 
2. Análise descritiva da base de dados
3. Análise preliminar do comportamento das diferentes evasões
4. Teste das distribuições de notas das disciplinas ao longo do tempo
5. Escolha dos classificadores
5. Implementação de modelos
6. Estudos adicionais

## Preparação dos Dados

Considerando a natureza do objeto de estudo e a natureza do banco de dados disponível, é necessário construir um recorte adequado dos dados.

* Considerar os dados a partir do período 2010.1, em que a base de dados é mais confiável e possui informações robustas sobre a maioria das variáveis.
* Considerar apenas as formas de ingresso originárias ENEM e SiSU. As outras formas de ingresso tem dados acadêmicos não comparáveis entre si, como o reingresso, o PSTV, reopção de curso...
* Manter a informação acerca das cotas. Contudo a análise com a variável referente a cotas tem um período mais curto de informações, podendo ser um refinamento do modelo.
* Manter a nota de ingresso que corresponde a Nota ENEM, equiparável em todo o período analisado.
* Manter a variável NATURALIDADE, ainda que se deva levar em conta que existem algumas dificuldades com essa informação no período SiSU. Considerar uma variável auxiliar como a distância do município de naturalidade ao campus em que o aluno realiza seu curso pode ser relevante para a decisão de evasão ou não.
* A base de dados contém informações de Matrícula e CPF, mas estamos querendo estudar o comportamento individual, portanto o indicador principal deve ser o CPF.
* Uma determinada matrícula pode ter interrupções e reingressos de diversas naturezas. É necessário reconstruir a história de cada CPF com as informações de ingresso originário e saída definitiva da IES afim de determinar o tempo total na instituição e criar um registro do histórico acadêmico do aluno em todos os períodos em que ficou ativo, cruzando os dados da tabela aluno com os dados das tabelas de desempenho.
* Na literatura internacional, o intervalo de até dois anos em que o aluno é desligado e retorna para a IES é considerado como um período contínuo. É seguro dizer que muitos alunos tem um vínculo continuado de um período ou dois para outro, mas não há dados sobre períodos mais longos. As variáveis tempo de interrupção e número de interrupções parecem ser importantes.
* A evasão deve ser classificada em tipos com possível comportamente diferenciado:
    * Evasão inicial: ocorre no primeiro período. É mais frequente e seguramente é difícil conseguir modelar seu comportamento pela falta de dados acadêmicos.
    * Evasão por abandono: Ocorre, majoritariamente por decisão do aluno, que pode desistir formalmente, não formalizar matrícula no período seguinte ou abandonar as aulas e sewr reprovado por falta em todas as disciplinas do período. É importante ressalvar que a evasão por reprovação em todas as disciplinas próxima ao final do curso é um motivo acadêmico, comumente relacionado com uma interrupção, mais do que com uma evasão, contudo a reprovação por falta em um conjunto de disciplinas on início do curso representa frequentemente um abandono. Não é necessário distinguir esses dois casos se a correção para as interrupções for realizada adequadamente.
    * Evasão por motivação acadêmica: Apenas duas formas causam o desligamento do aluno por motivação acadêmica nesse contexto (excluída a reprovação por falta que é considerada abandono): o atingimento do tempo máximo para o curso e a reprovação em uma mesma disciplina por 3 vezes. Para ambos os casos existe uma quantidade considerável de recursos disponíveis para os alunos. A evasão dessa natureza só pode ser mensurada adequadamente com a correção para interrupções. (Que pode, em última análise, ser considerada uma medida institucional para a mitigação dessa forma de evasão)
    * Evasão Imprevisível: evasões por falecimento, decisão judicial, término de convênio, são condições determinadas por fatores totalmente independentes do aluno e não é razoável supor que possam ser modelados com base nos indicadores acadêmicos.

## Rscripts

> **digest-tables.R** está presente no diretório de scripts R apenas para referência acerca de quais manipulações estão sendo realizadas nos arquivos de dados para o mascaramento das identidades dos sujeitos.

> **evasao-basedata.R** prepara o recorte de dados descrito acima.

## Conteúdo em Dados

### Cursos

#### **Descrição das variáveis**

Nome | Descrição
-----|----------------------------------------------------------------
CURSO | Código Curso UFCG
ÁREA DO CONHECIMENTO | Humanas/Exatas/Biológicas
CAMPUS | (1:7)
CENTRO | (11, 12, 13, 14, 15, 21, 31, 41, 51, 71, 91)
SIGLA  | (CCT, CCBS, CH, CEEI, CTRN, CFP, CSTR, CES, CDSA, CCTA)
Curso  | Nome do Curso por extenso
turno  | (M, V, N, D)
cod. EMEC | Código oficial do MEC agrega cursos diurno e noturno.
Situação EMEC | Ativo (Com entrada no vestibular), Em Extinção (com alunos as sem entrada no vestibular), Extinto (sem alunos, sem entrada)
Currículo | ano do currículo ativo no curso
CH | Carga horária mínima do curso
Tempo mínimo| Tempo do curso em anos
VAGAS1 | Entrada no Primeiro semestre
VAGAS2 | Entrada no Segundo Semestre
VAGAS | VAGAS1 + VAGAS2
PG | Fatores para a comissão de modelos de OCC
FATOR | Fatores para a comissão de modelos de OCC
DURACAO | Fatores para a comissão de modelos de OCC
BFS | Fatores para a comissão de modelos de OCC
BT | Fatores para a comissão de modelos de OCC
NOVO | Fatores para a comissão de modelos de OCC

### Alunos

Arquivo CSV com o vínculo de alunos de 2002.1 a 2016.1, incluindo forma de ingresso, forma de evasão. 

#### **Descrição das variáveis**

Nome | Descrição
-----|--------------------------------------------------------
PERIODO_EVASAO | Período em que o aluno foi desligado da UFCG. 
CPF | HAS md5 do CPF do aluno
MATRÍCULA | HASH md5 do número de matrícula do aluno
CURSO | código UFCG do curso de aluno
PERIODO_INGRESSO | período de ingresso na UFCG
COD_INGRESSO | código descritor da forma de ingresso do aluno
COD_EVASAO | código descritor da forma de ingresso do aluno
MEDIA_INGRESSO | média obtida no processo seletivo de entrada. Pode representar Vestibular, ENEM, Prova de ingresso de processos seletivos de formas derivadas.
NATURALIDADE | Município de nascimento. Reliable na época ENEM apenas
ESTADO | Estado de origem é reliable apenas na época ENEM
TIPO_ENSINO_MEDIO | Apenas a partir do ENEM
COTISTA | Apenas a partir da lei de cotas
NASCIMENTO | Data de nascimento 
SEXO | M ou F




### Rendimento

Arquivos por centro e por período com as informações de desempenho acadêmicas de todos os alunos ativos no período indicado.

#### **Descrição das variáveis**

Nome | Descrição
-----|--------------------------------------------------------
Cód..Curso | Código Curso UFCG
Curso | Nome do Curso UFCG
Aluno | HASH md5 do número de matrícula do aluno
CH.Integralizada | Carga horária integralizada até o período do arquivo
Faixa.CH.. | Desnecessário
CRA | Coeficiente de Rendimento acadêmico CRA no período do arquivo.
Faixa.CRA | Desnecessário
Semestres | Número de semestres integralizados até o período do arquivo.
Anos | NÃO UTILIZAR
MC | Média de conclusão para o semestre do arquivo
MCN | NÃO UTILIZAR
IEA | IEA para o semestre do arquivo
IEAN | NÃO UTILIZAR
Amostra | NÃO UTILIZAR
----------------------------------------------------------------

### Codificações

#### Formas de Ingresso

COD | DESCRIÇÃO
------|----------------------------------------------------------
1 | VESTIBULAR
2 | PSTV
4 | DECISÃO CSE
5 | GRADUADO
9 | TRANSFERÊNCIA EX-OFFICIO
11| JUDICIAL
13| REINGRESSO
14| MOBILIDADE
15| MOBILIDADE INTERNACIONAL
16| ENEM (a partir de 2010.1)
18| SISU (a partir de 2014.2)
19| NOVO CURRÍCULO
20| ADMINISTRATIVO

#### Formas de Evasão

COD | DESCRIÇÃO
------|----------------------------------------------------------
1 | GRADUADO
2 | TRANSFERÊNCIA PARA OUTRA IES
3 | FALECIMENTO
4 | CANCELAMENTO POR ABANDONO
5 | CANCELAMENTO (JUBILADO)
6 | CANCELADO - MUDANÇA DE CURSO
7 | CANCELADO - DECISÃO JUDICIAL
8 | CANCELADO - SOLICITAÇÃO DO ALUNO
9 | SUSPENSÃO TEMPORÁRIA
10 | CONCLUÍDO NÃO COLOU GRAU
11 | CANCELAMENTO - NÃO CUMPRIMENTO PEC
12 | CANCELADO - NOVO VESTIBULAR
13 | CUMPRIMENTO CONVÊNIO
14 | NOVO REGIMENTO (MUDANÇA DE CURSO)
15 | NÃO COMPARECEU AO CADASTRO
16 | REMANEJADO CURSO OU PERÍODO
17 | NÃO COMPARECEU AO REMANEJAMENTO
18 | NÃO COMPARECEU À MATRÍCULA - FERA
19 | TÉMINO DO INTERCÂMBIO
20 | GRADUADO JUDICIAL
21 | CANCELADO - REPROVAÇÃO POR FALTA
22 | CANCELADO - R3X
23 | SUSPENSO - DÉBITO BIBLIOTECA
24 | CANCELAMENTO - NOVO CURRÍCULO
25 | SOLICITOU DESVÍNCULO SEM MATRÍCULA
50 | AGUARDANDO CADASTRAMENTO

#### TIPO DE ENSINO MÉDIO

COD | DESCRIÇÃO
------|----------------------------------------------------------
1	| PRIVADA
2	| PÚBLICA
3	| MAJORITARIAMENTE PRIVADA
4	| MAJORITARIAMENTE PÚBLICA
5	| PROFISSIONALIZANTE

#### COTAS ( a partir de 2014.2 )

COD | DESCRIÇÃO
------|----------------------------------------------------------
NA	|LIVRE
2	 | RENDA <1,5SM + APPI
3	 | RENDA <1,5SM + NAPPI
4	 | RENDA >1,5SM + APPI
5	 | RENDA >1,5SM + NAPPI