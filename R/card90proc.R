library(ggplot2)
aa <- read.table("card85.txt")
aa$ngroup <- aa$group
aa$group <- "Unknown"
aa$group[aa$ngroup == 1] <- "White"
aa$group[aa$ngroup == 2] <- "Black"
aa$group[aa$ngroup == 3] <- "Other"
aa$group[aa$ngroup == 4] <- "Cuban"
aa$group[aa$ngroup == 5] <- "Hispanic"
mm <- aa[aa$miami == 1 & aa$ngroup != 3,]
oo <- aa[aa$miami == 0 & aa$ngroup != 3,]

plot_table3 <- function(dd, loc){
  #x11()
  gg <- ggplot(dd, aes(x=year, y=log_earn, group=group))
  gg <- gg + geom_line(aes(color=group), size=1)
  gg <- gg + geom_point(aes(color=group, shape=group), size=3)
  gg <- gg + ggtitle(paste("Logarithms of Real Hourly Earnings of Workers Age 16-61 in", loc))
  gg <- gg + xlab("Year") + ylab("Log of Real Hourly Earnings")
  print(gg)
  readline("Press enter to continue, escape to exit")
}

plot_table4 <- function(dd, loc){
  #x11()
  gg <- ggplot(dd, aes(x=year, y=urate, group=group))
  gg <- gg + geom_line(aes(color=group), size=1)
  gg <- gg + geom_point(aes(color=group, shape=group), size=3)
  gg <- gg + ggtitle(paste("Unemployment Rates of Individuals Age 16-61 in", loc))
  gg <- gg + xlab("Year") + ylab("Unemployment Rate")
  print(gg)
  readline("Press enter to continue, escape to exit")
}

plot_earnwk <- function(dd, loc){
  #x11()
  gg <- ggplot(dd, aes(x=year, y=earnwk, group=group))
  gg <- gg + geom_line(aes(color=group), size=1)
  gg <- gg + geom_point(aes(color=group, shape=group), size=3)
  gg <- gg + ggtitle(paste("Real Weekly Earnings of Workers Age 16-61 in", loc))
  gg <- gg + xlab("Year") + ylab("Real Weekly Earnings")
  print(gg)
  readline("Press enter to continue, escape to exit")
}

plot_uhours <- function(dd, loc){
  #x11()
  gg <- ggplot(dd, aes(x=year, y=uhours, group=group))
  gg <- gg + geom_line(aes(color=group), size=1)
  gg <- gg + geom_point(aes(color=group, shape=group), size=3)
  gg <- gg + ggtitle(paste("Usual Weekly Hours Worked of Workers Age 16-61 in", loc))
  gg <- gg + xlab("Year") + ylab("Usual Weekly Hours")
  print(gg)
  readline("Press enter to continue, escape to exit")
}

table1tran <- matrix(
  c(319.3,244.1,252.4,102.9,928.4,
     12.8, 11.4, 11.0, 11.6, 11.8,
     75.6, 68.3, 77.2, 68.8, 73.1,
    241.3,166.6,194.7, 70.8,678.2),
#     13.1, 11.8, 11.3, 11.9, 12.1,
#     21.1, 24.1, 22.0, 26.0, 22.8),
  nrow=5,
  ncol=4
)
table1orig <- t(table1tran)
table1 <- NULL
for (i in c(1,2,4,5)){
  Group <- c(aa$pop[aa$year == 1979 & aa$miami == 1 & aa$ngroup == i]/1000,
           aa$grade[aa$year == 1979 & aa$miami == 1 & aa$ngroup == i],
       ( aa$pop_emp[aa$year == 1979 & aa$miami == 1 & aa$ngroup == i] +
        aa$pop_unem[aa$year == 1979 & aa$miami == 1 & aa$ngroup == i]) * 100 /
             aa$pop[aa$year == 1979 & aa$miami == 1 & aa$ngroup == i],
       ( aa$pop_emp[aa$year == 1979 & aa$miami == 1 & aa$ngroup == i] +
        aa$pop_unem[aa$year == 1979 & aa$miami == 1 & aa$ngroup == i])/1000)
  table1 <- cbind(table1, Group)
}
Group <- c(sum(aa$pop[aa$year == 1979 & aa$miami == 1])/1000, NA,
           ( sum(aa$pop_emp[aa$year == 1979 & aa$miami == 1]) +
               sum(aa$pop_unem[aa$year == 1979 & aa$miami == 1])) * 100 /
             sum(aa$pop[aa$year == 1979 & aa$miami == 1]),
           ( sum(aa$pop_emp[aa$year == 1979 & aa$miami == 1]) +
               sum(aa$pop_unem[aa$year == 1979 & aa$miami == 1]))/1000)
