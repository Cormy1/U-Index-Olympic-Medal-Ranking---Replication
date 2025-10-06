
library(targets)
library(tarchetypes)


tar_option_set(
  packages = c("tidyverse", "tibble") # Packages that your targets need for their tasks.
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()

games <- c("paris-2024", "tokyo-2020", "rio-2016", "london-2012", "beijing-2008", "athens-2004")

list(
  tar_target(name = dp_quotas,
             command = "0_data/0_raw/dp_quotas.csv",
             format = "file",
             description = "Medal counts for DP model at Olympic Games 2004 - 2024"
  ),
  tar_map(
    
    values = tibble::tibble(games = games), # iterating the ranking algorithm over each games
    
  tar_target(
    name = medalcounts,
    command =  paste0("0_data/0_raw/Medalcounts_", games, ".csv"),,
    format = "file", 
    description = "Processed medal counts for Paris 2024 Olympic Games"
  ), 
  tar_target(
    name = ranks_dp, 
    command = rank_dp(medalcounts,
                      dp_quotas,
                      games = games),
    description = "Implements Duncan and Parece U-index ranking regime for Olympic Games 2024"
  ),
  tar_target(
    name= export_results.2024,
    command = {
      output_file = paste0("0_data/1_output/UIndexRanking_", games, ".csv")
      write.csv(ranks_dp, output_file)
      output_file
    },
    format = "file",
    description = "Outputing results into csv file for back up"
  )
  )#tar_map
)
