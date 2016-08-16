# Script for importing, cleaning and wrangling 2015 Business Demography Data
library(dplyr)

# Importing Data
temp <- tempfile()
download.file("http://www3.stats.govt.nz/CSV/BusDem/BusDem2015_dotStat_7602.zip",temp)
Unzipped <- unz(temp, "Full_dataset_7602.csv")
BD <- read.csv(Unzipped, header = TRUE, stringsAsFactors = FALSE)
unlink(temp)

# Cleaning + Wrangling

BD2015 <- BD %>%
          filter(YEAR == "2015", EMP_SIZE_GRP == "TOTAL")

BD2015[is.na(BD2015)] <- 'c' 

BD2015 <- BD2015 %>%   
          select(-Flags)

BD2015 <- BD2015 %>%
          mutate(AREA_TYPE = substr(AREA, 1, 1),
                 ANZSIC_Level  = nchar(ANZSIC06)
                 )


# 4 Digit ANZSIC at Regional Council
RC_4D <- BD2015%>%   
         filter(AREA_TYPE == "R", ANZSIC_Level == "4")

# 3 Digit ANZSIC at Regional Council
RC_3D <- BD2015%>%   
  filter(AREA_TYPE == "R", ANZSIC_Level == "3")


# 1 Digit ANZSIC at Regional Council
RC_1D <- BD2015%>%   
  filter(AREA_TYPE == "R", ANZSIC_Level == "1")










