# ID: 111

load("weather2011.rda")

makePlotRegion = function(xlim, ylim, bgcolor, ylabels,
               margins, cityName, xtop = TRUE) {
  # This function is to produce a blank plot that has 
  # the proper axes labels, background color, etc.
  # It is to be used for both the top and bottom plot.
  
  # The parameters are
  # xlim is a two element numeric vector used for the two
  #   end points of the x axis
  # ylim is the same as xlim, but for the y axis
  # ylabels is a numeric vector of labels for "tick marks"
  #   on the y axis
  # We don't need to x labels because they are Month names
  # margins specifies the size of the plot margins (see mar parameter in par)
  # cityName is a character string to use in the title
  # xtop indicates whether the month names are to appear
  # at the top of the plot or the bottom of the plot
  # 
  # See the assignment for a pdf image of the plot that is
  # produced as a result of calling this function.
  
  # Dates
  monthNames = c("January", "February", "March", "April",
                 "May", "June", "July", "August", "September",
                 "October", "November", "December")
  daysInMonth = c(31, 28, 31, 30, 31, 30, 31, 
                  31, 30, 31, 30, 31)
  cumDays = cumsum(c(1, daysInMonth))
  
  # Set background color and margins
  par(bg = bgcolor, mar = margins, bty = 'n', mgp = c(3,1,0))
  
  # Empty plot
  plot(x = NULL, y = NULL, xlim = xlim, ylim =ylim, xaxs = 'i', yaxs ='i', yaxt = "n", xaxt = "n")
  
  # Add title
  title(paste(cityName, "'s Weather in 2011", sep =''),line = 3, 't')
  
  # Add axis at both sides
  axis(
    side = 2,
    at = ylabels,
    tick = TRUE,
    lwd = 3,
    lwd.ticks = 1,
    col = "burlywood3",
    col.ticks = "white",
    las = 1
  )
  axis(
    side = 4,
    at = ylabels,
    tick = TRUE,
    lwd = 3,
    lwd.ticks = 1,
    col = "burlywood3",
    col.ticks = "white",
    las = 1
  )
  
  # Add month names
  # Caculate the position of each month
  month_position <- cumDays[-13]+(30/2)
  # On top
  if(xtop) axis(3, at = month_position, labels = toupper(monthNames), font = 2, line = 0, cex.axis = 0.8, tick = FALSE)
  # On bottom
  else axis(1, at = month_position, labels = toupper(monthNames), font = 2, line = 0, cex.axis = 0.8, tick = FALSE)
}

drawTempRegion = function(day, high, low, col){
  # This plot will produce 365 rectangles, one for each day
  # It will be used for the record temps, normal temps, and 
  # observed temps
  
  # day - a numeric vector of 365 dates
  # high - a numeric vector of 365 high temperatures
  # low - a numeric vector of 365 low temperatures
  # col - color to fill the rectangles
  
  # Draw rectangles
  rect(xleft = day-1, xright = day, ybottom = low, ytop = high, col = col, border = NA)
}

addGrid = function(location, col, ltype, vertical = TRUE) {
  # This function adds a set of parallel grid lines
  # It will be used to place vertical and horizontal lines
  # on both temp and precip plots
  
  # location is a numeric vector of locations for the lines
  # col - the color to make the lines
  # ltype - the type of line to make
  # vertical - indicates whether the lines are vertical or horizontal
  if (vertical){
    abline(v = location, lty = ltype, col = col)}
  else if (!vertical){
    abline(h = location, lty = ltype, col = col)}
}

monthPrecip = function(day, dailyprecip, normal){
  # This function adds one month's precipitation to the 
  #   precipitation plot.
  # It will be called 12 times, once for each month
  # It creates the cumulative precipitation curve,
  # fills the area below with color, add the total
  # precipitation for the month, and adds a reference
  # line and text for the normal value for the month
  
  # day a numeric vector of dates for the month
  # dailyprecip a numeric vector of precipitation recorded
  # for the month (any NAs can be set to 0)
  # normal a single value, which is the normal total precip
  #  for the month
  
  
  # If the value is NA, change it to zero
  dailyprecip[is.na(dailyprecip)]<-0
  
  # Actual precipitation
  points(x = day, y = dailyprecip, col = "darkblue", type = "l", lwd = 4)
  # Shade the area under actual precipitation curve
  polygon(x = c(day, max(day), day[1]), y = c(dailyprecip, 0, 0), col = "lemonchiffon3", border = NA)
  # Normal precipitation
  points(x =c(day[1], max(day)), y = rep(normal,2), col = 'grey34', type = "l", lwd = 2)
}

