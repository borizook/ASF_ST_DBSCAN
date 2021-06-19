Modified ST-DBSCAN for ASF


Birant, D., & Kut, A. (2007). ST-DBSCAN: An algorithm for clustering spatial–temporal data. Data & Knowledge Engineering, 60(1), 208-221.

INPUTS :
# traj = traj gps (x, y and time)                                      #
# death_time = estimated death date                                    #
# report_time = reported date                                          #
# day_buf_death = temporal buffer adding to the death date             #
# day_buf_report = temporal buffer adding to the report date           #
# eps = geographical distance threshold                                #
# max_viab = maximum duration of transmission viability of ASFV        #
# minpts = number of points to consider a cluster                      #

OUTPUTS :
data$cluster = cluster number
data$cldensity = cluster points density
