require(ggplot2)
source("http://peterhaschke.com/Code/multiplot.R")
train <- read.csv(".\\Raw Data\\train.csv")

plotDigit <- function(row, data = train) {
    label = data[row, 1]
    pixels <- matrix(data[row, -1], nrow = 28, ncol = 28, byrow = TRUE)
    image = data.frame(x = rep(0,784), y = rep(0,784),
                       val = rep(0.0,784),
                       stringsAsFactors = FALSE)
    for(col in seq(ncol(pixels))){
        for(row in seq(nrow(pixels))) {
            p = (row-1)*28 + col
            image[p, 1] = col
            image[p, 2] = 28-row
            image[p, 3] = 1 -(as.numeric(pixels[row, col]) / 255)
        }
    }
    g <- ggplot(image, aes(xmin = x, xmax = x+1, ymin = y, ymax = y+1,
                           col = rgb(val,val,val),
                           fill = rgb(val, val, val)))
    g <- g + geom_rect() + scale_color_identity() + scale_fill_identity()
    g <- g + coord_fixed()
    g <- g + theme(axis.text = element_blank(), axis.ticks = element_blank(),
                   panel.background = element_blank())
    return(g)
    
}

#Plot the averages
avgs <- aggregate(train,list(train$label),FUN = mean)[,-1]
##avgs <- aggregate(train,list(train$label),FUN = median)[,-1]
plots <- list()
for(num in seq(10)) {
    plots[[num]] <- plotDigit(num, avgs)
}
multiplot(plotlist = plots, cols = 5)

#Random forest


