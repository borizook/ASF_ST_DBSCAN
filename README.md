# Modified ST-DBSCAN for African swine fever in South Korea
This is the modified version of ST-DBSCAN for African swine fever in wild boars to detect the local transmission clusters.

Original version of ST-DBSCAN can be found at following url:
https://github.com/Kersauson/ST-DBSCAN/blob/master/stdbscan.R

## INPUTS :
 x = longitude                                                                    
 y = latitude                                                                     
 death_time = estimated death date                                                
 report_time = reported date                                                      
 day_buf_death = temporal buffer adding to the death date                         
 day_buf_report = temporal buffer adding to the report date                       
 eps = geographical distance threshold                                            
 max_viab = maximum duration of transmission viability of ASFV                    
 minpts = number of points to consider a cluster                       

## OUTPUTS :
 data$cluster = cluster number
 data$cldensity = cluster points density



