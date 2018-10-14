# PEQUEÑO EJERCICIO CON FECHAS
#

library(lubridate)

day1_2018 <- as.Date("2018-1-1")
day365_2018 <- as.Date("2018-12-31")

# un Vector de fechas con todas las fechas del año
days_of_2018 <- seq(day1_2018, day365_2018 , by = "days")

# obtengamos el día de hoy
today <- as.Date(now())

# cuántos días han pasado desde el inicio de año y cuantos faltan para terminar
days_from_jan1th <- today - day1_2018 
days_to_dec31th <- day365_2018 - today

# meses hasta terminar el año
months_to_end_year = month(day365_2018) - month(today)

sprintf("Today is: %s, the day %d from the start of the year", today, days_from_jan1th)   
sprintf("Still %d days to end up 2018, and %d months", days_to_dec31th, months_to_end_year)  