table1 <- cbind(table1, Group)
table1 <- round(table1, 1)
#row.names(table1) <- c("Population (1000s)"," Mean Education"," Percent in Labor Force","Labor Force (1000s)"," Mean Education"," Percent Age 16-24")
row.names(table1) <- c("Population (1000s)"," Mean Education"," Percent in Labor Force","Labor Force (1000s)")
colnames(table1)  <- c("Whites","Blacks","Cubans","Hispanics","All")
table1diff <- table1 - table1orig
table1perc <- 100*(table1-table1orig)/table1
table1perc <- round(table1perc, 1)
cat("===========================================================\n")
cat("TABLE 1. CHARACTERISTICS OF 16-61-YEAR-OLDS IN MIAMI, 1979.\n")
cat("===========================================================\n")
cat("CALCULATED BY PROGRAM\n")
cat("---------------------\n")
print(table1)
cat("----------------------------------------\n")
cat("ACTUAL DIFFERENCES FROM PUBLISHED VALUES\n")
cat("----------------------------------------\n")
print(table1diff)
cat("-----------------------------------------\n")
cat("PERCENT DIFFERENCES FROM PUBLISHED VALUES\n")
cat("-----------------------------------------\n")
print(table1perc)
readline("Press enter to continue, escape to exit")

table3tran <- matrix(
  c(1.85,1.83,1.85,1.82,1.82,1.82,1.82,
    1.59,1.55,1.61,1.48,1.48,1.57,1.60,
    1.58,1.54,1.51,1.49,1.49,1.53,1.49,
    1.52,1.54,1.54,1.53,1.48,1.59,1.54,
    1.93,1.90,1.91,1.91,1.90,1.91,1.92,
    1.74,1.70,1.72,1.71,1.69,1.67,1.65,
    1.65,1.63,1.61,1.61,1.58,1.60,1.58),
  nrow=7,
  ncol=7
)
table3orig <- t(table3tran)
table3 <- NULL
for (i in 1:7){
  yr <- 1978 + i
  tab3yr <- c(aa$log_earn[aa$year == yr & aa$miami == 1 & aa$ngroup == 1],
              aa$log_earn[aa$year == yr & aa$miami == 1 & aa$ngroup == 2],
              aa$log_earn[aa$year == yr & aa$miami == 1 & aa$ngroup == 4],
              aa$log_earn[aa$year == yr & aa$miami == 1 & aa$ngroup == 5],
              aa$log_earn[aa$year == yr & aa$miami == 0 & aa$ngroup == 1],
              aa$log_earn[aa$year == yr & aa$miami == 0 & aa$ngroup == 2],
              aa$log_earn[aa$year == yr & aa$miami == 0 & aa$ngroup == 5])
  table3 <- cbind(table3, tab3yr)
  colnames(table3)[i] <- yr
}
table3 <- round(table3, 2)
#row.names(table3) <- c("White","Black","Cuban","Hispanic","White","Black","Hispanic")
row.names(table3) <- c("Miami White","      Black","      Cuban","      Hispanic","Other White","      Black","      Hispanic")
table3diff <- table3 - table3orig
table3perc <- 100*(table3-table3orig)/table3
table3perc <- round(table3perc, 1)
cat("================================================================\n")
cat("TABLE 3. LOGARITHMS OF REAL HOURLY EARNINGS OF WORKERS AGE 16-61\n")
cat("         IN MIAMI AND FOUR COMPARISON CITIES, 1979-85.\n")
cat("================================================================\n")
cat("CALCULATED BY PROGRAM\n")
cat("---------------------\n")
print(table3)
cat("----------------------------------------\n")
cat("ACTUAL DIFFERENCES FROM PUBLISHED VALUES\n")
cat("----------------------------------------\n")
print(table3diff)
cat("-----------------------------------------\n")
cat("PERCENT DIFFERENCES FROM PUBLISHED VALUES\n")
cat("-----------------------------------------\n")
print(table3perc)

