library(dplyr)
library(readr)
library(animation)
library(ggplot2)
#### NOTE: Requires ImageMagick to be installed on

# Inspect structure of japan
japan <- read_tsv('https://assets.datacamp.com/production/course_862/datasets/japanPOP.txt')
str(japan)

saveGIF({

    for(i in unique(japan$time)){
      data = subset(japan, time==i)
      
      #Run ggplot command
      p <- ggplot(data, aes(x=AGE, y = POP, fill=SEX)) +
        coord_flip() + 
        geom_bar(data = data[data$SEX == "Female",], stat = "identity") +
        geom_bar(data = data[data$SEX == "Male",], stat = "identity") +
        ggtitle(i)
      
      print(p)
    }
    }, movie.name = "./Viz/pyramid.gif", interval = 0.1)



################ Similar Animated Viz for India US Forex Rates - 1973 - 2018 ###############
india_us_forex <- read.csv('./Datasets/AEXINUS.csv')

saveGIF({
  for (year in unique(india_us_forex$DATE)){
    
    
    
    data_yearly <- subset(india_us_forex, DATE==year)
    
    p_forex <- ggplot(data_yearly, aes(x=DATE, y=AEXINUS)) +
      geom_point(size=5.47, color="maroon") +
      
      ylim(1,100) +ggtitle(paste0("Forex Rate In ", year))
    
    print(p_forex)
    
}}, movie.name = "./Viz/india_us_forex_TS.gif", interval = 0.5)

################ Similar Animated Line Chart Viz for India US Forex Rates - 1973 - 2018 ###############
ggplot(india_us_forex, aes(DATE, AEXINUS)) + geom_line(group=1, color="green")+ 
  theme(axis.text.x  = element_text(angle = 90, hjust = 1))

india_us_forex$DATE <- as.Date(india_us_forex$DATE)

saveGIF({
  for (year in unique(india_us_forex$DATE)){
    
    #data_yearly <- subset(india_us_forex, DATE<=year)
    data_yearly <- india_us_forex %>% filter(DATE<=year)
    
    p_forex_lc <-ggplot(data_yearly, aes(DATE, AEXINUS)) + geom_line(group=1, color="maroon", size=1)+ 
      theme(axis.text.x  = element_text(angle = 90, hjust = 1)) + 
      ylim(1,100) + xlim(as.Date('1970-01-01') , as.Date('2020-01-01'))+
      ggtitle("A look at India-US Forex Rates between 1973 and 2018")+
      xlab("Year") + ylab("India US Forex Rate")
    
    print(p_forex_lc)
    
  }}, movie.name = "./Viz/india_us_forex_TS_LineChart.gif", interval = 0.2)