finalPlot = function(temp, precip){
  # The purpose of this function is to create the whole plot
  # Include here all of the set up that you need for
  # calling each of the above functions.
  # temp is the data frame sfoWeather or laxWeather
  # precip is the data frame sfoMonthlyPrecip or laxMonthlyPrecip

  
  # Here are some vectors that you might find handy
  
  monthNames = c("January", "February", "March", "April",
               "May", "June", "July", "August", "September",
               "October", "November", "December")
  daysInMonth = c(31, 28, 31, 30, 31, 30, 31, 
                  31, 30, 31, 30, 31)
  cumDays = cumsum(c(1, daysInMonth))
  
  normPrecip = as.numeric(as.character(precip$normal))
  ### Fill in the various stages with your code
 
  
  ### Add any additional variables that you will need here
  
  
  ### Set up the graphics device to plot to pdf and layout
  ### the two plots on one canvas
  ### pdf("", width = , height = )
  ### layout(  )
  pdf("HW9_490IDS_111.pdf", width = 13, height = 16)
  layout(matrix(c(1,2), nrow = 2, ncol = 1, byrow = TRUE), height = c(3,2))
  
  ### Call makePlotRegion to create the plotting region
  ### for the temperature plot
  makePlotRegion(
    xlim = c(1, 365),
    ylim = c(0, 110),
    bgcolor = 'grey89',
    ylabels = seq(0, 110, by = 10),
    margins = c(0, 3, 5, 4),
    cityName = 'Los Angeles',
    xtop = TRUE
  )
  
  
  ### Call drawTempRegion 3 times to add the rectangles for
  ### the record, normal, and observed temps
  
  # Attach data
  attach(laxWeather)
  
  # Draw record temperatures
  drawTempRegion(c(1:365), RecordHigh, RecordLow, col = "lemonchiffon3")
  # Draw Normal temperatures
  drawTempRegion(c(1:365), NormalHigh, NormalLow, col = "grey65")
  # Draw observed temperatures
  drawTempRegion(c(1:365), High, Low, col = "darkred")
  
  
  
  ### Call addGrid to add the grid lines to the plot
  
  # Add vertical grid lines
  addGrid(cumDays,'grey', 5, TRUE)
  # Add vertical horizontal lines
  addGrid(seq(10, 110, by = 10), "cornsilk", 1, FALSE)
  
  ### Add the markers for the record breaking days
  
  # Add top-left description
  text(x=25, y = 106, labels = "Temperature", cex = 1.1, col = "black", font=2)
  text(x=46, y = 101, labels = "Bars represent range between the daily high and low.", cex = 0.6, col = "black")
  text(x=45, y = 98, labels = "Average daily low temperature for the year was 55.03бу,", cex = 0.6, col = "black")
  text(x=34.5, y = 95, labels = "and the average daily high was 68.5бу.", cex = 0.6, col = "black")

  # Add legend
  rect(xleft=(364/2)-2, xright=(364/2)+2, ytop = 30, ybottom = 10, col="lemonchiffon3",border=NA)
  rect(xleft=(364/2)-2, xright=(364/2)+2 ,ytop = 25, ybottom = 15, col="gray65",border=NA)
  rect(xleft=(364/2)-2, xright=(364/2),ytop = 28, ybottom = 18, col="darkred",border=NA)
  
  
  text(x=(364/2)-9, y = 30, labels = "RECORD HIGH", cex = 0.4, col = "black")
  text(x=(364/2)-9, y = 11, labels = "RECORD LOW", cex = 0.4, col = "black")
  text(x=(364/2)-11, y = 21, labels = "NORMAL RANGE", cex = 0.4, col = "black")
  text(x=(364/2)+9, y = 28, labels = "ACTUAL HIGH", cex = 0.4, col = "black")
  text(x=(364/2)+9, y = 20, labels = "ACTUAL LOW", cex = 0.4, col = "black")
  
  # Point out special days
  
  # Tied high record
  segments(x0 = 67.5, y0 = High[68], y1 = High[68]+25,col="black",lty=1,lwd=2)
  text(x=80, y = 106, labels = "TIED RECORD HIGH: 81бу", cex = 0.4, col = "black")
  
  # Tied low records
  segments(x0 = 278.5, y0 = Low[279], y1 = Low[279]-29,col="black",lty=1,lwd=2)
  text(x=267, y = 24, labels = "TIED RECORD LOW: 52бу", cex = 0.4, col = "black")
  
  segments(x0 = 279.5, y0 = Low[280], y1 = Low[280]-19,col="black",lty=1,lwd=2)
  text(x=292, y = 35, labels = "TIED RECORD LOW: 53бу", cex = 0.4, col = "black")
  
  ### Add the titles 
  
  
  
  ### Call makePlotRegion to create the plotting region
  ### for the precipitation plot
  makePlotRegion(
    xlim = c(1, 365),
    ylim = c(0, 8),
    bgcolor = "grey89",
    ylabels = seq(0, 6, by = 1),
    margins = c(2, 2, 0, 2),
    cityName = "",
    xtop = FALSE
  )
  
  ### Call monthPrecip 12 times to create each months 
  ### cumulative precipitation plot. To do this use 
  ### sapply(1:12, function(m) {
  ###             code
  ###             monthPrecip(XXXX)
  ###             }) 
  ### the anonymous function calls monthPrecip with the 
  ### appropriate arguments
  sapply(1:12, function(m){
    monthPrecip(day = cumDays[m]+laxWeather$Day[Month==m], dailyprecip = cumsum(laxWeather$Precip[Month==m]),
                normal = normPrecip[m])
  })

  ### Call addGrid to add the grid lines to the plot
  addGrid(location = seq(1, 6, by = 1), col = "white", ltype = "solid", vertical = FALSE)
  segments(x0 = c(cumsum(c(1+31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31))), y0 = 0, y1 = 6,
           col = "grey", lty="dotted")
  
  
  ### Add the titles
  text(x=30, y = 6.5, labels="Precipitation", cex= 1.1, font=2, pos=3)
  text(x=180, y = 6.5, labels="Cumulative monthly precipitation in inches compared with normal monthly precipitation. Total precipitation in LA was 9.87 inches.", cex= .8, pos=3)
  
  # Add text
  text(x=10, y = 3.3, labels="NORMAL", cex= .8, font = 3)
  text(x=13, y = 0.8, labels="ACTUAL", cex= .8)
  
  # Add text for normal precipitation values
  text(x=7, y = 2.9, labels="2.98", cex= .8, pos = 3)
  text(x=38, y = 3.2, labels="3.11", cex= .8)
  text(x=66, y = 2.51, labels="2.4", cex= .8)
  text(x=97, y = 0.74, labels="0.63", cex= .8)
  text(x=127, y = 0.35, labels="0.24", cex= .8)
  text(x=158, y = 0.2, labels="0.08", cex= .8)
  text(x=188, y = 0.14, labels="0.03", cex= .8)
  text(x=219, y = 0.16, labels="0.05", cex= .8)
  text(x=250, y = 0.32, labels="0.21", cex= .8)
  text(x=280, y = 0.67, labels="0.56", cex= .8)
  text(x=311, y = 1.22, labels="1.11", cex= .8)
  text(x=341, y = 2.16, labels="2.05", cex= .8)
  
  # Add text for actual precipitation values
  text(x=31, y = 0.8, labels="0.81", cex= .8, pos = 2)
  text(x=60, y = 1.48, labels="1.47", cex= .8, pos = 2)
  text(x=88, y = 4.05, labels="4.04", cex= .8, pos = 2)
  text(x=121.5, y = 0.08, labels="0", cex= .8, pos = 2)
  text(x=152, y = 0.62, labels="0.53", cex= .8, pos = 2)
  text(x=182, y = 0.2, labels="0.02", cex= .8, pos = 2)
  text(x=212, y = 0.14, labels="0", cex= .8, pos = 2)
  text(x=243, y = 0.14, labels="0", cex= .8, pos = 2)
  text(x=274, y = 0.13, labels="0.01", cex= .8, pos = 2)
  text(x=305, y = 0.72, labels="0.63", cex= .8, pos = 2)
  text(x=335, y = 1.8, labels="1.69", cex= .8, pos = 2)
  text(x=365, y = 0.8, labels="0.67", cex= .8, pos = 2)

  ### Close the pdf device dev.off()
  dev.off()
}

### Call: finalPlot(temp = sfoWeather, precip = sfoMonthlyPrecip)

finalPlot(temp = laxWeather, precip = laxMonthlyPrecip)
