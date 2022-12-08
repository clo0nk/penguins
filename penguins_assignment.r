##script name: run_penguin_analysis.r

##Purpose of script: loads penguin data, cleans it, plots the body mass of penguins against sex and species, and saves the plot to a file

##Date Created: 2022-12-08

#Initial Setup:

#Set the working directory - where R will look for files and folders
setwd("C:\Users\Chloe Dick\OneDrive - Nexus365\R\ReproducableAssessment")

#Load the libraries from the libraries function from my file
source("functions/libraries.r")

#Load the functions for cleaning the data and plotting from my files
source("functions/cleaning.r")
source("functions/plotting.r")



#Load the data:

penguins_raw <- read.csv("raw_data/penguins_raw.csv")


#Clean the data:

#Fix column names, remove empty rows, remove columns beginning with delta and comments
penguins_clean <- cleaning(penguins_raw)


# Save the clean data with current date in the title
date = Sys.Date() 
filename = paste("clean_data/", date, "_penguins_clean.csv",sep="") # e.g. "clean_data/2022-12-08_penguins_clean.csv"
write.csv(penguins_clean, filename)

#Subset the data to only include penguins that are not NA for body mass and sex, and reformat wording
penguins_mass <- mass_data_cleaning(penguins_clean)

#Save this data we will use for analysis
filename = paste("clean_data/", date, "_penguins_mass.csv",sep="") # e.g. "clean_data/2022-12-08_penguins_mass.csv"
write.csv(penguins_mass, filename)



#Plot the data into a figure:

#Plot the body mass by sex, taking into account species
mass_barchart <- plot_mass_figure(penguins_mass)


#Saving the figure for different purposes

#Save the figure for a report
save_mass_barchart_png(penguins_mass, "figures/fig01_report.png",
size = 15, res = 600, scaling = 1)

#Save the figure for a presentation
save_mass_barchart_png(penguins_mass, "figures/fig01_presentation.png",
                       size = 15, res = 600, scaling = 1.4)

#Save the figure for a poster
save_mass_barchart_png(penguins_mass, "figures/fig01_poster.png",
                       size = 35, res = 600, scaling = 2.8)

#Save the figure as a vector, for screen viewing
save_mass_barchart_svg(penguins_mass, "figures/fig01_vector.svg",
                      size=15, scaling=1)
                      
