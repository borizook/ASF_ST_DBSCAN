stdbscan_asf = function (x, 
                         y, 
                         death_time,
                         report_time, 
                         day_buf_death,
                         day_buf_report,
                         eps, 
                         max_viab,
                         minpts, 
                         cldensity = TRUE) { 
  
  countmode = 1:length(x)
  seeds = TRUE
  data_spatial<- as.matrix(dist(cbind(y, x)))
  pre_trans_time <- as.Date(death_time) - day_buf_death
  post_trans_time <- as.Date(report_time) + day_buf_report
  
  n <- nrow(data_spatial)
  
  classn <- cv <- integer(n)
  isseed <- logical(n)
  cn <- integer(1)
  
  for (i in 1:n) {
    
    if (i %in% countmode)
      #cat("Processing point ", i, " of ", n, ".\n")
      unclass <- (1:n)[cv < 1]
    
    if (cv[i] == 0) {
      spatial_reachables<- unclass[data_spatial[i, unclass] <= eps]
      duration_infect = ifelse(as.numeric(as.Date(post_trans_time[i]) - as.Date(pre_trans_time[i])) > max_viab, max_viab, as.Date(post_trans_time[i]) - as.Date(pre_trans_time[i]))
      new_post_trans_time = as.Date(as.Date(pre_trans_time[i]) + duration_infect)
      reachables <- spatial_reachables[as.Date(death_time[spatial_reachables]) %in% c(as.Date(pre_trans_time[i]):as.Date(new_post_trans_time))]
      if (length(reachables) + classn[i] < minpts)
        cv[i] <- (-1)
      else {
        cn <- cn + 1                   
        cv[i] <- cn
        isseed[i] <- TRUE
        reachables <- setdiff(reachables, i)
        unclass <- setdiff(unclass, i)       
        classn[reachables] <- classn[reachables] + 1
        while (length(reachables)) {
          cv[reachables] <- cn           
          ap <- reachables                           
          reachables <- integer()
          
          for (i2 in seq(along = ap)) {
            j <- ap[i2]
            
            jspatial_reachables<- unclass[data_spatial[j, unclass] <= eps]
            
            jduration_infect = ifelse(as.numeric(as.Date(post_trans_time[j]) - as.Date(pre_trans_time[j])) > max_viab, max_viab, as.Date(post_trans_time[j]) - as.Date(pre_trans_time[j]))
            jnew_post_trans_time = as.Date(as.Date(pre_trans_time[j]) + jduration_infect)
            jreachables <- jspatial_reachables[as.Date(death_time[jspatial_reachables]) %in% c(as.Date(pre_trans_time[j]):as.Date(jnew_post_trans_time))]
            if (length(jreachables) + classn[j] >= minpts) {
              isseed[j] <- TRUE
              cv[jreachables[cv[jreachables] < 0]] <- cn
              reachables <- union(reachables, jreachables[cv[jreachables] == 0])
            }
            classn[jreachables] <- classn[jreachables] + 1
            unclass <- setdiff(unclass, j)
          }
        }
      }
    }
    if (!length(unclass))
      break
    
  }
  
  
  if (any(cv == (-1))) {
    cv[cv == (-1)] <- 0
  }
  out <- list(cluster = cv, eps = eps, minpts = minpts, density = classn)
  rm(classn)
  if (seeds && cn > 0) {
    out$isseed <- isseed
  }
  class(out) <- "modified_stdbscan"
  return(out)
}


