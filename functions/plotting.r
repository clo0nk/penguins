##Script name: Plotting.r


##Purpose of script: Functions for making bar chart of the body mass data, and then saving to svg and png


##Date Created: 2022-12-08



#Plot the body mass by sex, taking into account species

plot_mass_figure <- function(penguins_mass){
  penguins_mass %>%
    group_by(sex, species) %>%
    summarise(mean=mean(body_mass_g), se=std.error(body_mass_g))%>%
    #to plot the columns:
    ggplot(aes(x=species, y=mean, fill=sex))+ #plot species as x axis, and mean body mass y axis, with different columns for each sex
    geom_col(position=position_dodge(), colour='black')+ #dodges the columns so they are side-to-side on the x axis, instead of stacked atop one another, and outline them in black
    scale_fill_manual(values = c('#88CCEE', '#DDCC77'))+ #colouring according to the 'Safe' colourblind friendly palette
    scale_x_discrete(labels = c("Adelie", "Chinstrap", "Gentoo"))+ #changing the x-axis labels to make them readable
    labs(x= "Penguin Species",
         y= "Mean Body Mass (g)")+
    #to plot the points:
    geom_jitter(data=penguins_mass, aes( x=species, y=body_mass_g, group=sex, colour=sex), position = position_jitterdodge(jitter.width=0.3, dodge.width=0.9, seed=0), alpha = 0.3, show.legend = FALSE)+ #plotting raw data points for body mass grouped by sex, dodging so they are plotted in the middle of each column, and jittering to make more readable
    scale_color_manual(values=c("#117733", "#CC6677"))+ #colouring according to the 'Safe' colourblind friendly palette
    #to plot the error bar
    geom_errorbar(aes(ymin=mean-2*se, ymax=mean+2*se), width=0.2, linewidth = 0.9, position=position_dodge(width=0.9)) + #plotting errorbars to be the mean +/- 2 * standard error, specifying width to make error bars narrower,and dodging so they retain vertical position but are plotted in middle of each column
    theme_bw()
}


#Save the plot as a svg and define the size and scaling
save_mass_barchart_svg <- function(penguins_mass,
                                   filename, size, res, scaling){
  size_inches = size/2.54
  svglite(filename, width = size_inches,
          height = size_inches,
          scaling = scaling)
  mass_barchart <- plot_mass_figure(penguins_mass)
  print(mass_barchart)
  dev.off()
}


#Save the plot as a png and define the size, resolution, and scaling
save_mass_barchart_png <- function(penguins_mass, filename, size, res, scaling){
  agg_png(filename, width = size, 
          height = size, 
          units = "cm", 
          res = res, 
          scaling = scaling)
  mass_barchart <- plot_mass_figure(penguins_mass)
  print(mass_barchart)
  dev.off()
}


