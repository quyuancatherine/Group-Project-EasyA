# BuildMap file: function that returns a plotly scatter plt.
library(plotly)
library(stringr)

# BuilPlot returns a scatter plot using the my.data as the source, yplot.var as the variable for the y axis and splot.var for the size of the marker.

BuildPlot <- function(my.data, c.var, y.var) {
  
  # Make equation for scatter plot values and marker sizes
  cvar.equation <- paste0('~', c.var)
  yvar.equation <- paste0('~', y.var)
  
  # eval(parse(text = svar.equation))
  # Scatter plot
  
  
  
  return(plot_ly(my.data, type = 'scatter'))
}