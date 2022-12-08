

##Script name: cleaning.r

##Purpose of script: Cleaning the raw penguin data set by changing column names, removing na's and filtering to the desired columns


#Date Created: 2022-12-08


#Fix column names, remove empty rows, remove columns beginning with delta and comments

cleaning <- function(data_raw){
  data_raw %>%
    clean_names() %>%
    remove_empty(c("rows", "cols")) %>%
    dplyr::select(-starts_with("delta")) %>%
    dplyr::select(-comments)
}


#Subset the data to only include penguins that are not NA for body mass and sex, and reformat wording
  
mass_data_cleaning <- function(data_clean){
  data_clean %>%
    filter(!is.na(body_mass_g))%>%
    filter(!is.na(sex)) %>%
    dplyr::select(species, body_mass_g, sex) %>%
    mutate(sex = ifelse(sex == "MALE", "Male", "Female"))
}