plot_table3(mm, "Miami")
plot_table3(oo, "Comparison Cities")

table4tran <- matrix(
  c( 5.1, 2.5, 3.9, 5.2, 6.7, 3.6, 4.9,
     8.3, 5.6, 9.6,16.0,18.4,14.2, 7.8,
     5.3, 7.2,10.1,10.8,13.1, 7.7, 5.5,
     6.5, 7.7,11.8, 9.1, 7.5,12.1, 3.7,
     4.4, 4.4, 4.3, 6.8, 6.9, 5.4, 4.9,
     10.3,12.6,12.6,12.7,18.4,12.1,13.3,
     6.3, 8.7, 8.3,12.1,11.8, 9.8, 9.3),
  nrow=7,
  ncol=7
)
table4orig <- t(table4tran)
table4 <- NULL
for (i in 1:7){
  yr <- 1978 + i
  tab4yr <- c(aa$urate[aa$year == yr & aa$miami == 1 & aa$ngroup == 1],
              aa$urate[aa$year == yr & aa$miami == 1 & aa$ngroup == 2],
              aa$urate[aa$year == yr & aa$miami == 1 & aa$ngroup == 4],
              aa$urate[aa$year == yr & aa$miami == 1 & aa$ngroup == 5],
              aa$urate[aa$year == yr & aa$miami == 0 & aa$ngroup == 1],
              aa$urate[aa$year == yr & aa$miami == 0 & aa$ngroup == 2],
              aa$urate[aa$year == yr & aa$miami == 0 & aa$ngroup == 5])
  table4 <- cbind(table4, tab4yr)
  colnames(table4)[i] <- yr
}
table4 <- round(table4, 1)
#row.names(table4) <- c("White","Black","Cuban","Hispanic","White","Black","Hispanic")
row.names(table4) <- c("Miami White","      Black","      Cuban","      Hispanic","Other White","      Black","      Hispanic")
table4diff <- table4 - table4orig
table4perc <- 100*(table4-table4orig)/table4
table4perc <- round(table4perc, 1)
cat("================================================================\n")
cat("TABLE 4. UNEMPLOYMENT RATES OF INDIVIDUALS AGE 16-61\n")
cat("         IN MIAMI AND FOUR COMPARISON CITIES, 1979-85.\n")
cat("================================================================\n")
cat("CALCULATED BY PROGRAM\n")
cat("---------------------\n")
print(table4)
cat("----------------------------------------\n")
cat("ACTUAL DIFFERENCES FROM PUBLISHED VALUES\n")
cat("----------------------------------------\n")
print(table4diff)
cat("-----------------------------------------\n")
cat("PERCENT DIFFERENCES FROM PUBLISHED VALUES\n")
cat("-----------------------------------------\n")
print(table4perc)

plot_table4(mm, "Miami")
plot_table4(oo, "Comparison Cities")

plot_earnwk(mm, "Miami")
plot_earnwk(oo, "Comparison Cities")

plot_uhours(mm, "Miami")
plot_uhours(oo, "Comparison Cities")
