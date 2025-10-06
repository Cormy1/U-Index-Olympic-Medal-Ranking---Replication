#function to carry out ranking based on U-index as described by Duncan and Parece
rank_dp <- function(medalcounts,
                    dp_quotas,
                    games
){
  
  medalcounts <- read.csv(medalcounts)
  dp_quotas <- read.csv(dp_quotas) %>% filter(games == games)
  m <- as.numeric(dp_quotas$quota_medals[1])
  medals <- as.numeric(dp_quotas$medals[1])
  
  country_data <- medalcounts %>%  #can remove next step when processed data has been split out by games
    filter(competed == TRUE,
           Medals.total>0)
  
  
  
  country_data%>% mutate(
    M = m, 
    S = sum(total_pop_july),  #Total pop of medal winning countries: S
    Tot.M = medals, 
    Exp.N = (total_pop_july/S)*Tot.M,
    p = (Exp.N / M)  
  )%>%
    mutate(prob = pbinom(Medals.total - 1, # observed corrected
                         size = M, #number of trials
                         p,   
                         lower.tail = FALSE),
           u_index = - log10(prob)) %>%
    mutate(rank_dp = rank(-u_index, ties.method = "first", na.last = "keep"))%>%
    select(slug_game, iso_a3, u_index, rank_dp)
  
}

