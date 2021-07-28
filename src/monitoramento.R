# Bibliotecas -------------------------------------------------------------
library(pacman)

# Georreferenciamento e mapas
p_load(ggmap)
p_load(sp)
p_load(rgdal)
p_load(hereR)
p_load(geobr)

# Tabelas, Ferramentas estatísticas,
p_load(directlabels)
p_load(esquisse)
p_load(obAnalytics)
p_load(DescTools)
p_load(kableExtra)
p_load(RColorBrewer)
p_load(scales)

# Data wrangling
p_load(collapse)
p_load(here)
p_load(tictoc)
p_load(patchwork)
p_load(janitor)
p_load(glue)

# Próprios
p_load(cid10)
p_load(msrpack)

# Leitura
p_load(openxlsx)
p_load(readxl)
p_load(WriteXLS)
p_load(ggthemes)
p_load(googlesheets4)
p_load(vroom)

# Transformação e análise de dados
p_load(caret)
p_load(zoo)
p_load(tidyverse)
p_load(lubridate)

# Ajustes locais ----------------------------------------------------------

set_key(api_key = "tfgapuFbaa8rSY0QS_dbZj9d8qmdeKiXFHl2L39b-FY") # Api HERE
Sys.setenv(TZ="America/Recife")
options(tz="America/Recife")
Sys.getenv("TZ")
options(scipen = 999999)
Sys.setlocale("LC_TIME", "pt_BR")




# Carregamentos iniciais --------------------------------------------------


solicitacoes <- read_rds(file = "~/Dropbox/Coding/R/data/gerint/bin/solicitacoes.rds")
sol <- solicitacoes$solicitacoes
int <- solicitacoes$internados
# Tipos de cids

cids <- read_xlsx(path = "data/grupos cid.xlsx") %>% clean_names()
table(cids$grupo)
glimpse(int)


# Filtragens e bancos auxiliares ------------------------------------------


respiratorias <- cids %>% 
  filter(grupo == "Respiratórias") %>% pull(codigocid)

op_inverno <- sol %>%
  filter(datasolicitacao >= ymd("2020-05-01")) %>% 
  filter(!flag_covid) %>% 
  filter(flag_internou) %>% 
  filter(flag_moradorPOA) %>% 
  filter(codigocid %in% respiratorias)

Desc(op_inverno$idade)

Desc(op_inverno$tipoleito)



internados <- sol %>%
  filter(datasolicitacao >= ymd("2020-05-01")) %>% 
  filter(!flag_covid) %>% 
  filter(flag_internou) %>% 
  filter(flag_internado) %>% 
  filter(flag_moradorPOA) %>% 
  filter(codigocid %in% respiratorias)
