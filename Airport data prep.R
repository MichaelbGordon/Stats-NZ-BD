

# Analysis of the nature of the firms and employment that are located in AUckland International Airport Environs. 
# In this case 'environs' is defined as the are unit which contains the airport
# 
#Condordance of codes to names can be found here:
#             http://www.stats.govt.nz/methods/classifications-and-standards/classification-related-stats-standards/industrial-classification.aspx
# 

library(dplyr)
library(ggplot2)

# Importing Data
temp <- tempfile()
download.file("http://www3.stats.govt.nz/CSV/BusDem/BusDem2015_dotStat_7602.zip",temp)
Unzipped <- unz(temp, "Full_dataset_7602.csv")
BD <- read.csv(Unzipped, header = TRUE, stringsAsFactors = FALSE)
unlink(temp)

# Area Unit which contains area unit
AreaUnit <-  "A524200"

# Cleaning + Wrangling

# Removing all other years and employee size groups 
BD2015 <- BD %>%
  filter(YEAR == "2015", EMP_SIZE_GRP == "TOTAL")

# Removing flags with generic 'c' 
BD2015[is.na(BD2015)] <- 'c' 
BD2015 <- BD2015 %>%   
  select(-Flags)

# Creating ANZSIC division column
BD2015 <- BD2015 %>%
  mutate(ANZSIC_Level  = nchar(ANZSIC06)
         )

# Filtering out all other area units
AirportEnvirons <- BD2015 %>%   
  filter(AREA == AreaUnit, ANZSIC_Level == "4") 

# Selecting non suppressed data greater than 0
AirportEnvirons <- AirportEnvirons %>%   
  filter(Data != "c", Data != 0)

# Cleaning data set to essential columns
AirportEnvirons_Cleaned <- AirportEnvirons %>% 
  select(ANZSIC06,MEASURE,Data)





