# card90

The purpose of this package is to reproduce results from David Card's 1990 paper titled "The Impact of the Mariel Boatlift on the Miami Labor Market" which can be found online at http://davidcard.berkeley.edu/papers/mariel-impact.pdf .  It consists of the programs card90data.R and card90proc.R, both in the R subdirectory.

The program card90data.R will read CPS Merged Outgoing Rotation Group (MORG) files for 1979 through 1985 and create the files card85.txt and card85.csv.  Before running it, the files morg79.dta through morg85.dta must be copied from http://www.nber.org/morg/annual/ to a subdirectory of the working directory named data.  The program will read these files and create the files card85.txt and card85.csv  in the working directory.  The file card85.txt is a space-delimited file required by the program card90proc.R and the file card85.csv is just a comma-separated version supplied for convenience.

The program card90proc.R will then read the file card85.txt in the working directory and use that data to reproduce values from Tables 1, 3, and 4 of Card's paper.  For each table, the program will print out the values as calculated by the program, a table showing the calculated values minus the values from the paper, and then a table showing the percent increase or decrease between the values in the paper and the calculated values.  It will also output plots of the values in Tables 3 and 4 for Miami and the Comparison Cities of Atlanta, Los Angeles, Houston, and Tampa-St. Petersburg.  Finally, it will print out similar information for the weekly wage and usual hours worked for both Miami and the Comparison Cities.

Below is the current output from card90proc.R.  As can be seen, the code reproduced the first 4 lines of Table 1 exactly (except for All which has a known problem that I hope to fix at some point).  The code matched 37 of 49 values within one percent in Table 3 and matched 43 out of 49 values exactly in Table 4.  Following is the output:

```
> source("R/card90proc.R")
===========================================================
TABLE 1. CHARACTERISTICS OF 16-61-YEAR-OLDS IN MIAMI, 1979.
===========================================================
CALCULATED BY PROGRAM
---------------------
                        Whites Blacks Cubans Hispanics   All
Population (1000s)       319.3  244.1  252.4     102.9 918.6
 Mean Education           12.8   11.4   11.0      11.6    NA
 Percent in Labor Force   75.6   68.3   77.2      68.8  73.3
Labor Force (1000s)      241.3  166.6  194.7      70.8 673.4
----------------------------------------
ACTUAL DIFFERENCES FROM PUBLISHED VALUES
----------------------------------------
                        Whites Blacks Cubans Hispanics  All
Population (1000s)           0      0      0         0 -9.8
 Mean Education              0      0      0         0   NA
 Percent in Labor Force      0      0      0         0  0.2
Labor Force (1000s)          0      0      0         0 -4.8
-----------------------------------------
PERCENT DIFFERENCES FROM PUBLISHED VALUES
-----------------------------------------
                        Whites Blacks Cubans Hispanics  All
Population (1000s)           0      0      0         0 -1.1
 Mean Education              0      0      0         0   NA
 Percent in Labor Force      0      0      0         0  0.3
Labor Force (1000s)          0      0      0         0 -0.7
Press enter to continue, escape to exit
================================================================
TABLE 3. LOGARITHMS OF REAL HOURLY EARNINGS OF WORKERS AGE 16-61
         IN MIAMI AND FOUR COMPARISON CITIES, 1979-85.
================================================================
CALCULATED BY PROGRAM
---------------------
               1979 1980 1981 1982 1983 1984 1985
Miami White    1.83 1.84 1.84 1.83 1.83 1.83 1.81
      Black    1.61 1.57 1.62 1.51 1.46 1.60 1.61
      Cuban    1.60 1.54 1.52 1.52 1.50 1.53 1.51
      Hispanic 1.51 1.55 1.55 1.57 1.48 1.58 1.53
Other White    1.93 1.90 1.90 1.92 1.90 1.92 1.93
      Black    1.74 1.69 1.72 1.71 1.70 1.68 1.64
      Hispanic 1.67 1.64 1.62 1.61 1.60 1.61 1.58
----------------------------------------
ACTUAL DIFFERENCES FROM PUBLISHED VALUES
----------------------------------------
                1979  1980  1981 1982  1983  1984  1985
Miami White    -0.02  0.01 -0.01 0.01  0.01  0.01 -0.01
      Black     0.02  0.02  0.01 0.03 -0.02  0.03  0.01
      Cuban     0.02  0.00  0.01 0.03  0.01  0.00  0.02
      Hispanic -0.01  0.01  0.01 0.04  0.00 -0.01 -0.01
Other White     0.00  0.00 -0.01 0.01  0.00  0.01  0.01
      Black     0.00 -0.01  0.00 0.00  0.01  0.01 -0.01
      Hispanic  0.02  0.01  0.01 0.00  0.02  0.01  0.00
-----------------------------------------
PERCENT DIFFERENCES FROM PUBLISHED VALUES
-----------------------------------------
               1979 1980 1981 1982 1983 1984 1985
Miami White    -1.1  0.5 -0.5  0.5  0.5  0.5 -0.6
      Black     1.2  1.3  0.6  2.0 -1.4  1.9  0.6
      Cuban     1.3  0.0  0.7  2.0  0.7  0.0  1.3
      Hispanic -0.7  0.6  0.6  2.5  0.0 -0.6 -0.7
Other White     0.0  0.0 -0.5  0.5  0.0  0.5  0.5
      Black     0.0 -0.6  0.0  0.0  0.6  0.6 -0.6
      Hispanic  1.2  0.6  0.6  0.0  1.3  0.6  0.0
Press enter to continue, escape to exit
Press enter to continue, escape to exit
================================================================
TABLE 4. UNEMPLOYMENT RATES OF INDIVIDUALS AGE 16-61
         IN MIAMI AND FOUR COMPARISON CITIES, 1979-85.
================================================================
CALCULATED BY PROGRAM
---------------------
               1979 1980 1981 1982 1983 1984 1985
Miami White     5.1  2.5  3.9  5.2  6.7  3.6  4.9
      Black     8.3  5.6  9.6 16.0 18.4 14.2  7.8
      Cuban     5.3  7.3 10.1 10.8 13.1  7.7  5.5
      Hispanic  6.5  7.7 11.8  9.1  7.5 12.1  3.7
Other White     4.4  4.4  4.3  6.8  6.9  5.4  4.9
      Black    10.3 12.6 12.6 12.7 18.4 12.1 13.3
      Hispanic  6.1  8.5  8.4 12.1 12.1  9.8  9.2
----------------------------------------
ACTUAL DIFFERENCES FROM PUBLISHED VALUES
----------------------------------------
               1979 1980 1981 1982 1983 1984 1985
Miami White     0.0  0.0  0.0    0  0.0    0  0.0
      Black     0.0  0.0  0.0    0  0.0    0  0.0
      Cuban     0.0  0.1  0.0    0  0.0    0  0.0
      Hispanic  0.0  0.0  0.0    0  0.0    0  0.0
Other White     0.0  0.0  0.0    0  0.0    0  0.0
      Black     0.0  0.0  0.0    0  0.0    0  0.0
      Hispanic -0.2 -0.2  0.1    0  0.3    0 -0.1
-----------------------------------------
PERCENT DIFFERENCES FROM PUBLISHED VALUES
-----------------------------------------
               1979 1980 1981 1982 1983 1984 1985
Miami White     0.0  0.0  0.0    0  0.0    0  0.0
      Black     0.0  0.0  0.0    0  0.0    0  0.0
      Cuban     0.0  1.4  0.0    0  0.0    0  0.0
      Hispanic  0.0  0.0  0.0    0  0.0    0  0.0
Other White     0.0  0.0  0.0    0  0.0    0  0.0
      Black     0.0  0.0  0.0    0  0.0    0  0.0
      Hispanic -3.3 -2.4  1.2    0  2.5    0 -1.1
Press enter to continue, escape to exit
Press enter to continue, escape to exit
Press enter to continue, escape to exit
Press enter to continue, escape to exit
Press enter to continue, escape to exit
Press enter to continue, escape to exit
>
```