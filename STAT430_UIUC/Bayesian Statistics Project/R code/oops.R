library(SportsAnalytics)
data(NBAPlayerStatistics0910)
data <- NBAPlayerStatistics0910
attach(data)
# Calculate response variable
data['PointsPerGame'] <- TotalPoints/GamesPlayed
# Exploratory Analysis
hist(data$PointsPerGame,
     breaks = 1000,
     xlab = 'Points Per Game (PPG)',
     main = 'Distribution of Actual Data for PPG')
# Initialize Division variable
data['Division'] <- 'XD'
# Create Division variable based on Team names
data$Division[data$Team %in% c('TOR','BOS','NYK','NJN','PHI')] <- 'Atlantic'
data$Division[data$Team %in% c('CLE','MIL','CHI','IND','DET')] <- 'Central'
data$Division[data$Team %in% c('ORL','ATL','MIA','CHA','WAS')] <- 'Southeast'
data$Division[data$Team %in% c('DEN','UTA','POR','OKL','MIN')] <- 'Northwest'
data$Division[data$Team %in% c('LAL','PHO','LAC','GSW','SAC')] <- 'Pacific'
data$Division[data$Team %in% c('DAL','SAN','HOU','MEM','NOR')] <- 'Southwest'
data$Division[data$Team == 'NA'] <- 'NA'

# Sort data first by Division then by Team. Only maintain needed columns
data<-data[order(data$Division,data$Team),c('Division','Team','Name','PointsPerGame')]
data<-subset(data,data$Division != 'NA')

# Read cleaned data from csv file
data<-read.csv('data.csv')
data<-read.csv('data.csv')

inputdata<-array(data$PointsPerGame,c(13,5,6))
t(inputdata[,,1])
t(inputdata[,,2])
t(inputdata[,,3])
t(inputdata[,,4])
t(inputdata[,,5])
t(inputdata[,,6])


