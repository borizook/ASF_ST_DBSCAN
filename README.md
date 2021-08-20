# Modified ST-DBSCAN for African swine fever in South Korea
This is the modified version of ST-DBSCAN for African swine fever in wild boars to detect the local transmission clusters.

The research paper for R0 of ASF in South Korea  can be found at following url:

https://www.vetsci.org/DOIx.php?id=10.4142/jvs.2021.22.e71   

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



