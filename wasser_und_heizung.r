#!/usr/bin/Rscript

library(DBI)
library(RSQLite)

lz <- format(Sys.Date(), "%d. %B %Y")

con = dbConnect(SQLite(), dbname = "haushalt.db")
myQuery <- dbSendQuery(con, "SELECT * FROM wasser_und_heizung")

myData <- dbFetch(myQuery, n = -1)

warmwasser <- diff(unlist(myData$warmwasser))
kaltwasser <- diff(unlist(myData$kaltwasser))
heizung <- diff(unlist(myData$heizung))
datum <- unlist(myData$datum)

plot(main=paste("Wasser und Heizung", lz), x=warmwasser, type="l", xlab="Warmwasser", srt=60, xaxt="n", las=2, panel.first=grid(), col=c("red"))
axis(1, at=seq(warmwasser), labels=datum, las=2, mgp=c(5, .7, 0), cex.axis=0.4)

plot(x=kaltwasser, type="l", xlab="Kaltwasser", srt=60, xaxt="n", las=2, panel.first=grid(), col=c("blue"))
axis(1, at=seq(kaltwasser), labels=datum, las=2, mgp=c(5, .7, 0), cex.axis=0.4)

plot(x=heizung, type="l", xlab="Heizung", srt=60, xaxt="n", las=2, panel.first=grid(), col=c("green"))
axis(1, at=seq(heizung), labels=datum, las=2, mgp=c(5, .7, 0), cex.axis=0.4)

grid()
