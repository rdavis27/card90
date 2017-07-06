# Reproduce Table 4 from http://davidcard.berkeley.edu/papers/mariel-impact.pdf
#install.packages("plyr")
#install.packages("ggplot2")
library(foreign)
library(plyr)
library(ggplot2)
# year_begin cannot precede 1979 because this is the earliest morg file available
# year_end cannot currently exceed 1985 because changes in the morg file requires other code changes
year_begin <- 1979
year_end   <- 1985

read_morg <- function(aa, year, file, defl){
  path <- paste0("data/", file)
  dd <- read.dta(path, convert.factors = FALSE)
  print(paste(year, "all   =", dim(dd)[1]))

  # FILTER THE DATA
  dd <- dd[dd$smsarank %in% c(26, 21, 14, 2, 33),] # Miami, Atlanta, Houston, Los Angeles, Tampa-St. Petersburg 
  print(paste(year, "metro =", dim(dd)[1]))
  dd <- dd[dd$age >= 16 & dd$age <= 61,]
  print(paste(year, "total =", dim(dd)[1]))

  # DEFINE NEW FIELDS
  dd$year <- year
  dd$defl <- defl
  dd$miami <- 0
  dd$miami[dd$smsarank == 26] <- 1
  dd$grade <- dd$gradeat
  dd$grade[dd$gradecp == 2] <- dd$gradeat[dd$gradecp == 2] - 1
  dd$group <- 5 #  Other Hispanics Incl Black & Puerto Rico
  dd$group[dd$ethnic == 8 & dd$race == 1] <- 1
  dd$group[dd$ethnic == 8 & dd$race == 2] <- 2
  dd$group[dd$ethnic == 8 & dd$race == 3] <- 3
  #dd$group[(dd$ethnic == 8 | is.na(dd$ethnic)) & dd$race == 1] <- 1 # White Nonspanish
  #dd$group[(dd$ethnic == 8 | is.na(dd$ethnic)) & dd$race == 2] <- 2 # Black Nonspanish
  #dd$group[(dd$ethnic == 8 | is.na(dd$ethnic)) & dd$race == 3] <- 3 # Other Nonspanish
  dd$group[dd$ethnic == 5] <- 4 # Cuban
  #dd$group[dd$ethnic == 9] <- 6 # Don't Know !!!

  # FILTER ON NEW FIELDS AND AGGREGATE
  ee <- ddply(dd, .(year, miami, group), summarize, count=length(earnwt), pop=sum(earnwt/12), grade=weighted.mean(grade, earnwt))
  #print(ee)

  # define unemployed (0=employed, 1=unemployed, NA=not in labor force)
  dd$labf <- 0
  dd$labf[dd$esr >= 1 & dd$esr <= 3] <- 1
  dd$unem <- NA
  dd$unem[dd$esr == 1 | dd$esr == 2] <- 0
  dd$unem[dd$esr == 3] <- 1
  
  ff <- ddply(dd, .(year, miami, group, unem), summarize, cnt=length(earnwt), pop=sum(earnwt/12))
  #print(ee)
  #print(ff)
  
  # calculate unemployment rate and add to ee
  unem <- ff[ff$unem == 1,]
  empl <- ff[ff$unem == 0,]
  urate <- merge(unem, empl, by = c("year", "miami", "group"))
  urate$urate <- 100 * urate$pop.x / (urate$pop.x + urate$pop.y)
  urate <- urate[,c(1:3,5,6,8:10)]
  ee <- merge(ee, urate, by = c("year", "miami", "group"))
  names(ee)[7:10] <- c("n_unem", "pop_unem", "n_emp", "pop_emp")
  #print(ee)
 
  # calculate hourly earnings
  dd$earnhre <- dd$earnhre * dd$defl / 100
  dd$earnwke <- dd$earnwke * dd$defl
  #dd <- dd[!is.na(dd$earnhre) | (!is.na(dd$earnwke) & !is.na(dd$uhourse) & dd$uhourse > 0),] # drop if no earnings
  dd <- dd[(!is.na(dd$earnhre) | (!is.na(dd$earnwke)) & !is.na(dd$uhourse) & dd$uhourse > 0),] # drop if no earnings
  #dd <- dd[dd$class < 5,] # drop self-employed
  dd$earnhre[is.na(dd$earnhre) | !dd$paidhre] <- dd$earnwke[is.na(dd$earnhre)]/dd$uhourse[is.na(dd$earnhre)]
  #dd$earnhre <- dd$earnwke/dd$uhourse # use weekly earnings for all
  
  #[1] 1.997522 1.696502 1.536084 1.674918 1.622303 (9348) - results if log taken AFTER aggregation
  #ee <- ddply(dd, .(year, miami, group), summarize,
  #            count=length(earnwt), earnwt2=sum(earnwt), earnhre=weighted.mean(earnhre, earnwt))
  #[1] 1.830276 1.606115 1.486748 1.600197 1.512467 (9348)
  gg <- ddply(dd, .(year, miami, group), summarize,
              n_earn=length(earnwt), pop_earn=sum(earnwt/12), log_earn=weighted.mean(log(earnhre), earnwt),
              earnwk=weighted.mean(earnwke), uhours=weighted.mean(uhourse))
  #print(gg[gg$miami == 1,])
  
  #gg <- gg[,c(1:3,5)]
  ee <- merge(ee, gg, by = c("year", "miami", "group"))
  print(ee)
  aa <- rbind(aa, ee)
  assign('aa', aa, envir = .GlobalEnv)
}

# CPI data comes from https://data.bls.gov/cgi-bin/surveymost?cu , U.S. All items, 1982-84=100 - CUUR0000SA0
#cpi <- read.csv("data/cpi_all.csv")
# Hardcode to 1979-1985 rather than read file for now
Year <- c(1979:1985)
Annual <- c(2.174,2.468,2.724,2.891,2.984,3.111,3.222)
cpi <- data.frame(Year, Annual)
cpi80 <- cpi$Annual[cpi$Year == 1980]
cpi$defl <- cpi80/cpi$Annual
# Overwrite 1979-1985 with values from Card's program - these are very nearly equal to calculated values
#cpi$defl[cpi$Year == 1979] <- 2.468/2.174
#cpi$defl[cpi$Year == 1980] <- 1
#cpi$defl[cpi$Year == 1981] <- 2.468/2.724
#cpi$defl[cpi$Year == 1982] <- 2.468/2.891
#cpi$defl[cpi$Year == 1983] <- 2.468/2.984
#cpi$defl[cpi$Year == 1984] <- 2.468/3.111
#cpi$defl[cpi$Year == 1985] <- 2.468/3.222
aa <- NULL
for (year in year_begin:year_end){
  yr <- year %% 100
  file <- paste0("morg", yr, ".dta")
  defl <- cpi$defl[cpi$Year == year]
  read_morg(aa, year, file, defl)
}

write.table(aa, "card85.txt")
write.table(aa, "card85.csv", sep=',')
