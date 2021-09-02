
<!-- rnb-text-begin -->

---
title: "What explains U.S. Covid-19 Vaccination Rates? Data Appendix"
author: "Rex W. Douglass"
output:  html_notebook
bibliography: WhatExplainsUSCovid19VaccinationRates.bib
---

# Libray Loads


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5mcm9tc2NyYXRjaD1GXG5cbmtuaXRyOjpvcHRzX2NodW5rJHNldChmaWcud2lkdGggPSA4LCBmaWcuaGVpZ2h0ID0gOCwgbWVzc2FnZT1GLCB3YXJuaW5nPUYsIGVjaG89RiwgcmVzdWx0cz1GKVxuXG4jTGlicmFyeSBMb2Fkc1xubGlicmFyeShwYWNtYW4pXG5wX2xvYWQodGlkeXZlcnNlKVxucF9sb2FkKGphbml0b3IpXG5wX2xvYWQodGlkeWxvZylcbnBfbG9hZChzdHJpbmdyKVxucF9sb2FkKGdnZGFnKVxucF9sb2FkKGRhdGEudGFibGUpXG5wX2xvYWQoc2YpXG5wX2xvYWQoZ2x1ZSlcbnBfbG9hZChzY2FsZXMpXG5vcHRpb25zKHRpZ3Jpc191c2VfY2FjaGUgPSBUUlVFKVxuXG5cbnJlc3RhcnRzcGFyayA8LSBmdW5jdGlvbigpe1xuICAjZGV2dG9vbHM6Omluc3RhbGxfZ2l0aHViKFxccnN0dWRpby9zcGFya2x5clxcKVxuICAjZGV2dG9vbHM6Omluc3RhbGxfZ2l0aHViKFxccnN0dWRpby9zcGFya2x5clxcKVxuICAjaW5zdGFsbC5wYWNrYWdlcygnc3BhcmtseXInKSAjcm9sbGluZyBiYWNrIHRvIHRoZSBzdGFibGUgdmVyc2lvblxuICBsaWJyYXJ5KHNwYXJrbHlyKVxuICAjc3BhcmtfYXZhaWxhYmxlX3ZlcnNpb25zKClcbiAgI3NwYXJrX2luc3RhbGxlZF92ZXJzaW9ucygpXG4gICNzcGFya191bmluc3RhbGwodmVyc2lvbj1cXDMuMC4xXFwsIGhhZG9vcF92ZXJzaW9uPVxcMy4yXFwpXG4gICNzcGFya191bmluc3RhbGwodmVyc2lvbj1cXDIuNC4zXFwsIGhhZG9vcF92ZXJzaW9uPVxcMi43XFwpXG4gICNvaCBpbnRlcmVzdGluZyB0aGUgZGVmYXVsdCBpcyBzcGFyayAyLjQuMyBJIHdvbmRlciB3aHkgdGhhdCBpc1xuICAjRXJyb3I6IEphdmEgMTEgaXMgb25seSBzdXBwb3J0ZWQgZm9yIFNwYXJrIDMuMC4wK1xuICAjc3BhcmtfaW5zdGFsbChcXDMuMFxcKSAjMy4xLjEgaXMgY3VycmVudGx5IHRoZSBsYXRlc3Qgc3RhYmxlLCBidXQgMy4wIGlzIHRoZSBsYXRlc3QgYXZhaWxhYmxlXG5cbiAgI2xpYnJhcnkoZ2Vvc3BhcmspXG4gICNsaWJyYXJ5KGFycm93KVxuICBtZW09XFwxNjBHXFxcbiAgdHJ5KHtzcGFya19kaXNjb25uZWN0KHNjKX0pXG4gIGNvbmYgPC0gc3BhcmtfY29uZmlnKClcbiAgI2NvbmYkYHNwYXJrbHlyLmNvcmVzLmxvY2FsYCA8LSAxMjhcbiAgI2h0dHBzOi8vZGF0YXN5c3RlbXNsYWIuZ2l0aHViLmlvL0dlb1NwYXJrL2FwaS9zcWwvR2VvU3BhcmtTUUwtUGFyYW1ldGVyL1xuICBjb25mJHNwYXJrLnNlcmlhbGl6ZXIgPC0gXFxvcmcuYXBhY2hlLnNwYXJrLnNlcmlhbGl6ZXIuS3J5b1NlcmlhbGl6ZXJcXFxuICAjY29uZiRzcGFyay5rcnlvLnJlZ2lzdHJhdG9yIDwtIFxcb3JnLmRhdGFzeXNsYWIuZ2Vvc3Bhcmsuc2VyZGUuR2VvU3BhcmtLcnlvUmVnaXN0cmF0b3JcXFxuICAjY29uZiRzcGFyay5rcnlvc2VyaWFsaXplci5idWZmZXIubWF4IDwtIFxcMjA0N01CXFwgI0NhdXNlZCBieTogamF2YS5sYW5nLklsbGVnYWxBcmd1bWVudEV4Y2VwdGlvbjogc3Bhcmsua3J5b3NlcmlhbGl6ZXIuYnVmZmVyLm1heCBtdXN0IGJlIGxlc3MgdGhhbiAyMDQ4IG1iLCBnb3Q6ICsgMTAyNDAgbWIuXG4gICNodHRwczovL2dpdGh1Yi5jb20vRGF0YVN5c3RlbXNMYWIvR2VvU3BhcmsvaXNzdWVzLzIxN1xuICAjY29uZiRnZW9zcGFyay5nbG9iYWwuaW5kZXggPC0gXFx0cnVlXFxcbiAgI2NvbmYkZ2Vvc3BhcmsuZ2xvYmFsLmluZGV4dHlwZSA8LSBcXHF1YWR0cmVlXFxcbiAgI2NvbmYkZ2Vvc3Bhcmsuam9pbi5ncmlkdHlwZSA8LSBcXGtkYnRyZWVcXFxuICAjY29uZiRzcGFyay5zcWwuc2h1ZmZsZS5wYXJ0aXRpb25zIDwtIDE5OTkgI2h0dHBzOi8vZ2l0aHViLmNvbS9EYXRhU3lzdGVtc0xhYi9HZW9TcGFyay9pc3N1ZXMvMzYxICNzZXR0aW5nIHRvIGp1c3QgdW5kZXIgMmsgc28gY29tcHJlc3Npb24gZG9lc24ndCBraWNrIGluLCBkb24ndCBuZWVkIHRvIGxvd2VyIHRoZSBtZW1vcnkgZm9vdHByaW50XG4gIGNvbmYkc3BhcmsuZHJpdmVyLm1heFJlc3VsdFNpemUgPC0gXFwxMDBHXFxcbiAgY29uZiRzcGFyay5tZW1vcnkuZnJhY3Rpb24gPC0gMC45XG4gIGNvbmYkc3Bhcmsuc3RvcmFnZS5ibG9ja01hbmFnZXJTbGF2ZVRpbWVvdXRNcyA8LVxcNjAwMDAwMHNcXCAjRmFpbGVkIGR1cmluZyBpbml0aWFsaXplX2Nvbm5lY3Rpb246IGphdmEubGFuZy5JbGxlZ2FsQXJndW1lbnRFeGNlcHRpb246IHJlcXVpcmVtZW50IGZhaWxlZDogc3BhcmsuZXhlY3V0b3IuaGVhcnRiZWF0SW50ZXJ2YWwgc2hvdWxkIGJlIGxlc3MgdGhhbiBvciBlcXVhbCB0byBzcGFyay5zdG9yYWdlLmJsb2NrTWFuYWdlclNsYXZlVGltZW91dE1zXG4gIGNvbmYkc3BhcmsuZXhlY3V0b3IuaGVhcnRiZWF0SW50ZXJ2YWwgPC1cXDYwMDAwMDBzXFwjIFxcMTAwMDAwMDBzXFxcbiAgY29uZiRzcGFyay5uZXR3b3JrLnRpbWVvdXQgPC0gXFw2MDAwMDAxc1xcXG4gIGNvbmYkc3BhcmsubG9jYWwuZGlyIDwtIFxcL21udC84dGJfYi9zcGFya190ZW1wL1xcXG4gIGNvbmYkc3Bhcmsud29ya2VyLmNsZWFudXAuZW5hYmxlZCA8LSBcXHRydWVcXFxuICBjb25mJFxcc3BhcmtseXIuc2hlbGwuZHJpdmVyLW1lbW9yeVxcPSBtZW1cbiAgY29uZiQnc3BhcmsuZHJpdmVyLm1heFJlc3VsdFNpemUnIDwtIDAgIzAgaXMgdWxpbW1pdGVkXG4gIFxuICBjb25mJCdzcGFyay5zcWwubGVnYWN5LnBhcnF1ZXQuZGF0ZXRpbWVSZWJhc2VNb2RlSW5SZWFkJyA8LSAnTEVHQUNZJ1xuICBjb25mJCdzcGFyay5zcWwubGVnYWN5LnBhcnF1ZXQuZGF0ZXRpbWVSZWJhc2VNb2RlSW5Xcml0ZScgPC0gJ0xFR0FDWSdcbiAgXG4gIGNvbmYkJ3NwYXJrLnNxbC5leGVjdXRpb24uYXJyb3cubWF4UmVjb3Jkc1BlckJhdGNoJyA8LSBcXDUwMDAwMDBcXCAjaHR0cHM6Ly9naXRodWIuY29tL2FyY3Rlcm4taW8vYXJjdGVybi9pc3N1ZXMvMzk5XG4gIFxuICAjRXJyb3I6IG9yZy5hcGFjaGUuc3Bhcmsuc3FsLkFuYWx5c2lzRXhjZXB0aW9uOiBUaGUgcGl2b3QgY29sdW1uIHZhcmlhYmxlX2NsZWFuIGhhcyBtb3JlIHRoYW4gMTAwMDAgZGlzdGluY3QgdmFsdWVzLCB0aGlzIGNvdWxkIGluZGljYXRlIGFuIGVycm9yLiBJZiB0aGlzIHdhcyBpbnRlbmRlZCwgc2V0IHNwYXJrLnNxbC5waXZvdE1heFZhbHVlcyB0byBhdCBsZWFzdCB0aGUgbnVtYmVyIG9mIGRpc3RpbmN0IHZhbHVlcyBvZiB0aGUgcGl2b3QgY29sdW1uLjtcbiAgY29uZiQnc3Bhcmsuc3FsLnBpdm90TWF4VmFsdWVzJyA8LSBcXDUwMDAwMDBcXFxuICBcbiAgc2MgPDwtIHNwYXJrX2Nvbm5lY3QobWFzdGVyID0gXFxsb2NhbFxcLCBjb25maWcgPSBjb25mIyxcbiAgICAgICAgICAgICAgICAgICAgICAjdmVyc2lvbiA9IFxcMi4zLjNcXCAjZm9yIGdlb3NwYXJrXG4gICkgXG59XG5cbnJlc3RhcnRzcGFyaygpXG5cblxucmV4X2NsZWFuIDwtIGZ1bmN0aW9uKHgpe1xuICBpZighXFx2YXJpYWJsZV9zaG9ydFxcICVpbiUgY29sbmFtZXMoeCkpIHt4JHZhcmlhYmxlX3Nob3J0IDwtIE5BfVxuICBpZighXFx2YXJpYWJsZV9zaG9ydF9ncm91cFxcICVpbiUgY29sbmFtZXMoeCkpIHt4JHZhcmlhYmxlX3Nob3J0X2dyb3VwIDwtIE5BfVxuICBcbiAgIHggJT4lIFxuICAgICBtdXRhdGUoZmlwcz1hcy5udW1lcmljKGZpcHMpKSAlPiUgXG4gICAgIGZpbHRlcighaXMubmEoZmlwcykpICU+JSBcbiAgICAgZHBseXI6OnNlbGVjdChmaXBzLCBkYXRhc2V0LCB2YXJpYWJsZV9zaG9ydF9ncm91cCwgdmFyaWFibGVfc2hvcnQsIHZhcmlhYmxlLCAgZGVzY3JpcHRpb24sIHZhbHVlKSAlPiVcbiAgICAgbXV0YXRlX2F0KHZhcnMoZGF0YXNldCwgdmFyaWFibGVfc2hvcnRfZ3JvdXAsIHZhcmlhYmxlX3Nob3J0LCB2YXJpYWJsZSwgIGRlc2NyaXB0aW9uKSwgYXMuY2hhcmFjdGVyKSAlPiVcbiAgICAgbXV0YXRlKHZhbHVlPWFzLm51bWVyaWModmFsdWUpKSAlPiVcbiAgICAgZmlsdGVyKCFpcy5uYSh2YWx1ZSkpXG5cbn1cblxuYGBgXG5gYGAifQ== -->

```r
```r

fromscratch=F

knitr::opts_chunk$set(fig.width = 8, fig.height = 8, message=F, warning=F, echo=F, results=F)

#Library Loads
library(pacman)
p_load(tidyverse)
p_load(janitor)
p_load(tidylog)
p_load(stringr)
p_load(ggdag)
p_load(data.table)
p_load(sf)
p_load(glue)
p_load(scales)
options(tigris_use_cache = TRUE)


restartspark <- function(){
  #devtools::install_github(\rstudio/sparklyr\)
  #devtools::install_github(\rstudio/sparklyr\)
  #install.packages('sparklyr') #rolling back to the stable version
  library(sparklyr)
  #spark_available_versions()
  #spark_installed_versions()
  #spark_uninstall(version=\3.0.1\, hadoop_version=\3.2\)
  #spark_uninstall(version=\2.4.3\, hadoop_version=\2.7\)
  #oh interesting the default is spark 2.4.3 I wonder why that is
  #Error: Java 11 is only supported for Spark 3.0.0+
  #spark_install(\3.0\) #3.1.1 is currently the latest stable, but 3.0 is the latest available

  #library(geospark)
  #library(arrow)
  mem=\160G\
  try({spark_disconnect(sc)})
  conf <- spark_config()
  #conf$`sparklyr.cores.local` <- 128
  #https://datasystemslab.github.io/GeoSpark/api/sql/GeoSparkSQL-Parameter/
  conf$spark.serializer <- \org.apache.spark.serializer.KryoSerializer\
  #conf$spark.kryo.registrator <- \org.datasyslab.geospark.serde.GeoSparkKryoRegistrator\
  #conf$spark.kryoserializer.buffer.max <- \2047MB\ #Caused by: java.lang.IllegalArgumentException: spark.kryoserializer.buffer.max must be less than 2048 mb, got: + 10240 mb.
  #https://github.com/DataSystemsLab/GeoSpark/issues/217
  #conf$geospark.global.index <- \true\
  #conf$geospark.global.indextype <- \quadtree\
  #conf$geospark.join.gridtype <- \kdbtree\
  #conf$spark.sql.shuffle.partitions <- 1999 #https://github.com/DataSystemsLab/GeoSpark/issues/361 #setting to just under 2k so compression doesn't kick in, don't need to lower the memory footprint
  conf$spark.driver.maxResultSize <- \100G\
  conf$spark.memory.fraction <- 0.9
  conf$spark.storage.blockManagerSlaveTimeoutMs <-\6000000s\ #Failed during initialize_connection: java.lang.IllegalArgumentException: requirement failed: spark.executor.heartbeatInterval should be less than or equal to spark.storage.blockManagerSlaveTimeoutMs
  conf$spark.executor.heartbeatInterval <-\6000000s\# \10000000s\
  conf$spark.network.timeout <- \6000001s\
  conf$spark.local.dir <- \/mnt/8tb_b/spark_temp/\
  conf$spark.worker.cleanup.enabled <- \true\
  conf$\sparklyr.shell.driver-memory\= mem
  conf$'spark.driver.maxResultSize' <- 0 #0 is ulimmited
  
  conf$'spark.sql.legacy.parquet.datetimeRebaseModeInRead' <- 'LEGACY'
  conf$'spark.sql.legacy.parquet.datetimeRebaseModeInWrite' <- 'LEGACY'
  
  conf$'spark.sql.execution.arrow.maxRecordsPerBatch' <- \5000000\ #https://github.com/arctern-io/arctern/issues/399
  
  #Error: org.apache.spark.sql.AnalysisException: The pivot column variable_clean has more than 10000 distinct values, this could indicate an error. If this was intended, set spark.sql.pivotMaxValues to at least the number of distinct values of the pivot column.;
  conf$'spark.sql.pivotMaxValues' <- \5000000\
  
  sc <<- spark_connect(master = \local\, config = conf#,
                      #version = \2.3.3\ #for geospark
  ) 
}

restartspark()


rex_clean <- function(x){
  if(!\variable_short\ %in% colnames(x)) {x$variable_short <- NA}
  if(!\variable_short_group\ %in% colnames(x)) {x$variable_short_group <- NA}
  
   x %>% 
     mutate(fips=as.numeric(fips)) %>% 
     filter(!is.na(fips)) %>% 
     dplyr::select(fips, dataset, variable_short_group, variable_short, variable,  description, value) %>%
     mutate_at(vars(dataset, variable_short_group, variable_short, variable,  description), as.character) %>%
     mutate(value=as.numeric(value)) %>%
     filter(!is.na(value))

}

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Appendix 1 Unit of Analysis Train Test Split


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5wX2xvYWQodGlkeXZlcnNlKVxucF9sb2FkKHVyYm5tYXByKVxucF9sb2FkKHRpZ3JpcylcbiNsaWJyYXJ5KGxlYWZsZXQpXG5jb3VudGllc19zZl90aWdyaXMgPC0gdGlncmlzOjpjb3VudGllcyhzdGF0ZSA9IE5VTEwsIGNiID0gRkFMU0UsIHJlc29sdXRpb24gPSBcXDVtXFwsIHllYXIgPSAyMDE5KSAlPiUgbXV0YXRlKGZpcHM9cGFzdGUwKFNUQVRFRlAsIENPVU5UWUZQKSAlPiUgYXMubnVtZXJpYykgJT4lIGFycmFuZ2UoZmlwcylcbnN0YXRlc19zZl90aWdyaXMgPC0gdGlncmlzOjpzdGF0ZXMoY2IgPSBUUlVFKVxuXG5pZihmcm9tc2NyYXRjaCl7XG4gIGNvdW50aWVzX3NmX3RpZ3JpcyAlPiUgZmlwcygpXG4gIGNvdW50aWVzX3NmX3RpZ3JpcyRDT1VOVFlGUCAlPiUgdGFibGUoKVxuICBwX2xvYWQobm5nZW8pXG4gIGR5YWRfbGlzdCA8LSBsaXN0KClcbiAgZm9yKGkgaW4gY291bnRpZXNfc2ZfdGlncmlzJENPVU5UWUZQICU+JSB1bmlxdWUoKSAlPiUgc29ydCgpICl7XG4gICAgcHJpbnQoaSlcbiAgICB0ZW1wIDwtIHN0X2pvaW4oY291bnRpZXNfc2ZfdGlncmlzICU+JSBmaWx0ZXIoQ09VTlRZRlA9PWkpICU+JSBkcGx5cjo6c2VsZWN0KGZpcHMpICAsXG4gICAgICAgICAgICAgICAgICAgIGNvdW50aWVzX3NmX3RpZ3JpcyAlPiUgZHBseXI6OnNlbGVjdChmaXBzKSAsXG4gICAgICAgICAgICAgICAgICAgIHN0X25uLCBrPTEwLCBtYXhkaXN0ID0gMTAwMCwgcGFyYWxsZWw9MTIwLCBwcm9ncmVzcyA9IFQpICU+JSAjZGlzdCBpcyBtZXRlcnMgc28gMTBrIGlzIDEwa20gLCAjdGhlIG1lbW9yeSByZXF1aXJlbWVudHMgb2YgdGhpcyBhcmUgbWFzc2l2ZVxuICAgICAgICAgICAgICAgICAgICBmaWx0ZXIoZmlwcy54IT1maXBzLnkpICU+JVxuICAgICAgICAgICAgICAgICAgICBhcy5kYXRhLmZyYW1lKCkgJT4lXG4gICAgICAgICAgICAgICAgICAgIGRwbHlyOjpzZWxlY3QoLWdlb21ldHJ5KSAlPiUgXG4gICAgICAgICAgICAgICAgICAgIGphbml0b3I6OmNsZWFuX25hbWVzKClcbiAgICBkaW0odGVtcClcbiAgICBkeWFkX2xpc3RbW2ldXTwtIHRlbXBcbiAgfVxuICBkeWFkX2RmIDwtIGJpbmRfcm93cyhkeWFkX2xpc3QpXG4gIGRpbShkeWFkX2RmKVxuICBzYXZlUkRTKGR5YWRfZGYsIFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvTkVTU3JkZi9keWFkX2RmLlJkc1xcIClcblxufVxuZHlhZF9kZiA8LSByZWFkUkRTKCBcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL05FU1NyZGYvZHlhZF9kZi5SZHNcXCApXG5cbnBsYWNlc193ZV9leGNsdWRlIDwtIGMoJ1VuaXRlZCBTdGF0ZXMgVmlyZ2luIElzbGFuZHMnLCdDb21tb253ZWFsdGggb2YgdGhlIE5vcnRoZXJuIE1hcmlhbmEgSXNsYW5kcycsJ0hhd2FpaScsJ1B1ZXJ0byBSaWNvJywnR3VhbScsJ0FtZXJpY2FuIFNhbW9hJywnQWxhc2thJylcblxuZmlwc193ZV9leGNsdWRlIDwtIHN0YXRlc19zZl90aWdyaXMgJT4lIGRwbHlyOjpmaWx0ZXIoTkFNRSAlaW4lIHBsYWNlc193ZV9leGNsdWRlKSAlPiUgcHVsbChTVEFURUZQKSAlPiUgYXMubnVtZXJpYygpXG5cblxuc3RhdGVzX3NmX3RpZ3Jpc19jb250aW5lbnRhbCA8LSBzdGF0ZXNfc2ZfdGlncmlzICU+JSBkcGx5cjo6ZmlsdGVyKCFOQU1FICVpbiUgcGxhY2VzX3dlX2V4Y2x1ZGUpXG5cbiNzdGF0ZXNfc2YgPC0gZ2V0X3VyYm5fbWFwKFxcc3RhdGVzXFwsIHNmID0gVFJVRSkgI3RoZXkgcGxhY2UgYWxhc2thIGluIGFzIGlmIGl0cyBuZXh0IHRvIHRleGFzXG5cbmNlbnRyb2lkcyA8LSBzdGF0ZXNfc2ZfdGlncmlzX2NvbnRpbmVudGFsICU+JSBzdF9jZW50cm9pZCgpIFxuY2VudHJvaWRzIDwtIGNiaW5kKGNlbnRyb2lkcyAsIGRhdGEuZnJhbWUoc3RfY29vcmRpbmF0ZXMoY2VudHJvaWRzKSkgKVxuXG5cbmxpYnJhcnkoc3BlcnJvcmVzdCk7ICNpbnN0YWxsLnBhY2thZ2VzKCdzcGVycm9yZXN0JylcbiAgXG5jb29yZHNfZGYgPC0gZGF0YS5mcmFtZShzdF9jb29yZGluYXRlcyhjZW50cm9pZHMpKVxucmVzYW1wIDwtIHBhcnRpdGlvbl9rbWVhbnMoY29vcmRzX2RmLCBuZm9sZCA9IDMsIGNvb3JkcyA9IGMoXFxYXFwsIFxcWVxcKSwgcmVwZXRpdGlvbiA9IDE6MSwgcmV0dXJuX2ZhY3Rvcj1ULCBiYWxhbmNpbmdfc3RlcHM9MTAwKVxudGFibGUocmVzYW1wJGAxYClcbiNwbG90KHJlc2FtcCwgZWN1YWRvcilcbiNmb2xkcyA9IHBhcnRpdGlvbl90aWxlcyhjb29yZHNfZGYsIGNvb3JkcyA9IGMoXFxYXFwsIFxcWVxcKSwgbnNwbGl0PWMoMiwyKSApICMsIG1pbl9uPTAuOFxuXG5zdGF0ZXNfc2ZfdGlncmlzX2NvbnRpbmVudGFsJGZvbGRfa21lYW5zID0gcmVzYW1wJGAxYFxuI3N0YXRlc19zZl90aWdyaXNfY29udGluZW50YWwgPC0gc3RhdGVzX3NmX3RpZ3Jpc19jb250aW5lbnRhbCAlPiUgXG4jICAgICAgICAgICAgIG11dGF0ZShmb2xkID0gcmVjb2RlKGFzLmNoYXJhY3Rlcihmb2xkKSwgJzEnPTIsJzUnPTIsICcyJz0yLCAnMyc9MywgJzMnPTMsICc0Jz00KSkgJT4lIFxuIyAgICAgICAgICAgICBtdXRhdGUoZm9sZCA9IHJlY29kZShhcy5jaGFyYWN0ZXIoZm9sZCksICcyJz0xLCczJz0yLCAnNCc9MykpICNyZWxldmVsIHRoZW1cblxuXG4jdGFibGUoc3RhdGVzX3NmX3RpZ3Jpc19jb250aW5lbnRhbCRmb2xkKVxuXG4jU3RhdGUgRmxvd3NcbmZuYW1lcyA8LSBsaXN0LmZpbGVzKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX3RlbXAvQ09WSUQxOVVTRmxvd3Mvd2Vla2x5X2Zsb3dzL3N0YXRlMnN0YXRlL1xcLCBwYXR0ZXJuID0gXFxjc3ZcXCwgZnVsbC5uYW1lcyA9IFQpXG5mbG93c19zdGF0ZTJzdGF0ZSA8LSByYmluZGxpc3QobGFwcGx5KGZuYW1lcywgZnJlYWQpLCBmaWxsPVQpXG5mbG93c19zdGF0ZTJzdGF0ZV9jbGVhbiA8LSBmbG93c19zdGF0ZTJzdGF0ZSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsdGVyKCFnZW9pZF9vICVpbiUgZmlwc193ZV9leGNsdWRlLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIWdlb2lkX2QgJWluJSBmaXBzX3dlX2V4Y2x1ZGUpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZpbHRlcihnZW9pZF9vIT1nZW9pZF9kKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZXBhcmF0ZShkYXRlX3JhbmdlLCBjKFxcc3RhcnQxXFwsIFxcc3RhcnQyXFwpLCBzZXAgPSBcXCAtIFxcLCByZW1vdmU9RikgJT4lXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsdGVyKHN0YXJ0MSAlPiUgc3RyX2RldGVjdChcXC8xOSRcXCkpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICNtdXRhdGUoc3RhcnQxPSBsdWJyaWRhdGU6OmFzX2RhdGUoc3RhcnQxKSApICU+JSBcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAjbXV0YXRlKHN0YXJ0Mj0gbHVicmlkYXRlOjphc19kYXRlKHN0YXJ0MikgKSAlPiUgXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgI2ZpbHRlcihzdGFydDEgPCBsdWJyaWRhdGU6OmFzX2RhdGUoXFwyMDIwLTAxLTAxXFwpICkgJT4lXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgI2ZpbHRlcihzdGFydDIgPCBsdWJyaWRhdGU6OmFzX2RhdGUoXFwyMDIwLTAxLTAxXFwpICkgJT4lXG5cbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBncm91cF9ieShnZW9pZF9vLGdlb2lkX2QpICU+JSBcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdW1tYXJpc2UocG9wX2Zsb3dzX2xvZz1zdW0ocG9wX2Zsb3dzKSAlPiUgbG9nKCkgKVxuXG4jaGlzdChmbG93c19zdGF0ZTJzdGF0ZV9jbGVhbiRwb3BfZmxvd3NfbG9nICkgI3N0YXRlIHRvIHN0YXRlIGZsb3dzIGFyZSBsb2cgbm9ybWFsIHNvIHdlJ3JlIGdvb2RcblxuZmxvd3Nfc3RhdGUyc3RhdGVfY2xlYW5fd2lkZSA8LSBmbG93c19zdGF0ZTJzdGF0ZV9jbGVhbiAlPiUgXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG11dGF0ZShnZW9pZF9vPXN0cl9wYWQoZ2VvaWRfbywgMiwgcGFkID0gXFwwXFwpKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGdlb2lkX2Q9c3RyX3BhZChnZW9pZF9kLCAyLCBwYWQgPSBcXDBcXCkpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwaXZvdF93aWRlcihuYW1lc19mcm9tID0gZ2VvaWRfZCwgdmFsdWVzX2Zyb20gPSBwb3BfZmxvd3NfbG9nLCB2YWx1ZXNfZmlsbCA9IE5BKSAlPiUgXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuZ3JvdXAoKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHBseXI6OnNlbGVjdCgtZ2VvaWRfbykgICAlPiUgXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlbGVjdChzb3J0KGN1cnJlbnRfdmFycygpKSlcbmRpbShmbG93c19zdGF0ZTJzdGF0ZV9jbGVhbl93aWRlKSAjT2sgdGhpcyBpcyBub3cgYSA0OXg0OSBzdGF0ZSBtYXRyaXggY29ycmNldGx5IHNvcnRlZCBpbiBvcmRlciB3aXRoIGxlYWRpbmcgemVyb3NcblxuZmxvd3Nfc3RhdGUyc3RhdGVfY2xlYW5fd2lkZV9pbnZlcnNlIDwtIDEvZmxvd3Nfc3RhdGUyc3RhdGVfY2xlYW5fd2lkZVxuZmxvd3Nfc3RhdGUyc3RhdGVfY2xlYW5fd2lkZV9pbnZlcnNlX2QgPC0gYXMuZGlzdChmbG93c19zdGF0ZTJzdGF0ZV9jbGVhbl93aWRlX2ludmVyc2UpXG5oYyA8LSBoY2x1c3QoZmxvd3Nfc3RhdGUyc3RhdGVfY2xlYW5fd2lkZV9pbnZlcnNlX2QsIG1ldGhvZCA9IFxcd2FyZC5EMlxcKVxuI3Bsb3QoaGMpXG4jdGFibGUoY3V0cmVlKGhjLCBrPTQpKSAjVGhlIG5vcnRoIGVhc3QgaXMgdW5iYWxhbmNlZCwgYnV0IHBvc3NpYmx5IG5vdCBpbiB0ZXJtcyBvZiBjb3VudGllcz9cbiN0YWJsZShjdXRyZWUoaGMsIGs9NikpICNUaGUgbm9ydGggZWFzdCBpcyB1bmJhbGFuY2VkLCBidXQgcG9zc2libHkgbm90IGluIHRlcm1zIG9mIGNvdW50aWVzP1xuXG5zdGF0ZXNfc2ZfdGlncmlzX2NvbnRpbmVudGFsIDwtIHN0YXRlc19zZl90aWdyaXNfY29udGluZW50YWwgJT4lIGFycmFuZ2UoU1RBVEVGUCkgJT4lIFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdXRhdGUoZm9sZF80PWN1dHJlZShoYywgaz00KSkgJT4lICBcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGZvbGRfNT1jdXRyZWUoaGMsIGs9NSkpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdXRhdGUoZm9sZF82PWN1dHJlZShoYywgaz02KSkgJT4lICNzaXogaXQgaXNcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGZvbGRfOD1jdXRyZWUoaGMsIGs9OCkpICMlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI211dGF0ZShmb2xkPWZvbGRfNiAlPiUgYXMuZmFjdG9yKCkpXG5cbnBsb3Qoc3RhdGVzX3NmX3RpZ3Jpc19jb250aW5lbnRhbFssJ2ZvbGRfNiddKVxuc3RhdGVzX3NmX3RpZ3Jpc19jb250aW5lbnRhbCRmb2xkXzVfY29sbGFwc2VkIDwtIHN0YXRlc19zZl90aWdyaXNfY29udGluZW50YWwkZm9sZF82XG5zdGF0ZXNfc2ZfdGlncmlzX2NvbnRpbmVudGFsJGZvbGRfNV9jb2xsYXBzZWRbc3RhdGVzX3NmX3RpZ3Jpc19jb250aW5lbnRhbCRmb2xkXzY9PTZdIDwtIDVcbnN0YXRlc19zZl90aWdyaXNfY29udGluZW50YWwkZm9sZCA8LSBzdGF0ZXNfc2ZfdGlncmlzX2NvbnRpbmVudGFsJGZvbGRfNV9jb2xsYXBzZWRcbnBsb3Qoc3RhdGVzX3NmX3RpZ3Jpc19jb250aW5lbnRhbFssJ2ZvbGRfNV9jb2xsYXBzZWQnXSlcbnNhdmVSRFMoc3RhdGVzX3NmX3RpZ3Jpc19jb250aW5lbnRhbCwgXFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzL2RhdGFfb3V0L3N0YXRlc19zZl90aWdyaXNfY29udGluZW50YWwuUmRzXFwpXG5cbmBgYFxuYGBgIn0= -->

```r
```r

p_load(tidyverse)
p_load(urbnmapr)
p_load(tigris)
#library(leaflet)
counties_sf_tigris <- tigris::counties(state = NULL, cb = FALSE, resolution = \5m\, year = 2019) %>% mutate(fips=paste0(STATEFP, COUNTYFP) %>% as.numeric) %>% arrange(fips)
states_sf_tigris <- tigris::states(cb = TRUE)

if(fromscratch){
  counties_sf_tigris %>% fips()
  counties_sf_tigris$COUNTYFP %>% table()
  p_load(nngeo)
  dyad_list <- list()
  for(i in counties_sf_tigris$COUNTYFP %>% unique() %>% sort() ){
    print(i)
    temp <- st_join(counties_sf_tigris %>% filter(COUNTYFP==i) %>% dplyr::select(fips)  ,
                    counties_sf_tigris %>% dplyr::select(fips) ,
                    st_nn, k=10, maxdist = 1000, parallel=120, progress = T) %>% #dist is meters so 10k is 10km , #the memory requirements of this are massive
                    filter(fips.x!=fips.y) %>%
                    as.data.frame() %>%
                    dplyr::select(-geometry) %>% 
                    janitor::clean_names()
    dim(temp)
    dyad_list[[i]]<- temp
  }
  dyad_df <- bind_rows(dyad_list)
  dim(dyad_df)
  saveRDS(dyad_df, \/mnt/8tb_a/rwd_github_private/NESSrdf/dyad_df.Rds\ )

}
dyad_df <- readRDS( \/mnt/8tb_a/rwd_github_private/NESSrdf/dyad_df.Rds\ )

places_we_exclude <- c('United States Virgin Islands','Commonwealth of the Northern Mariana Islands','Hawaii','Puerto Rico','Guam','American Samoa','Alaska')

fips_we_exclude <- states_sf_tigris %>% dplyr::filter(NAME %in% places_we_exclude) %>% pull(STATEFP) %>% as.numeric()


states_sf_tigris_continental <- states_sf_tigris %>% dplyr::filter(!NAME %in% places_we_exclude)

#states_sf <- get_urbn_map(\states\, sf = TRUE) #they place alaska in as if its next to texas

centroids <- states_sf_tigris_continental %>% st_centroid() 
centroids <- cbind(centroids , data.frame(st_coordinates(centroids)) )


library(sperrorest); #install.packages('sperrorest')
  
coords_df <- data.frame(st_coordinates(centroids))
resamp <- partition_kmeans(coords_df, nfold = 3, coords = c(\X\, \Y\), repetition = 1:1, return_factor=T, balancing_steps=100)
table(resamp$`1`)
#plot(resamp, ecuador)
#folds = partition_tiles(coords_df, coords = c(\X\, \Y\), nsplit=c(2,2) ) #, min_n=0.8

states_sf_tigris_continental$fold_kmeans = resamp$`1`
#states_sf_tigris_continental <- states_sf_tigris_continental %>% 
#             mutate(fold = recode(as.character(fold), '1'=2,'5'=2, '2'=2, '3'=3, '3'=3, '4'=4)) %>% 
#             mutate(fold = recode(as.character(fold), '2'=1,'3'=2, '4'=3)) #relevel them


#table(states_sf_tigris_continental$fold)

#State Flows
fnames <- list.files(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_temp/COVID19USFlows/weekly_flows/state2state/\, pattern = \csv\, full.names = T)
flows_state2state <- rbindlist(lapply(fnames, fread), fill=T)
flows_state2state_clean <- flows_state2state %>%
                                filter(!geoid_o %in% fips_we_exclude,
                                       !geoid_d %in% fips_we_exclude) %>%
                            filter(geoid_o!=geoid_d) %>%
                            separate(date_range, c(\start1\, \start2\), sep = \ - \, remove=F) %>%
                            filter(start1 %>% str_detect(\/19$\)) %>%
                            #mutate(start1= lubridate::as_date(start1) ) %>% 
                            #mutate(start2= lubridate::as_date(start2) ) %>% 
                            #filter(start1 < lubridate::as_date(\2020-01-01\) ) %>%
                            #filter(start2 < lubridate::as_date(\2020-01-01\) ) %>%

                            group_by(geoid_o,geoid_d) %>% 
                            summarise(pop_flows_log=sum(pop_flows) %>% log() )

#hist(flows_state2state_clean$pop_flows_log ) #state to state flows are log normal so we're good

flows_state2state_clean_wide <- flows_state2state_clean %>% 
                                mutate(geoid_o=str_pad(geoid_o, 2, pad = \0\)) %>%
                                mutate(geoid_d=str_pad(geoid_d, 2, pad = \0\)) %>%
                                pivot_wider(names_from = geoid_d, values_from = pop_flows_log, values_fill = NA) %>% 
                                ungroup() %>%
                                dplyr::select(-geoid_o)   %>% 
                                select(sort(current_vars()))
dim(flows_state2state_clean_wide) #Ok this is now a 49x49 state matrix corrcetly sorted in order with leading zeros

flows_state2state_clean_wide_inverse <- 1/flows_state2state_clean_wide
flows_state2state_clean_wide_inverse_d <- as.dist(flows_state2state_clean_wide_inverse)
hc <- hclust(flows_state2state_clean_wide_inverse_d, method = \ward.D2\)
#plot(hc)
#table(cutree(hc, k=4)) #The north east is unbalanced, but possibly not in terms of counties?
#table(cutree(hc, k=6)) #The north east is unbalanced, but possibly not in terms of counties?

states_sf_tigris_continental <- states_sf_tigris_continental %>% arrange(STATEFP) %>% 
                                mutate(fold_4=cutree(hc, k=4)) %>%  
                                mutate(fold_5=cutree(hc, k=5)) %>%
                                mutate(fold_6=cutree(hc, k=6)) %>% #siz it is
                                mutate(fold_8=cutree(hc, k=8)) #%>%
                                #mutate(fold=fold_6 %>% as.factor())

plot(states_sf_tigris_continental[,'fold_6'])
states_sf_tigris_continental$fold_5_collapsed <- states_sf_tigris_continental$fold_6
states_sf_tigris_continental$fold_5_collapsed[states_sf_tigris_continental$fold_6==6] <- 5
states_sf_tigris_continental$fold <- states_sf_tigris_continental$fold_5_collapsed
plot(states_sf_tigris_continental[,'fold_5_collapsed'])
saveRDS(states_sf_tigris_continental, \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/states_sf_tigris_continental.Rds\)

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




# Appendix 2 Demographics


### Census 2020 Actual Demographics

Download ftp files from here ftp.census.gov/programs-surveys/decennial/2020/data/01-Redistricting_File--PL_94-171/


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5sYWJlbHNfZGYgPC0gZGF0YS5mcmFtZShcbiAgc3RyaW5nc0FzRmFjdG9ycyA9IEZBTFNFLFxuICAgICAgICAgICAgICBuYW1lID0gYyhcXHBvcFxcLFxccG9wX2hpc3BcXCxcXHBvcF93aGl0ZVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXHBvcF9ibGFja1xcLFxccG9wX2FpYW5cXCxcXHBvcF9hc2lhblxcLFxccG9wX25ocGlcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFxwb3Bfb3RoZXJcXCxcXHBvcF90d29cXCxcXHZhcFxcLFxcdmFwX2hpc3BcXCxcXHZhcF93aGl0ZVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXHZhcF9ibGFja1xcLFxcdmFwX2FpYW5cXCxcXHZhcF9hc2lhblxcLFxcdmFwX25ocGlcXCxcXHZhcF9vdGhlclxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXHZhcF90d29cXCksXG4gICAgICAgZGVzY3JpcHRpb24gPSBjKFxccG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXGhpc3BhbmljIHBvcHVsYXRpb25cXCxcXHdoaXRlIHBvcHVsYXRpb25cXCxcXGJsYWNrIHBvcHVsYXRpb25cXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFxBbWVyaWNhbiBJbmRpYW4gYW5kIEFsYXNrYSBOYXRpdmUgcG9wdWxhdGlvblxcLFxcYXNpYW4gcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXE5hdGl2ZSBIYXdhaWlhbnMgYW5kIFBhY2lmaWMgSXNsYW5kZXJzIHBvcHVsYXRpb25cXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFxvdGhlciBwb3B1bGF0aW9uXFwsXFxwb3B1bGF0aW9uIG9mIHR3byBvciBtb3JlIHJhY2VzXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTggeWVhcnMgb3Igb2xkZXIgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDE4IHllYXJzIG9yIG9sZGVyIGhpc3BhbmljIHBvcHVsYXRpb25cXCxcXDE4IHllYXJzIG9yIG9sZGVyIHdoaXRlIHBvcHVsYXRpblxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDE4IHllYXJzIG9yIG9sZGVyIGJsYWNrIHBvcHVsYXRpb25cXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwxOCB5ZWFycyBvciBvbGRlciBBbWVyaWNhbiBJbmRpYW4gYW5kIEFsYXNrYSBOYXRpdmUgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDE4IHllYXJzIG9yIG9sZGVyIHBvcHVsYXRpb25cXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwxOCB5ZWFycyBvciBvbGRlciBOYXRpdmUgSGF3YWlpYW5zIGFuZCBQYWNpZmljIElzbGFuZGVycyBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTggeWVhcnMgb3Igb2xkZXIgb3RoZXIgcG9wdWxhdGlvblxcLFxcMTggeWVhcnMgb3Igb2xkZXIgcG9wdWxhdGlvbiBvZiB0d28gb3IgbW9yZSByYWNlc1xcKVxuKVxuXG4jZGV2dG9vbHM6Omluc3RhbGxfZ2l0aHViKFxcQ29yeU1jQ2FydGFuL1BMOTQxNzFcXClcbmxpYnJhcnkoUEw5NDE3MSlcbmlmKGZyb21zY3JhdGNoKXtcbiAgI1VuY29tcHJlc3MgYWxsIG9mIHRoZW0gaGVyZVxuICB6aXBfZmlsZXMgPC0gbGlzdC5maWxlcyhwYXRoID0gXFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzL2RhdGFfaW4vMjAyMF9wbF85NF8xNzEvMDEtUmVkaXN0cmljdGluZ19GaWxlLS1QTF85NC0xNzEvXFwsIHBhdHRlcm4gPSBcXCouemlwXFwsIGFsbC5maWxlcyA9IEZBTFNFLFxuICAgICAgICAgICAgICAgZnVsbC5uYW1lcyA9IFQsIHJlY3Vyc2l2ZSA9IFQsIGlnbm9yZS5jYXNlID0gRkFMU0UsIGluY2x1ZGUuZGlycyA9IEZBTFNFLCBuby4uID0gRkFMU0UpXG4gICNzYXBwbHkoemlwX2ZpbGVzLCB1bnppcCwgZXhkaXIgPSBcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YV9pbi8yMDIwX3BsXzk0XzE3MS8wMS1SZWRpc3RyaWN0aW5nX0ZpbGUtLVBMXzk0LTE3MS9cXCwgb3ZlcndyaXRlID1GKSAjSnVzdCBkdW1wIGFsbCB0aGUgcGwgZmlsZXMgdG8gb25lIGRpcmVjdG9yeVxuICBwbF9saXN0PWxpc3QoKVxuICBmb3IoZmlsZSBpbiB6aXBfZmlsZXMpe1xuICAgIHByaW50KGZpbGUpXG4gICAgaWYoaXMubnVsbChwbF9saXN0W1tmaWxlXV0pKXtcbiAgICAgIHRyeSh7XG4gICAgICAgIHBsX2xpc3RbW2ZpbGVdXSA8LSBmaWxlICU+JSBQTDk0MTcxOjpyZWFkX3BsKCkgJT4lIFBMOTQxNzE6OjpwbF93aWRlbigpICU+JSBkcGx5cjo6ZmlsdGVyKFNVTUxFVj09XFwwNTBcXCkgJT4lIHBsX3NlbGVjdF9zdGFuZGFyZChjbGVhbl9uYW1lcz1UUlVFKVxuICAgICAgfSlcbiAgICB9XG4gIH1cbiAgcGxfZGYgPC0gcGxfbGlzdCU+JSBiaW5kX3Jvd3MoKSAjZ29pbmcgdG8gaGF2ZSBpdCBpdGVyYXRlIG92ZXIgZWFjaCB6aXAgZmlsZVxuICBkaW0ocGxfZGYpXG4gIHNhdmVSRFMocGxfZGYsIFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX3RlbXAvcGxfZGYuUmRzXFwpXG59XG5cbnBsX2RmIDwtIHJlYWRSRFMoIFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX3RlbXAvcGxfZGYuUmRzXFwpXG5cbnBsX2RmX3RvdGFsIDwtICAgcGxfZGYgJT4lIGphbml0b3I6OmNsZWFuX25hbWVzKCkgJT4lIHNlcGFyYXRlKGdlb2lkLCBjKFxcdGVtcFxcLFxcZmlwc1xcKSwgc2VwPVxcVVNcXCkgJT4lXG4gICAgICAgICAgICAgICAgICBkcGx5cjo6c2VsZWN0KC10ZW1wLC1zdGF0ZSwtY291bnR5LC1yb3dfaWQsLXN1bW1hcnlfbGV2ZWwsLXZ0ZCkgJT4lXG4gICAgICAgICAgICAgICAgICBwaXZvdF9sb25nZXIoLWZpcHMpICU+JSBcbiAgICAgICAgICAgICAgICAgIGxlZnRfam9pbihsYWJlbHNfZGYpXG5cbiNwbF9kZl9wZXJjZW50IDwtIHBsX2RmX3RvdGFsICU+JSBncm91cF9ieShmaXBzKSAlPiUgbXV0YXRlKHZhbHVlPXZhbHVlL21heCh2YWx1ZSkpICU+JVxuIyAgICAgICAgICAgICAgICAgICAgIG11dGF0ZShuYW1lPXBhc3RlMChuYW1lLCBcXF9wZXJjZW50XFwpKSAlPiVcbiMgICAgICAgICAgICAgICAgICAgICBtdXRhdGUoZGVzY3JpcHRpb249cGFzdGUwKGRlc2NyaXB0aW9uLCBcXCBwZXJjZW50XFwpKVxuXG5yaHNfY2Vuc3VzXzIwMjAgPC0gYmluZF9yb3dzKHBsX2RmX3RvdGFsKSAlPiUgbXV0YXRlKGRhdGFzZXQ9XFxjZW5zdXNfMjAyMF9hY3R1YWxcXCkgJT4lIHJlbmFtZSh2YXJpYWJsZT1uYW1lKSAjd2UgZG8gcGVyY2VudCBhdCB0aGUgZW5kXG5cbnJoc19jZW5zdXNfMjAyMCAgJT4lIHJleF9jbGVhbigpICU+JSBhcnJvdzo6d3JpdGVfcGFycXVldChnbHVlOjpnbHVlKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX291dC9yaHMvcmhzX2NlbnN1czIwMjBfYWN0dWFsLnBhcnF1ZXRcXCkpXG5cblxuYGBgXG5gYGAifQ== -->

```r
```r

labels_df <- data.frame(
  stringsAsFactors = FALSE,
              name = c(\pop\,\pop_hisp\,\pop_white\,
                       \pop_black\,\pop_aian\,\pop_asian\,\pop_nhpi\,
                       \pop_other\,\pop_two\,\vap\,\vap_hisp\,\vap_white\,
                       \vap_black\,\vap_aian\,\vap_asian\,\vap_nhpi\,\vap_other\,
                       \vap_two\),
       description = c(\population\,
                       \hispanic population\,\white population\,\black population\,
                       \American Indian and Alaska Native population\,\asian population\,
                       \Native Hawaiians and Pacific Islanders population\,
                       \other population\,\population of two or more races\,
                       \18 years or older population\,
                       \18 years or older hispanic population\,\18 years or older white populatin\,
                       \18 years or older black population\,
                       \18 years or older American Indian and Alaska Native population\,
                       \18 years or older population\,
                       \18 years or older Native Hawaiians and Pacific Islanders population\,
                       \18 years or older other population\,\18 years or older population of two or more races\)
)

#devtools::install_github(\CoryMcCartan/PL94171\)
library(PL94171)
if(fromscratch){
  #Uncompress all of them here
  zip_files <- list.files(path = \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_in/2020_pl_94_171/01-Redistricting_File--PL_94-171/\, pattern = \*.zip\, all.files = FALSE,
               full.names = T, recursive = T, ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)
  #sapply(zip_files, unzip, exdir = \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_in/2020_pl_94_171/01-Redistricting_File--PL_94-171/\, overwrite =F) #Just dump all the pl files to one directory
  pl_list=list()
  for(file in zip_files){
    print(file)
    if(is.null(pl_list[[file]])){
      try({
        pl_list[[file]] <- file %>% PL94171::read_pl() %>% PL94171:::pl_widen() %>% dplyr::filter(SUMLEV==\050\) %>% pl_select_standard(clean_names=TRUE)
      })
    }
  }
  pl_df <- pl_list%>% bind_rows() #going to have it iterate over each zip file
  dim(pl_df)
  saveRDS(pl_df, \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_temp/pl_df.Rds\)
}

pl_df <- readRDS( \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_temp/pl_df.Rds\)

pl_df_total <-   pl_df %>% janitor::clean_names() %>% separate(geoid, c(\temp\,\fips\), sep=\US\) %>%
                  dplyr::select(-temp,-state,-county,-row_id,-summary_level,-vtd) %>%
                  pivot_longer(-fips) %>% 
                  left_join(labels_df)

#pl_df_percent <- pl_df_total %>% group_by(fips) %>% mutate(value=value/max(value)) %>%
#                     mutate(name=paste0(name, \_percent\)) %>%
#                     mutate(description=paste0(description, \ percent\))

rhs_census_2020 <- bind_rows(pl_df_total) %>% mutate(dataset=\census_2020_actual\) %>% rename(variable=name) #we do percent at the end

rhs_census_2020  %>% rex_clean() %>% arrow::write_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_census2020_actual.parquet\))

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



### Census 2020 Estimated Demographics

The 2020 age data aren't out yet, and so my idea is to use the estimated age distribution and multiply it by the observed total population to get approximate counts by age.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG4jaHR0cHM6Ly93d3cyLmNlbnN1cy5nb3YvcHJvZ3JhbXMtc3VydmV5cy9wb3Blc3QvZGF0YXNldHMvMjAxMC0yMDIwL2NvdW50aWVzL2FzcmgvXG5DQ19FU1QyMDIwIDwtIGZyZWFkKFxcaHR0cHM6Ly93d3cyLmNlbnN1cy5nb3YvcHJvZ3JhbXMtc3VydmV5cy9wb3Blc3QvZGF0YXNldHMvMjAxMC0yMDIwL2NvdW50aWVzL2FzcmgvQ0MtRVNUMjAyMC1BTExEQVRBLmNzdlxcKSAlPiUgY2xlYW5fbmFtZXMoKSAlPiUgZHBseXI6OmZpbHRlcih5ZWFyPT0xMylcblxuQ0NfRVNUMjAyMF9sb25nIDwtIENDX0VTVDIwMjAgJT4lIHBpdm90X2xvbmdlcihjb2xzPWMoLXN1bWxldiwgLXN0YXRlLCAtY291bnR5LCAtc3RuYW1lLCAtY3R5bmFtZSwgLXllYXIsIC1hZ2VncnApKVxuXG5saWJyYXJ5KGNsaXByKVxubGlicmFyeShkYXRhcGFzdGEpIDsgI2luc3RhbGwucGFja2FnZXMoJ2RhdGFwYXN0YScpXG4gXG5DQ19FU1QyMDIwX2xhYmVscyA8LSBkYXRhLmZyYW1lKFxuICBzdHJpbmdzQXNGYWN0b3JzID0gRkFMU0UsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuYW1lID0gYyhcXFNUQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXENPVU5UWVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXFNUTkFNRVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXENUWU5BTUVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxZRUFSXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcQUdFR1JQXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcVE9UX1BPUFxcLFxcVE9UX01BTEVcXCxcXFRPVF9GRU1BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxXQV9NQUxFXFwsXFxXQV9GRU1BTEVcXCxcXEJBX01BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxCQV9GRU1BTEVcXCxcXElBX01BTEVcXCxcXElBX0ZFTUFMRVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXEFBX01BTEVcXCxcXEFBX0ZFTUFMRVxcLFxcTkFfTUFMRVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXE5BX0ZFTUFMRVxcLFxcVE9NX01BTEVcXCxcXFRPTV9GRU1BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxXQUNfTUFMRVxcLFxcV0FDX0ZFTUFMRVxcLFxcQkFDX01BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxCQUNfRkVNQUxFXFwsXFxJQUNfTUFMRVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXElBQ19GRU1BTEVcXCxcXEFBQ19NQUxFXFwsXFxBQUNfRkVNQUxFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcTkFDX01BTEVcXCxcXE5BQ19GRU1BTEVcXCxcXE5IX01BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxOSF9GRU1BTEVcXCxcXE5IV0FfTUFMRVxcLFxcTkhXQV9GRU1BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxOSEJBX01BTEVcXCxcXE5IQkFfRkVNQUxFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcTkhJQV9NQUxFXFwsXFxOSElBX0ZFTUFMRVxcLFxcTkhBQV9NQUxFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcTkhBQV9GRU1BTEVcXCxcXE5ITkFfTUFMRVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXE5ITkFfRkVNQUxFXFwsXFxOSFRPTV9NQUxFXFwsXFxOSFRPTV9GRU1BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxOSFdBQ19NQUxFXFwsXFxOSFdBQ19GRU1BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxOSEJBQ19NQUxFXFwsXFxOSEJBQ19GRU1BTEVcXCxcXE5ISUFDX01BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxOSElBQ19GRU1BTEVcXCxcXE5IQUFDX01BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxOSEFBQ19GRU1BTEVcXCxcXE5ITkFDX01BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxOSE5BQ19GRU1BTEVcXCxcXEhfTUFMRVxcLFxcSF9GRU1BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxIV0FfTUFMRVxcLFxcSFdBX0ZFTUFMRVxcLFxcSEJBX01BTEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxIQkFfRkVNQUxFXFwsXFxISUFfTUFMRVxcLFxcSElBX0ZFTUFMRVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXEhBQV9NQUxFXFwsXFxIQUFfRkVNQUxFXFwsXFxITkFfTUFMRVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXEhOQV9GRU1BTEVcXCxcXEhUT01fTUFMRVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXEhUT01fRkVNQUxFXFwsXFxIV0FDX01BTEVcXCxcXEhXQUNfRkVNQUxFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcSEJBQ19NQUxFXFwsXFxIQkFDX0ZFTUFMRVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXEhJQUNfTUFMRVxcLFxcSElBQ19GRU1BTEVcXCxcXEhBQUNfTUFMRVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXEhBQUNfRkVNQUxFXFwsXFxITkFDX01BTEVcXCxcXEhOQUNfRkVNQUxFXFwpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdG9sb3dlcigpLFxuICBcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXNjcmlwdGlvbiA9IGMoXFxTdGF0ZSBGSVBTIGNvZGVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxDb3VudHkgRklQUyBjb2RlXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcU3RhdGUgTmFtZVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXENvdW50eSBOYW1lXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcWWVhclxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXEFnZSBncm91cFxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXFRvdGFsIHBvcHVsYXRpb25cXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxUb3RhbCBtYWxlIHBvcHVsYXRpb25cXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxUb3RhbCBmZW1hbGUgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXFdoaXRlIGFsb25lIG1hbGUgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXFdoaXRlIGFsb25lIGZlbWFsZSBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcQmxhY2sgb3IgQWZyaWNhbiBBbWVyaWNhbiBhbG9uZSBtYWxlIHBvcHVsYXRpb25cXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxCbGFjayBvciBBZnJpY2FuIEFtZXJpY2FuIGFsb25lIGZlbWFsZSBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcQW1lcmljYW4gSW5kaWFuIGFuZCBBbGFza2EgTmF0aXZlIGFsb25lIG1hbGUgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXEFtZXJpY2FuIEluZGlhbiBhbmQgQWxhc2thIE5hdGl2ZSBhbG9uZSBmZW1hbGUgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXEFzaWFuIGFsb25lIG1hbGUgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXEFzaWFuIGFsb25lIGZlbWFsZSBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcTmF0aXZlIEhhd2FpaWFuIGFuZCBPdGhlciBQYWNpZmljIElzbGFuZGVyIGFsb25lIG1hbGUgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXE5hdGl2ZSBIYXdhaWlhbiBhbmQgT3RoZXIgUGFjaWZpYyBJc2xhbmRlciBhbG9uZSBmZW1hbGUgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXFR3byBvciBNb3JlIFJhY2VzIG1hbGUgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXFR3byBvciBNb3JlIFJhY2VzIGZlbWFsZSBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcV2hpdGUgYWxvbmUgb3IgaW4gY29tYmluYXRpb24gbWFsZSBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcV2hpdGUgYWxvbmUgb3IgaW4gY29tYmluYXRpb24gZmVtYWxlIHBvcHVsYXRpb25cXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxCbGFjayBvciBBZnJpY2FuIEFtZXJpY2FuIGFsb25lIG9yIGluIGNvbWJpbmF0aW9uIG1hbGUgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXEJsYWNrIG9yIEFmcmljYW4gQW1lcmljYW4gYWxvbmUgb3IgaW4gY29tYmluYXRpb24gZmVtYWxlIHBvcHVsYXRpb25cXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxBbWVyaWNhbiBJbmRpYW4gYW5kIEFsYXNrYSBOYXRpdmUgYWxvbmUgb3IgaW4gY29tYmluYXRpb24gbWFsZSBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcQW1lcmljYW4gSW5kaWFuIGFuZCBBbGFza2EgTmF0aXZlIGFsb25lIG9yIGluIGNvbWJpbmF0aW9uIGZlbWFsZSBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcQXNpYW4gYWxvbmUgb3IgaW4gY29tYmluYXRpb24gbWFsZSBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcQXNpYW4gYWxvbmUgb3IgaW4gY29tYmluYXRpb24gZmVtYWxlIHBvcHVsYXRpb25cXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxOYXRpdmUgSGF3YWlpYW4gYW5kIE90aGVyIFBhY2lmaWMgSXNsYW5kZXIgYWxvbmUgb3IgaW4gY29tYmluYXRpb24gbWFsZSBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcTmF0aXZlIEhhd2FpaWFuIGFuZCBPdGhlciBQYWNpZmljIElzbGFuZGVyIGFsb25lIG9yIGluIGNvbWJpbmF0aW9uIGZlbWFsZSBwb3B1bGF0aW9uXFwsXFxOb3QgSGlzcGFuaWMgbWFsZSBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcTm90IEhpc3BhbmljIGZlbWFsZSBwb3B1bGF0aW9uXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcTm90IEhpc3BhbmljXG5gYGAifQ== -->

```r
```r

#https://www2.census.gov/programs-surveys/popest/datasets/2010-2020/counties/asrh/
CC_EST2020 <- fread(\https://www2.census.gov/programs-surveys/popest/datasets/2010-2020/counties/asrh/CC-EST2020-ALLDATA.csv\) %>% clean_names() %>% dplyr::filter(year==13)

CC_EST2020_long <- CC_EST2020 %>% pivot_longer(cols=c(-sumlev, -state, -county, -stname, -ctyname, -year, -agegrp))

library(clipr)
library(datapasta) ; #install.packages('datapasta')
 
CC_EST2020_labels <- data.frame(
  stringsAsFactors = FALSE,
                                    name = c(\STATE\,
                                             \COUNTY\,
                                            \STNAME\,
                                            \CTYNAME\,
                                            \YEAR\,
                                            \AGEGRP\,
                                            \TOT_POP\,\TOT_MALE\,\TOT_FEMALE\,
                                            \WA_MALE\,\WA_FEMALE\,\BA_MALE\,
                                            \BA_FEMALE\,\IA_MALE\,\IA_FEMALE\,
                                            \AA_MALE\,\AA_FEMALE\,\NA_MALE\,
                                            \NA_FEMALE\,\TOM_MALE\,\TOM_FEMALE\,
                                            \WAC_MALE\,\WAC_FEMALE\,\BAC_MALE\,
                                            \BAC_FEMALE\,\IAC_MALE\,
                                            \IAC_FEMALE\,\AAC_MALE\,\AAC_FEMALE\,
                                            \NAC_MALE\,\NAC_FEMALE\,\NH_MALE\,
                                            \NH_FEMALE\,\NHWA_MALE\,\NHWA_FEMALE\,
                                            \NHBA_MALE\,\NHBA_FEMALE\,
                                            \NHIA_MALE\,\NHIA_FEMALE\,\NHAA_MALE\,
                                            \NHAA_FEMALE\,\NHNA_MALE\,
                                            \NHNA_FEMALE\,\NHTOM_MALE\,\NHTOM_FEMALE\,
                                            \NHWAC_MALE\,\NHWAC_FEMALE\,
                                            \NHBAC_MALE\,\NHBAC_FEMALE\,\NHIAC_MALE\,
                                            \NHIAC_FEMALE\,\NHAAC_MALE\,
                                            \NHAAC_FEMALE\,\NHNAC_MALE\,
                                            \NHNAC_FEMALE\,\H_MALE\,\H_FEMALE\,
                                            \HWA_MALE\,\HWA_FEMALE\,\HBA_MALE\,
                                            \HBA_FEMALE\,\HIA_MALE\,\HIA_FEMALE\,
                                            \HAA_MALE\,\HAA_FEMALE\,\HNA_MALE\,
                                            \HNA_FEMALE\,\HTOM_MALE\,
                                            \HTOM_FEMALE\,\HWAC_MALE\,\HWAC_FEMALE\,
                                            \HBAC_MALE\,\HBAC_FEMALE\,
                                            \HIAC_MALE\,\HIAC_FEMALE\,\HAAC_MALE\,
                                            \HAAC_FEMALE\,\HNAC_MALE\,\HNAC_FEMALE\) %>%
                                             tolower(),
  
                            description = c(\State FIPS code\,
                                            \County FIPS code\,
                                            \State Name\,
                                            \County Name\,
                                            \Year\,
                                            \Age group\,
                                            \Total population\,
                                            \Total male population\,
                                            \Total female population\,
                                            \White alone male population\,
                                            \White alone female population\,
                                            \Black or African American alone male population\,
                                            \Black or African American alone female population\,
                                            \American Indian and Alaska Native alone male population\,
                                            \American Indian and Alaska Native alone female population\,
                                            \Asian alone male population\,
                                            \Asian alone female population\,
                                            \Native Hawaiian and Other Pacific Islander alone male population\,
                                            \Native Hawaiian and Other Pacific Islander alone female population\,
                                            \Two or More Races male population\,
                                            \Two or More Races female population\,
                                            \White alone or in combination male population\,
                                            \White alone or in combination female population\,
                                            \Black or African American alone or in combination male population\,
                                            \Black or African American alone or in combination female population\,
                                            \American Indian and Alaska Native alone or in combination male population\,
                                            \American Indian and Alaska Native alone or in combination female population\,
                                            \Asian alone or in combination male population\,
                                            \Asian alone or in combination female population\,
                                            \Native Hawaiian and Other Pacific Islander alone or in combination male population\,
                                            \Native Hawaiian and Other Pacific Islander alone or in combination female population\,\Not Hispanic male population\,
                                            \Not Hispanic female population\,
                                            \Not Hispanic
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



### Census 2019 Estimated Demographics

Skipping now that we have 2020 data above


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjpbInBfbG9hZCh0aWR5Y2Vuc3VzKSIsIiMgUGxvdCBvZiByYWNlL2V0aG5pY2l0eSBieSBjb3VudHkgaW4gSWxsaW5vaXMgZm9yIDIwMTAiLCJsaWJyYXJ5KHRpZHljZW5zdXMpIiwibGlicmFyeSh0aWR5dmVyc2UpIiwibGlicmFyeSh2aXJpZGlzKSIsImlmKGZyb21zY3JhdGNoKXsiLCIgIGNlbnN1c19hcGlfa2V5KFwiNWVkYjE3MzU2YTczNzVmZmYyNGUzNmU1M2NjMjc0OWM3OGZiMTFhZlwiKSIsIiAgY2Vuc3VzXzIwMTlfZXN0aW1hdGVzIDwtIGdldF9lc3RpbWF0ZXMoZ2VvZ3JhcGh5ID0gXCJjb3VudHlcIiwgIiwiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHllYXIgPSAyMDE5LCIsIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcm9kdWN0ID0gXCJjaGFyYWN0ZXJpc3RpY3NcIiwgIiwiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrZG93biA9IGMoXCJTRVhcIiwgXCJBR0VHUk9VUFwiLCBcIkhJU1BcIiwgJ1JBQ0UnKSwgICIsIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVha2Rvd25fbGFiZWxzID0gVFJVRSAsICIsIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjc3RhdGUgPSBcIkNBXCIsICIsIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjY291bnR5ID0gXCJMb3MgQW5nZWxlc1wiIiwiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNob3dfY2FsbD1UIiwiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICkiLCIgIHNhdmVSRFMoY2Vuc3VzXzIwMTlfZXN0aW1hdGVzLCBcIi9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YV9vdXQvcmhzL2NlbnN1c18yMDE5X2VzdGltYXRlcy5SZHNcIikiLCJ9IiwiY2Vuc3VzXzIwMTlfZXN0aW1hdGVzIDwtIHJlYWRSRFMoIFwiL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX291dC9yaHMvY2Vuc3VzXzIwMTlfZXN0aW1hdGVzLlJkc1wiKSIsIiIsIiNXZSB3YW50IHRvIGNvbGxhcHNlIGFnZSBncm91cHMgYXMgd2VsbCIsImNlbnN1c18yMDE5X2VzdGltYXRlc19hZ2Vncm91cHMgPC0gY2Vuc3VzXzIwMTlfZXN0aW1hdGVzICU+JSAiLCIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsZWFuX25hbWVzKCkgJT4lICIsIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGFnZV9ncm91cF9zdGFydCA9IGFnZWdyb3VwICU+JSBzdHJfbWF0Y2gocGF0dGVybj1cIkFnZSAoXFxcXGQrKSB0b1wiKSAlPiUgLlssMl0gJT4lIGFzLm51bWVyaWMoKSkgJT4lICAiLCIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG11dGF0ZShhZ2VfZ3JvdXBfZW5kID0gYWdlZ3JvdXAgJT4lIHN0cl9tYXRjaChwYXR0ZXJuPVwidG8gKFxcXFxkKykgeWVhcnNcIikgJT4lIC5bLDJdICU+JSBhcy5udW1lcmljKCkpICU+JSIsIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsdGVyKCFpcy5uYShhZ2VfZ3JvdXBfc3RhcnQpKSIsIiIsImFnZWN1dHMgPC0gY2Vuc3VzXzIwMTlfZXN0aW1hdGVzX2FnZWdyb3VwcyRhZ2VfZ3JvdXBfZW5kICU+JSB1bmlxdWUoKSIsImdyb3VwX2xpc3QgPC0gbGlzdCgpIiwiZm9yKGFnZWN1dCBpbiBhZ2VjdXRzKXsiLCIgIGRmIDwtIGNlbnN1c18yMDE5X2VzdGltYXRlc19hZ2Vncm91cHMgJT4lIG11dGF0ZShhZ2VjdXQ9YWdlY3V0KSAlPiUgbXV0YXRlKGFnZWN1dF9hYm92ZT0oYWdlX2dyb3VwX2VuZD5hZ2VjdXQpICU+JSBhcy5pbnRlZ2VyKCkpICU+JSBncm91cF9ieShhZ2VjdXRfYWJvdmUsIGdlb2lkLCBuYW1lLCBzZXgsaGlzcCxyYWNlICkgJT4lIHN1bW1hcmlzZSh2YWx1ZT1zdW0odmFsdWUpKSAlPiUiLCIgICAgbXV0YXRlKGFnZWdyb3VwPWlmZWxzZShhZ2VjdXRfYWJvdmU9PTAscGFzdGUwKFwiYXRfb3JfYmVsb3dfXCIsYWdlY3V0LFwiIHllYXJzXCIpLCBwYXN0ZTAoXCJhYm92ZV9cIixhZ2VjdXQsXCIgeWVhcnNcIikgICkgKSAlPiUgICIsIiAgICBtdXRhdGUoY2Vuc3VzXzIwMTlfcG9wdWxhdGlvbl9ncm91cCA9IHBhc3RlMChcImNlbnN1c18yMDE5X3BvcFwiLFwiX1wiLHNleCwgXCJfXCIsYWdlZ3JvdXAsXCJfXCIsIGhpc3AsIFwiX1wiLCByYWNlKSAlPiUgdG9sb3dlcigpICkgJT4lIHVuZ3JvdXAoKSIsIiAgZ3JvdXBfbGlzdFtbYXMuY2hhcmFjdGVyKGFnZWN1dCldXSA8LSBkZiIsIn0iLCIiLCJkZW1vZ3JhcGhpY3NfY2Vuc3VzX2dyb3VwcyA8LSAgYmluZF9yb3dzKGdyb3VwX2xpc3QpICAlPiUgZHBseXI6OnNlbGVjdChmaXBzPWdlb2lkLCB2YWx1ZSwgY2Vuc3VzXzIwMTlfcG9wdWxhdGlvbl9ncm91cCkiLCJkaW0oZGVtb2dyYXBoaWNzX2NlbnN1c19ncm91cHMpIiwiIiwiZGVtb2dyYXBoaWNzX2NlbnN1cyA8LSBjZW5zdXNfMjAxOV9lc3RpbWF0ZXMgJT4lICAiLCIgICAgICAgICAgICAgICAgICAgICAgICAgIGNsZWFuX25hbWVzKCkgJT4lIiwiICAgICAgICAgICAgICAgICAgICAgICAgICBtdXRhdGUoY2Vuc3VzXzIwMTlfcG9wdWxhdGlvbl9ncm91cCA9IHBhc3RlMChcImNlbnN1c18yMDE5X3BvcFwiLFwiX1wiLHNleCwgXCJfXCIsYWdlZ3JvdXAsXCJfXCIsIGhpc3AsIFwiX1wiLCByYWNlKSAlPiUgdG9sb3dlcigpICkgICU+JSIsIiAgICAgICAgICAgICAgICAgICAgICAgICAgZHBseXI6OnNlbGVjdChmaXBzPWdlb2lkLCB2YWx1ZSwgY2Vuc3VzXzIwMTlfcG9wdWxhdGlvbl9ncm91cCkiLCJkaW0oZGVtb2dyYXBoaWNzX2NlbnN1cykiLCIiLCJkZW1vZ3JhcGhpY3NfY2Vuc3VzX3dpZGUgPC0gYmluZF9yb3dzKGRlbW9ncmFwaGljc19jZW5zdXNfZ3JvdXBzLGRlbW9ncmFwaGljc19jZW5zdXMpICU+JSAiLCIgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGl2b3Rfd2lkZXIoaWRfY29scz1maXBzLCBuYW1lc19mcm9tPWNlbnN1c18yMDE5X3BvcHVsYXRpb25fZ3JvdXAsIHZhbHVlc19mcm9tPXZhbHVlKSAlPiUgIzIwOTIiLCIgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xlYW5fbmFtZXMoKSIsImRpbShkZW1vZ3JhcGhpY3NfY2Vuc3VzX3dpZGUpIiwiIiwiZGVtb2dyYXBoaWNzX2NlbnN1c19wZXJjIDwtICAgZGVtb2dyYXBoaWNzX2NlbnN1c193aWRlICU+JSIsIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG11dGF0ZShhY3Jvc3MoLWZpcHMsIH4gLiAvICBjZW5zdXNfMjAxOV9wb3BfYm90aF9zZXhlc19hbGxfYWdlc19ib3RoX2hpc3BhbmljX29yaWdpbnNfYWxsX3JhY2VzKSkgJT4lIGRwbHlyOjpzZWxlY3QoLWNlbnN1c18yMDE5X3BvcF9ib3RoX3NleGVzX2FsbF9hZ2VzX2JvdGhfaGlzcGFuaWNfb3JpZ2luc19hbGxfcmFjZXMpICU+JSIsIiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlbmFtZV9hdCh2YXJzKC1maXBzKSwgcGFzdGUwLCBcIl9wZXJjXCIpIiwiIiwicmhzX2RlbW9ncmFwaGljc19jZW5zdXMyMDE5IDwtIGNiaW5kKCIsIiAgZGVtb2dyYXBoaWNzX2NlbnN1c193aWRlIywgZGVtb2dyYXBoaWNzX2NlbnN1c19wZXJjIiwiICApICAlPiUgamFuaXRvcjo6cmVtb3ZlX2VtcHR5KCkgJT4lIGphbml0b3I6OnJlbW92ZV9jb25zdGFudCgpICU+JSBtdXRhdGVfaWYoaXMuY2hhcmFjdGVyLCBhcy5udW1lcmljKSIsImRpbShyaHNfZGVtb2dyYXBoaWNzX2NlbnN1czIwMTkpICMzMTQyIDExMzExIiwic2F2ZVJEUyhyaHNfZGVtb2dyYXBoaWNzX2NlbnN1czIwMTksIFwiL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX291dC9yaHMvcmhzX2RlbW9ncmFwaGljc19jZW5zdXMyMDE5LlJkc1wiKSJdfQ== -->

```r
p_load(tidycensus)
# Plot of race/ethnicity by county in Illinois for 2010
library(tidycensus)
library(tidyverse)
library(viridis)
if(fromscratch){
  census_api_key("5edb17356a7375fff24e36e53cc2749c78fb11af")
  census_2019_estimates <- get_estimates(geography = "county", 
                               year = 2019,
                               product = "characteristics", 
                               breakdown = c("SEX", "AGEGROUP", "HISP", 'RACE'),  
                               breakdown_labels = TRUE , 
                               #state = "CA", 
                               #county = "Los Angeles"
                               show_call=T
                               )
  saveRDS(census_2019_estimates, "/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/census_2019_estimates.Rds")
}
census_2019_estimates <- readRDS( "/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/census_2019_estimates.Rds")

#We want to collapse age groups as well
census_2019_estimates_agegroups <- census_2019_estimates %>% 
                                   clean_names() %>% 
                                   mutate(age_group_start = agegroup %>% str_match(pattern="Age (\\d+) to") %>% .[,2] %>% as.numeric()) %>%  
                                   mutate(age_group_end = agegroup %>% str_match(pattern="to (\\d+) years") %>% .[,2] %>% as.numeric()) %>%
                                   filter(!is.na(age_group_start))

agecuts <- census_2019_estimates_agegroups$age_group_end %>% unique()
group_list <- list()
for(agecut in agecuts){
  df <- census_2019_estimates_agegroups %>% mutate(agecut=agecut) %>% mutate(agecut_above=(age_group_end>agecut) %>% as.integer()) %>% group_by(agecut_above, geoid, name, sex,hisp,race ) %>% summarise(value=sum(value)) %>%
    mutate(agegroup=ifelse(agecut_above==0,paste0("at_or_below_",agecut," years"), paste0("above_",agecut," years")  ) ) %>%  
    mutate(census_2019_population_group = paste0("census_2019_pop","_",sex, "_",agegroup,"_", hisp, "_", race) %>% tolower() ) %>% ungroup()
  group_list[[as.character(agecut)]] <- df
}

demographics_census_groups <-  bind_rows(group_list)  %>% dplyr::select(fips=geoid, value, census_2019_population_group)
dim(demographics_census_groups)

demographics_census <- census_2019_estimates %>%  
                          clean_names() %>%
                          mutate(census_2019_population_group = paste0("census_2019_pop","_",sex, "_",agegroup,"_", hisp, "_", race) %>% tolower() )  %>%
                          dplyr::select(fips=geoid, value, census_2019_population_group)
dim(demographics_census)

demographics_census_wide <- bind_rows(demographics_census_groups,demographics_census) %>% 
                            pivot_wider(id_cols=fips, names_from=census_2019_population_group, values_from=value) %>% #2092
                            clean_names()
dim(demographics_census_wide)

demographics_census_perc <-   demographics_census_wide %>%
                              mutate(across(-fips, ~ . /  census_2019_pop_both_sexes_all_ages_both_hispanic_origins_all_races)) %>% dplyr::select(-census_2019_pop_both_sexes_all_ages_both_hispanic_origins_all_races) %>%
                              rename_at(vars(-fips), paste0, "_perc")

rhs_demographics_census2019 <- cbind(
  demographics_census_wide#, demographics_census_perc
  )  %>% janitor::remove_empty() %>% janitor::remove_constant() %>% mutate_if(is.character, as.numeric)
dim(rhs_demographics_census2019) #3142 11311
saveRDS(rhs_demographics_census2019, "/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_demographics_census2019.Rds")
```



<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### ACS

"
When to Use 1-year, 3-year, or 5-year Estimates"
https://www.census.gov/programs-surveys/acs/guidance/estimates.html


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5cbnBfbG9hZCh0aWR5Y2Vuc3VzKVxudmFyc19hY3M1IDwtIGxvYWRfdmFyaWFibGVzKDIwMTksIFxcYWNzNVxcLCBjYWNoZSA9IFRSVUUpICMyNywwNDBcblxuI1doYXQgd2UncmUgZ29pbmcgdG8gZG8gaXMgaXRlcmF0ZSBvdmVyIHRhYmxlc1xuXG50YWJsZXNfYWNzNSA8LSB2YXJzX2FjczUkbmFtZSAlPiUgc3RyX3NwbGl0KFxcX1xcLCBzaW1wbGlmeSA9IFQpXG50YWJsZXNfYWNzNSA8LSB0YWJsZXNfYWNzNVssMV0gJT4lIHVuaXF1ZSgpXG5mb3IocSBpbiB0YWJsZXNfYWNzNSl7XG4gIFxuICBvdXRmaWxlIDwtIGdsdWU6OmdsdWUoXFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzL2RhdGFfaW4vYWNzNS97cX1cXClcbiAgI3ByaW50KHEpXG4gIGlmKCFmaWxlLmV4aXN0cyhvdXRmaWxlKSl7XG4gICAgdHJ5KHtcbiAgICAgIHRlbXBfYWNzNV9kZiA8LSBnZXRfYWNzKGdlb2dyYXBoeSA9IFxcY291bnR5XFwsIFxuICAgICAgICAgICAgICAgICAgICAjdmFyaWFibGVzID0gYyhtZWRpbmNvbWUgPSBcXEIxOTAxM18wMDFcXCksIFxuICAgICAgICAgICAgICAgICAgICB0YWJsZT0gcSxcbiAgICAgICAgICAgICAgICAgICAgI3N0YXRlID0gXFxWVFxcLCBcbiAgICAgICAgICAgICAgICAgICAga2V5PVxcNWVkYjE3MzU2YTczNzVmZmYyNGUzNmU1M2NjMjc0OWM3OGZiMTFhZlxcLFxuICAgICAgICAgICAgICAgICAgICB5ZWFyID0gMjAxOSwgXG4gICAgICAgICAgICAgICAgICAgIGNhY2hlX3RhYmxlPVQsXG4gICAgICAgICAgICAgICAgICAgIHN1cnZleT1cXGFjczVcXFxuICAgICAgICAgICAgICAgICAgICApXG4gICAgICBcbiAgICAgIHRlbXBfYWNzNV9kZiAgJT4lIHJleF9jbGVhbigpICU+JSBhcnJvdzo6d3JpdGVfcGFycXVldChnbHVlOjpnbHVlKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX2luL2FjczUve3F9XFwpKVxuICAgIH0pXG4gIH1cbn1cblxudGVtcF9hY3M1X2RmX2FsbCA8LSBhcnJvdzo6b3Blbl9kYXRhc2V0KHNvdXJjZXM9XFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzL2RhdGFfaW4vYWNzNS9cXCkgJT4lIGNvbGxlY3QoKSAlPiUgY29sbGVjdCgpICU+JSBtdXRhdGUoZGF0YXNldD1cXGFjczFcXClcbmRpbSh0ZW1wX2FjczVfZGZfYWxsKSAjODcsMDYyLDM2MFxuXG4jVGhlIDMgeWVhciBzYW1wbGUgd2FzIGRpc2NvbnRpbnVlZCBpbiAyMDEzXG4jIHZhcnNfYWNzMyA8LSBsb2FkX3ZhcmlhYmxlcygyMDE5LCBcXGFjczNcXCwgY2FjaGUgPSBUUlVFKSAjXG4jIHRhYmxlc19hY3MzIDwtIHZhcnNfYWNzMyRuYW1lICU+JSBzdHJfc3BsaXQoXFxfXFwsIHNpbXBsaWZ5ID0gVClcbiMgdGFibGVzX2FjczMgPC0gdGFibGVzX2FjczNbLDFdICU+JSB1bmlxdWUoKVxuIyBmb3IocSBpbiB0YWJsZXNfYWNzMSl7XG4jICAgXG4jICAgb3V0ZmlsZSA8LSBnbHVlOjpnbHVlKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX2luL2FjczMve3F9XFwpXG4jICAgI3ByaW50KHEpXG4jICAgaWYoIWZpbGUuZXhpc3RzKG91dGZpbGUpKXtcbiMgICAgIHRyeSh7XG4jICAgICAgIHRlbXBfYWNzMV9kZiA8LSBnZXRfYWNzKGdlb2dyYXBoeSA9IFxcY291bnR5XFwsIFxuIyAgICAgICAgICAgICAgICAgICAgICN2YXJpYWJsZXMgPSBjKG1lZGluY29tZSA9IFxcQjE5MDEzXzAwMVxcKSwgXG4jICAgICAgICAgICAgICAgICAgICAgdGFibGU9IHEsXG4jICAgICAgICAgICAgICAgICAgICAgI3N0YXRlID0gXFxWVFxcLCBcbiMgICAgICAgICAgICAgICAgICAgICBrZXk9XFw1ZWRiMTczNTZhNzM3NWZmZjI0ZTM2ZTUzY2MyNzQ5Yzc4ZmIxMWFmXFwsXG4jICAgICAgICAgICAgICAgICAgICAgeWVhciA9IDIwMTksXG4jICAgICAgICAgICAgICAgICAgICAgY2FjaGVfdGFibGU9VCxcbiMgICAgICAgICAgICAgICAgICAgICBzdXJ2ZXk9XFxhY3MzXFxcbiMgICAgICAgICAgICAgICAgICAgICApXG4jICAgICAgIFxuIyAgICAgICB0ZW1wX2FjczNfZGYgICU+JSByZXhfY2xlYW4oKSAlPiUgYXJyb3c6OndyaXRlX3BhcnF1ZXQob3V0ZmlsZSlcbiMgICAgIH0pXG4jICAgfVxuIyB9XG5cbiNUaGUgMSB5ZWFyIGVzdGltYXRlIGlzIGF2YWlsYWJsZSBvbmx5IGZvciBwb3B1bGF0aW9ucyBncmVhdGVyIHRoYW4gNjVrXG52YXJzX2FjczEgPC0gbG9hZF92YXJpYWJsZXMoMjAxOSwgXFxhY3MxXFwsIGNhY2hlID0gVFJVRSkgIzM1LDUyOCAzNWsgdmFycyBmb3IgMSB5ZWFyXG50YWJsZXNfYWNzMSA8LSB2YXJzX2FjczEkbmFtZSAlPiUgc3RyX3NwbGl0KFxcX1xcLCBzaW1wbGlmeSA9IFQpXG50YWJsZXNfYWNzMSA8LSB0YWJsZXNfYWNzMVssMV0gJT4lIHVuaXF1ZSgpXG5mb3IocSBpbiB0YWJsZXNfYWNzMSl7XG4gIFxuICBvdXRmaWxlIDwtIGdsdWU6OmdsdWUoXFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzL2RhdGFfaW4vYWNzMS97cX1cXClcbiAgI3ByaW50KHEpXG4gIGlmKCFmaWxlLmV4aXN0cyhvdXRmaWxlKSl7XG4gICAgdHJ5KHtcbiAgICAgIHRlbXBfYWNzMV9kZiA8LSBnZXRfYWNzKGdlb2dyYXBoeSA9IFxcY291bnR5XFwsIFxuICAgICAgICAgICAgICAgICAgICAjdmFyaWFibGVzID0gYyhtZWRpbmNvbWUgPSBcXEIxOTAxM18wMDFcXCksIFxuICAgICAgICAgICAgICAgICAgICB0YWJsZT0gcSxcbiAgICAgICAgICAgICAgICAgICAgI3N0YXRlID0gXFxWVFxcLCBcbiAgICAgICAgICAgICAgICAgICAga2V5PVxcNWVkYjE3MzU2YTczNzVmZmYyNGUzNmU1M2NjMjc0OWM3OGZiMTFhZlxcLFxuICAgICAgICAgICAgICAgICAgICB5ZWFyID0gMjAxOSxcbiAgICAgICAgICAgICAgICAgICAgY2FjaGVfdGFibGU9VCxcbiAgICAgICAgICAgICAgICAgICAgc3VydmV5PVxcYWNzMVxcXG4gICAgICAgICAgICAgICAgICAgIClcbiAgICAgIFxuICAgICAgdGVtcF9hY3MxX2RmICAlPiUgcmV4X2NsZWFuKCkgJT4lIGFycm93Ojp3cml0ZV9wYXJxdWV0KG91dGZpbGUpXG4gICAgfSlcbiAgfVxufVxuXG50ZW1wX2FjczFfZGZfYWxsIDwtIGFycm93OjpvcGVuX2RhdGFzZXQoc291cmNlcz1cXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YV9pbi9hY3MxL1xcKSAlPiUgY29sbGVjdCgpICU+JSBtdXRhdGUoZGF0YXNldD1cXGFjczVcXClcbmRpbSh0ZW1wX2FjczFfZGZfYWxsKSAjODYsNTAyLDA4MFxuXG5zZXRkaWZmKHZhcnNfYWNzMSRuYW1lLHZhcnNfYWNzNSRuYW1lKSAlPiUgbGVuZ3RoKCkgIzg2NjJcbnNldGRpZmYodmFyc19hY3M1JG5hbWUsIHZhcnNfYWNzMSRuYW1lKSAlPiUgbGVuZ3RoKCkgIzE3NFxuXG52YXJzMSA8LSB0ZW1wX2FjczFfZGZfYWxsJHZhcmlhYmxlICU+JSB1bmlxdWUoKVxudmFyczIgPC0gdGVtcF9hY3M1X2RmX2FsbCR2YXJpYWJsZSAlPiUgdW5pcXVlKClcblxudGFibGVzX2Fjc2JvdGggPC0gcmJpbmQodGVtcF9hY3MxX2RmX2FsbCx0ZW1wX2FjczVfZGZfYWxsKSAlPiUgZGlzdGluY3QoKSAjMVxuZGltKHRhYmxlc19hY3Nib3RoKSAjMTgwLDg0MCw1MjAgICAgICAgIDUgIDE4MCBtaWxsaW9uXG5cbnZhcnNfYWxsIDwtIGJpbmRfcm93cygjdmFyc19hY3MxLFxuICAgICAgICAgICAgICAgICAgICAgIHZhcnNfYWNzNSkgJT4lIGRpc3RpbmN0KCkgIzM1LDcwMlxuXG52YXJzX2FsbF9jbGVhbiA8LSB2YXJzX2FsbCAlPiUgXG4gICAgICAgICAgICAgICAgICBtdXRhdGUoZGVzY3JpcHRpb24gPSBjb25jZXB0ICAlPiUgcGFzdGUwKFxcXG5gYGAifQ== -->

```r
```r


p_load(tidycensus)
vars_acs5 <- load_variables(2019, \acs5\, cache = TRUE) #27,040

#What we're going to do is iterate over tables

tables_acs5 <- vars_acs5$name %>% str_split(\_\, simplify = T)
tables_acs5 <- tables_acs5[,1] %>% unique()
for(q in tables_acs5){
  
  outfile <- glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_in/acs5/{q}\)
  #print(q)
  if(!file.exists(outfile)){
    try({
      temp_acs5_df <- get_acs(geography = \county\, 
                    #variables = c(medincome = \B19013_001\), 
                    table= q,
                    #state = \VT\, 
                    key=\5edb17356a7375fff24e36e53cc2749c78fb11af\,
                    year = 2019, 
                    cache_table=T,
                    survey=\acs5\
                    )
      
      temp_acs5_df  %>% rex_clean() %>% arrow::write_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_in/acs5/{q}\))
    })
  }
}

temp_acs5_df_all <- arrow::open_dataset(sources=\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_in/acs5/\) %>% collect() %>% collect() %>% mutate(dataset=\acs1\)
dim(temp_acs5_df_all) #87,062,360

#The 3 year sample was discontinued in 2013
# vars_acs3 <- load_variables(2019, \acs3\, cache = TRUE) #
# tables_acs3 <- vars_acs3$name %>% str_split(\_\, simplify = T)
# tables_acs3 <- tables_acs3[,1] %>% unique()
# for(q in tables_acs1){
#   
#   outfile <- glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_in/acs3/{q}\)
#   #print(q)
#   if(!file.exists(outfile)){
#     try({
#       temp_acs1_df <- get_acs(geography = \county\, 
#                     #variables = c(medincome = \B19013_001\), 
#                     table= q,
#                     #state = \VT\, 
#                     key=\5edb17356a7375fff24e36e53cc2749c78fb11af\,
#                     year = 2019,
#                     cache_table=T,
#                     survey=\acs3\
#                     )
#       
#       temp_acs3_df  %>% rex_clean() %>% arrow::write_parquet(outfile)
#     })
#   }
# }

#The 1 year estimate is available only for populations greater than 65k
vars_acs1 <- load_variables(2019, \acs1\, cache = TRUE) #35,528 35k vars for 1 year
tables_acs1 <- vars_acs1$name %>% str_split(\_\, simplify = T)
tables_acs1 <- tables_acs1[,1] %>% unique()
for(q in tables_acs1){
  
  outfile <- glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_in/acs1/{q}\)
  #print(q)
  if(!file.exists(outfile)){
    try({
      temp_acs1_df <- get_acs(geography = \county\, 
                    #variables = c(medincome = \B19013_001\), 
                    table= q,
                    #state = \VT\, 
                    key=\5edb17356a7375fff24e36e53cc2749c78fb11af\,
                    year = 2019,
                    cache_table=T,
                    survey=\acs1\
                    )
      
      temp_acs1_df  %>% rex_clean() %>% arrow::write_parquet(outfile)
    })
  }
}

temp_acs1_df_all <- arrow::open_dataset(sources=\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_in/acs1/\) %>% collect() %>% mutate(dataset=\acs5\)
dim(temp_acs1_df_all) #86,502,080

setdiff(vars_acs1$name,vars_acs5$name) %>% length() #8662
setdiff(vars_acs5$name, vars_acs1$name) %>% length() #174

vars1 <- temp_acs1_df_all$variable %>% unique()
vars2 <- temp_acs5_df_all$variable %>% unique()

tables_acsboth <- rbind(temp_acs1_df_all,temp_acs5_df_all) %>% distinct() #1
dim(tables_acsboth) #180,840,520        5  180 million

vars_all <- bind_rows(#vars_acs1,
                      vars_acs5) %>% distinct() #35,702

vars_all_clean <- vars_all %>% 
                  mutate(description = concept  %>% paste0(\
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->







### BEA


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuI0JFQSBDb3VudHkgTGV2ZWwgRWNvbm9taWMgTWVhc3VyZXNcbiNodHRwczovL2FwcHMuYmVhLmdvdi9yZWdpb25hbC9kb3dubG9hZHppcC5jZm1cblxuZm5hbWVzIDwtIGxpc3QuZmlsZXMoXFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzL2RhdGEvQ0FHRFAyL1xcLCBwYXR0ZXJuID0gXFxjc3ZcXCwgZnVsbC5uYW1lcyA9IFQpXG5iZWEgPC0gbGFwcGx5KGZuYW1lcywgZnJlYWQsIHNlcD1cXFxuYGBgIn0= -->

```r
```r
#BEA County Level Economic Measures
#https://apps.bea.gov/regional/downloadzip.cfm

fnames <- list.files(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/CAGDP2/\, pattern = \csv\, full.names = T)
bea <- lapply(fnames, fread, sep=\
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




## Quarterly Census of Employment and Wages
https://www.bls.gov/cew/downloadable-data-files.htm


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG4jSSB0aGluayB3aGF0IHdlIGRvIGhlcmUgaXMgc3Vic2V0IGluZHVzdHJ5X2NvZGUgLCBzdXBlcnNlY3Rwciwgb3Igc2VjdG9yIGJ1dCBub3QgMyB0byA2IGRpZ2l0IGRpc2FnZywgYW5kIHRoZW4gd2UganVzdCB3YW50IHRoZSBudW1iZXIgb2YgZW1wbG95ZWVzIGluIGVhY2ggXG4jYW5udWFsX2F2Z19lbXBsdmwgICNhdmVyYWdlIG51bWJlciBvZiBlbXBsb3llZXMgaW4gdGhhdCBzZWN0b3IgaW4gMjAyMFxuI290eV9hbm51YWxfYXZnX2VtcGx2bF9wY3RfY2hnICAjcGVyY2VudCBjaGFuZ2UgZnJvbSAyMDE5XG5cbmZpbGVzIDwtIGxpc3QuZmlsZXMocGF0aCA9IFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX2luLzIwMjAuYW5udWFsLmJ5X2FyZWEvXFwsIHBhdHRlcm4gPSBOVUxMLCBhbGwuZmlsZXMgPSBGQUxTRSxcbiAgICAgICAgICAgZnVsbC5uYW1lcyA9IFQsIHJlY3Vyc2l2ZSA9IEZBTFNFLFxuICAgICAgICAgICBpZ25vcmUuY2FzZSA9IEZBTFNFLCBpbmNsdWRlLmRpcnMgPSBGQUxTRSwgbm8uLiA9IEZBTFNFKVxucXVhdGVybHlfY2Vuc3VzX29mX2VtcGxveW1lbnQgPC0gbGFwcGx5KGZpbGVzLCBmcmVhZCkgJT4lIHJiaW5kbGlzdCgpXG5kaW0ocXVhdGVybHlfY2Vuc3VzX29mX2VtcGxveW1lbnQpICMzLDU5OCwyNzBcblxucXVhdGVybHlfY2Vuc3VzX29mX2VtcGxveW1lbnRfc2VjdG9yIDwtIHF1YXRlcmx5X2NlbnN1c19vZl9lbXBsb3ltZW50ICU+JSBmaWx0ZXIoYWdnbHZsX3RpdGxlICU+JSBzdHJfZGV0ZWN0KFxcTkFJQ1MgU2VjdG9yfFN0YXRlXG5gYGAifQ== -->

```r
```r

#I think what we do here is subset industry_code , supersectpr, or sector but not 3 to 6 digit disagg, and then we just want the number of employees in each 
#annual_avg_emplvl  #average number of employees in that sector in 2020
#oty_annual_avg_emplvl_pct_chg  #percent change from 2019

files <- list.files(path = \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_in/2020.annual.by_area/\, pattern = NULL, all.files = FALSE,
           full.names = T, recursive = FALSE,
           ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)
quaterly_census_of_employment <- lapply(files, fread) %>% rbindlist()
dim(quaterly_census_of_employment) #3,598,270

quaterly_census_of_employment_sector <- quaterly_census_of_employment %>% filter(agglvl_title %>% str_detect(\NAICS Sector|State
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Politics


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5wb2xpdGljcyA8LSBmcmVhZChcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YS9jb3VudHlwcmVzXzIwMDAtMjAyMC5jc3ZcXClcblxudGVtcDEgPC0gcG9saXRpY3MgJT4lIGZpbHRlcihtb2RlPT1cXFRPVEFMXFwsIHBhcnR5PT1cXFJFUFVCTElDQU5cXCkgJT4lIFxuICAgICAgICBtdXRhdGUocGVyY2VudD1jYW5kaWRhdGV2b3Rlcy90b3RhbHZvdGVzKSAlPiUgXG4gICAgICAgIG11dGF0ZShjYW5kaWRhdGVfeWVhcj0gY2FuZGlkYXRlICU+JSB0b2xvd2VyKCkgJT4lIHN0cl9yZXBsYWNlX2FsbChcXCBcXCxcXF9cXCkgICU+JSBzdHJfcmVwbGFjZV9hbGwoXFxbXmEtel1cXCxcXFxcKSAlPiUgcGFzdGUwKFxcX1xcLHllYXIpICkgJT4lIFxuICAgICAgICBkcGx5cjo6c2VsZWN0KGNvdW50eV9maXBzLCBwZXJjZW50LGNhbmRpZGF0ZXZvdGVzLCBjYW5kaWRhdGVfeWVhcikgJT4lXG4gICAgICAgIGZpbHRlcighaXMubmEoY291bnR5X2ZpcHMpKSBcblxudGVtcDIgPC0gcG9saXRpY3MgJT4lIGZpbHRlcihtb2RlIT1cXFRPVEFMXFwsIHBhcnR5PT1cXFJFUFVCTElDQU5cXCAmIHllYXI9PTIwMjApICU+JSBcbiAgICAgICAgICBtdXRhdGUoY2FuZGlkYXRlX3llYXI9IGNhbmRpZGF0ZSAlPiUgdG9sb3dlcigpICU+JSBzdHJfcmVwbGFjZV9hbGwoXFwgXFwsXFxfXFwpICAlPiUgc3RyX3JlcGxhY2VfYWxsKFxcW15hLXpdXFwsXFxcXCkgJT4lIHBhc3RlMChcXF9cXCx5ZWFyKSApICU+JSBcbiAgICAgICAgICBncm91cF9ieShjb3VudHlfZmlwcywgY2FuZGlkYXRlX3llYXIpICU+JVxuICAgICAgICAgIHN1bW1hcmlzZShjYW5kaWRhdGV2b3Rlcz1zdW0oY2FuZGlkYXRldm90ZXMpLCB0b3RhbHZvdGVzPW1heCh0b3RhbHZvdGVzKSkgJT4lXG4gICAgICAgICAgbXV0YXRlKHBlcmNlbnQ9Y2FuZGlkYXRldm90ZXMvdG90YWx2b3RlcykgJT4lIFxuICAgICAgICAgIGRwbHlyOjpzZWxlY3QoY291bnR5X2ZpcHMsIHBlcmNlbnQsY2FuZGlkYXRldm90ZXMsY2FuZGlkYXRlX3llYXIpICU+JVxuICAgICAgICAgIGZpbHRlcighaXMubmEoY291bnR5X2ZpcHMpKSBcblxucG9saXRpY3Nfc2hhcmUgPC0gYmluZF9yb3dzKHRlbXAxLHRlbXAyKSAlPiVcbiAgICAgICAgICAgICAgICAgIGRwbHlyOjpmaWx0ZXIoIWR1cGxpY2F0ZWQocGFzdGUwKGNvdW50eV9maXBzLGNhbmRpZGF0ZV95ZWFyKSkpICU+JSBcbiAgICAgICAgICAgICAgICAgIHRpZHlyOjpwaXZvdF93aWRlcihpZF9jb2xzPWNvdW50eV9maXBzLCBuYW1lc19mcm9tPWNhbmRpZGF0ZV95ZWFyLHZhbHVlc19mcm9tPXBlcmNlbnQpICU+JSByZW5hbWUoZmlwcz1jb3VudHlfZmlwcylcblxucG9saXRpY3Nfdm90ZXMgPC0gYmluZF9yb3dzKHRlbXAxLHRlbXAyKSAlPiVcbiAgICAgICAgICAgICAgICAgIGRwbHlyOjpmaWx0ZXIoIWR1cGxpY2F0ZWQocGFzdGUwKGNvdW50eV9maXBzLGNhbmRpZGF0ZV95ZWFyKSkpICU+JVxuICAgICAgICAgICAgICAgICAgdGlkeXI6OnBpdm90X3dpZGVyKGlkX2NvbHM9Y291bnR5X2ZpcHMsIG5hbWVzX2Zyb209Y2FuZGlkYXRlX3llYXIsdmFsdWVzX2Zyb209Y2FuZGlkYXRldm90ZXMpICU+JSByZW5hbWUoZmlwcz1jb3VudHlfZmlwcylcblxuXG5yaHNfcG9saXRpY3MgPC0gY2JpbmQocG9saXRpY3Nfc2hhcmUgJT4lIHJlbmFtZV9hdCh2YXJzKC1maXBzKSwgcGFzdGUwLCBcXF9wZXJjXFwpICMsXG4gICAgICAgICAgICAgICAgICAgICAgI3BvbGl0aWNzX3ZvdGVzICU+JSByZW5hbWVfYXQodmFycygtZmlwcyksIHBhc3RlMCwgXFxfdm90ZXNcXCkgJT4lIGRwbHlyOjpzZWxlY3QoLWZpcHMpXG4gICAgICAgICAgICAgICAgICAgICAgKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICByZW5hbWVfYXQodmFycygtZmlwcyksZnVuY3Rpb24oeCl7cGFzdGUwKFxccG9saXRpY3NfXFwsIHgpfSlcblxucmhzX3BvbGl0aWNzX2xvbmcgPC0gcmhzX3BvbGl0aWNzICU+JSBwaXZvdF9sb25nZXIoLWZpcHMpICU+JSBcbiAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGRlc2NyaXB0aW9uID0gbmFtZSkgJT4lIFxuICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGRhdGFzZXQ9XFxNSVQgRWxlY3Rpb24gRGF0YSBhbmQgU2NpZW5jZSBMYWJcbmBgYCJ9 -->

```r
```r

politics <- fread(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/countypres_2000-2020.csv\)

temp1 <- politics %>% filter(mode==\TOTAL\, party==\REPUBLICAN\) %>% 
        mutate(percent=candidatevotes/totalvotes) %>% 
        mutate(candidate_year= candidate %>% tolower() %>% str_replace_all(\ \,\_\)  %>% str_replace_all(\[^a-z]\,\\) %>% paste0(\_\,year) ) %>% 
        dplyr::select(county_fips, percent,candidatevotes, candidate_year) %>%
        filter(!is.na(county_fips)) 

temp2 <- politics %>% filter(mode!=\TOTAL\, party==\REPUBLICAN\ & year==2020) %>% 
          mutate(candidate_year= candidate %>% tolower() %>% str_replace_all(\ \,\_\)  %>% str_replace_all(\[^a-z]\,\\) %>% paste0(\_\,year) ) %>% 
          group_by(county_fips, candidate_year) %>%
          summarise(candidatevotes=sum(candidatevotes), totalvotes=max(totalvotes)) %>%
          mutate(percent=candidatevotes/totalvotes) %>% 
          dplyr::select(county_fips, percent,candidatevotes,candidate_year) %>%
          filter(!is.na(county_fips)) 

politics_share <- bind_rows(temp1,temp2) %>%
                  dplyr::filter(!duplicated(paste0(county_fips,candidate_year))) %>% 
                  tidyr::pivot_wider(id_cols=county_fips, names_from=candidate_year,values_from=percent) %>% rename(fips=county_fips)

politics_votes <- bind_rows(temp1,temp2) %>%
                  dplyr::filter(!duplicated(paste0(county_fips,candidate_year))) %>%
                  tidyr::pivot_wider(id_cols=county_fips, names_from=candidate_year,values_from=candidatevotes) %>% rename(fips=county_fips)


rhs_politics <- cbind(politics_share %>% rename_at(vars(-fips), paste0, \_perc\) #,
                      #politics_votes %>% rename_at(vars(-fips), paste0, \_votes\) %>% dplyr::select(-fips)
                      ) %>%
                      rename_at(vars(-fips),function(x){paste0(\politics_\, x)})

rhs_politics_long <- rhs_politics %>% pivot_longer(-fips) %>% 
                       mutate(description = name) %>% 
                        mutate(dataset=\MIT Election Data and Science Lab
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## NYT Masking


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->



<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



### covidcast

I think what we do here is add the hesitancy in December question that's
available for 768 counties as a predictor. We form some hypothesis and
finish by taking them to the data for the 369 with specific reasons
which is present day


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxucF9sb2FkKGNvdmlkY2FzdClcbnBfbG9hZChkcGx5cilcbiNBbHJlYWR5IGJlZW4gb3Igd2FudCB0byBcbiNzbW9vdGhlZF93Y292aWRfdmFjY2luYXRlZF9vcl9hY2NlcHRcdFxuI0Rpc2NvbnRpbnVlZCBhcyBvZiBXYXZlIDExLCBNYXkgMTksIDIwMjEgRXN0aW1hdGVkIHBlcmNlbnRhZ2Ugb2YgcmVzcG9uZGVudHMgd2hvIGVpdGhlciBoYXZlIGFscmVhZHkgcmVjZWl2ZWQgYSBDT1ZJRCB2YWNjaW5lIG9yIHdvdWxkIGRlZmluaXRlbHkgb3IgcHJvYmFibHkgY2hvb3NlIHRvIGdldCB2YWNjaW5hdGVkLCBpZiBhIHZhY2NpbmUgd2VyZSBvZmZlcmVkIHRvIHRoZW0gdG9kYXkuXG4jRWFybGllc3QgZGF0ZSBhdmFpbGFibGU6IDIwMjEtMDEtMDZcbnNtb290aGVkX3djb3ZpZF92YWNjaW5hdGVkX29yX2FjY2VwdCA8LSBzdXBwcmVzc01lc3NhZ2VzKGNvdmlkY2FzdF9zaWduYWwoZGF0YV9zb3VyY2UgPSBcXGZiLXN1cnZleVxcLCBzaWduYWwgPSBjKFxcc21vb3RoZWRfd2NvdmlkX3ZhY2NpbmF0ZWRfb3JfYWNjZXB0XFwpLHN0YXJ0X2RheSA9IFxcMjAyMC0xMS0wMVxcLCBlbmRfZGF5ID0gXFwyMDIxLTA3LTAxXFwsZ2VvX3R5cGUgPSBcXGNvdW50eVxcKSlcbiN0YWJsZShzbW9vdGhlZF93Y292aWRfdmFjY2luYXRlZF9vcl9hY2NlcHQkZ2VvX3ZhbHVlKSAjb25seSBhdmFpbGFibGUgZm9yIDc2OCBjb3VudGllc1xuXG4jT25seSBhdmFpbGFibGUgZm9yIDczOSBjb3VudGllc1xuc21vb3RoZWRfd2NvdmlkX3ZhY2NpbmF0ZWRfb3JfYWNjZXB0JGdlb192YWx1ZSAlPiUgdW5pcXVlKCkgJT4lIGxlbmd0aCgpICM3NjhcbnJoc19kZWxwaGkgPC0gc21vb3RoZWRfd2NvdmlkX3ZhY2NpbmF0ZWRfb3JfYWNjZXB0ICU+JSBcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmaWx0ZXIodGltZV92YWx1ZTw9YXMuRGF0ZShcXDIwMjEtMDEtMDdcXCkpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlbGVjdChmaXBzPWdlb192YWx1ZSwgc21vb3RoZWRfd2NvdmlkX3ZhY2NpbmF0ZWRfb3JfYWNjZXB0PXZhbHVlKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBncm91cF9ieShmaXBzKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdW1tYXJpc2Uoc21vb3RoZWRfd2NvdmlkX3ZhY2NpbmF0ZWRfb3JfYWNjZXB0PW1lYW4oc21vb3RoZWRfd2NvdmlkX3ZhY2NpbmF0ZWRfb3JfYWNjZXB0LCBuYS5ybT1UKSkgJT4lXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGRlc2NyaXB0aW9uPVxccGVyY2VudCBvZiBwZW9wbGUgc2VsZiByZXBvcnQgd291bGQgYWNjZXB0IHZhY2NpbmF0aW9uXFwpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG11dGF0ZSh2YXJpYWJsZT1cXGRlbHBoaV9mYl9wZXJjZW50X2FjY2VwdF92YWNjaW5hdGlvblxcKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZW5hbWUodmFsdWU9c21vb3RoZWRfd2NvdmlkX3ZhY2NpbmF0ZWRfb3JfYWNjZXB0KSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdXRhdGUoZGF0YXNldD1cXGRlbHBoaV9mYlxcKVxuICBcblxucmhzX2RlbHBoaSAgJT4lIHJleF9jbGVhbigpICU+JSBhcnJvdzo6d3JpdGVfcGFycXVldChnbHVlOjpnbHVlKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX291dC9yaHMvcmhzX2RlbHBoaS5wYXJxdWV0XFwpKVxuXG5cbmBgYFxuYGBgIn0= -->

```r
```r
p_load(covidcast)
p_load(dplyr)
#Already been or want to 
#smoothed_wcovid_vaccinated_or_accept	
#Discontinued as of Wave 11, May 19, 2021 Estimated percentage of respondents who either have already received a COVID vaccine or would definitely or probably choose to get vaccinated, if a vaccine were offered to them today.
#Earliest date available: 2021-01-06
smoothed_wcovid_vaccinated_or_accept <- suppressMessages(covidcast_signal(data_source = \fb-survey\, signal = c(\smoothed_wcovid_vaccinated_or_accept\),start_day = \2020-11-01\, end_day = \2021-07-01\,geo_type = \county\))
#table(smoothed_wcovid_vaccinated_or_accept$geo_value) #only available for 768 counties

#Only available for 739 counties
smoothed_wcovid_vaccinated_or_accept$geo_value %>% unique() %>% length() #768
rhs_delphi <- smoothed_wcovid_vaccinated_or_accept %>% 
                                              filter(time_value<=as.Date(\2021-01-07\)) %>%
                                              select(fips=geo_value, smoothed_wcovid_vaccinated_or_accept=value) %>%
                                              group_by(fips) %>%
                                              summarise(smoothed_wcovid_vaccinated_or_accept=mean(smoothed_wcovid_vaccinated_or_accept, na.rm=T)) %>%
                                              mutate(description=\percent of people self report would accept vaccination\) %>%
                                              mutate(variable=\delphi_fb_percent_accept_vaccination\) %>%
                                              rename(value=smoothed_wcovid_vaccinated_or_accept) %>%
                                              mutate(dataset=\delphi_fb\)
  

rhs_delphi  %>% rex_clean() %>% arrow::write_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_delphi.parquet\))

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Safegraph


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG4jQ291bnR5IEZsb3dzXG5mbmFtZXMgPC0gbGlzdC5maWxlcyhcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YV90ZW1wL0NPVklEMTlVU0Zsb3dzL3dlZWtseV9mbG93cy9jb3VudHkyY291bnR5XFwsIHBhdHRlcm4gPSBcXGNzdlxcLCBmdWxsLm5hbWVzID0gVClcbmZsb3dzX2NvdW50eTJjb3VudHkgPC0gcmJpbmRsaXN0KGxhcHBseShmbmFtZXMsIGZyZWFkKSwgZmlsbD1UKSAlPiUgXG4gICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGRhdGVfcmFuZ2Vfc3RhcnQ9ZGF0ZV9yYW5nZSAlPiUgc3RyaW5ncjo6c3RyX3NwbGl0KFxcIC0gXFwsIHNpbXBsaWZ5PVQpICU+JSAuWywxXSAlPiUgYXMuRGF0ZSgpKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsdGVyKGRhdGVfcmFuZ2Vfc3RhcnQ8PWFzLkRhdGUoXFwyMDIwLTExLTA0XFwpKSAjY3V0b2ZmIGF0IHRoZSBlbGVjdGlvblxuIzI1LDU0Myw2MDhcblxuI1RoZXNlIGFyZSBwb3AgZmxvd3MgZnJvbSBBIHRvIEFcbmZsb3dzX2NvdW50eTJjb3VudHlfc2VsZnZpc2l0cyA8LSBmbG93c19jb3VudHkyY291bnR5ICU+JSBkcGx5cjo6ZmlsdGVyKGdlb2lkX289PWdlb2lkX2QpICU+JSBcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBncm91cF9ieShmaXBzPWdlb2lkX28pICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN1bW1hcmlzZShwb3B1bGF0aW9uX2Zsb3dzX3NlbGZfdG90YWw9c3VtKHBvcF9mbG93cykpXG5cblxuI1RoZXNlIGFyZSBwb3AgZmxvd3MgZnJvbSBBIHRvIEJcbmZsb3dzX2NvdW50eTJjb3VudHlfZXh0ZXJuYWx2aXNpdHMgPC0gZmxvd3NfY291bnR5MmNvdW50eSAlPiUgZHBseXI6OmZpbHRlcihnZW9pZF9vIT1nZW9pZF9kKSAgICU+JSBcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3JvdXBfYnkoZmlwcz1nZW9pZF9vKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3VtbWFyaXNlKHBvcHVsYXRpb25fZmxvd3NfZXh0ZXJuYWxfdG90YWw9c3VtKHBvcF9mbG93cykpXG5cbiNUaGVzZSBhcmUgcG9wIGZsb3dzIGZyb20gQiB0byBBXG5mbG93c19jb3VudHkyY291bnR5X2Zyb21leHRlcm5hbHZpc2l0cyA8LSBmbG93c19jb3VudHkyY291bnR5ICU+JSBkcGx5cjo6ZmlsdGVyKGdlb2lkX28hPWdlb2lkX2QpICU+JSBcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsdGVyKGRhdGVfcmFuZ2Vfc3RhcnQ8PWFzLkRhdGUoXFwyMDIwLTExLTA0XFwpKSAlPiUgXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdyb3VwX2J5KGZpcHM9Z2VvaWRfZCkgJT4lXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN1bW1hcmlzZShwb3B1bGF0aW9uX2Zsb3dzX2Zyb21fZXh0ZXJuYWxfdG90YWw9c3VtKHBvcF9mbG93cykpXG5cbnNhZmVncmFwaCA8LSBmbG93c19jb3VudHkyY291bnR5X3NlbGZ2aXNpdHMgJT4lIFxuICAgICAgICAgICAgIGZ1bGxfam9pbihmbG93c19jb3VudHkyY291bnR5X2V4dGVybmFsdmlzaXRzKSAlPiVcbiAgICAgICAgICAgICBmdWxsX2pvaW4oZmxvd3NfY291bnR5MmNvdW50eV9mcm9tZXh0ZXJuYWx2aXNpdHMpIFxuXG5cbnJoc19zYWZlZ3JhcGggPC0gc2FmZWdyYXBoICU+JSBcbiAgICAgICAgICAgICAgICAgbXV0YXRlKHBvcHVsYXRpb25fZmxvd3NfZXh0ZXJuYWxfcmF0aW9fdG9faW50ZXJuYWwgPSBwb3B1bGF0aW9uX2Zsb3dzX2V4dGVybmFsX3RvdGFsL3BvcHVsYXRpb25fZmxvd3Nfc2VsZl90b3RhbCkgJT4lXG4gICAgICAgICAgICAgICAgIG11dGF0ZShwb3B1bGF0aW9uX2Zsb3dzX2Zyb21fZXh0ZXJuYWxfdG90YWxfcmF0aW9fdG9faW50ZXJuYWwgPSBwb3B1bGF0aW9uX2Zsb3dzX2Zyb21fZXh0ZXJuYWxfdG90YWwvcG9wdWxhdGlvbl9mbG93c19zZWxmX3RvdGFsKSAlPiVcbiAgICAgICAgICAgICAgICAgbXV0YXRlKHBvcHVsYXRpb25fZmxvd3NfcmF0aW9faW5fdG9fb3V0ID0gcG9wdWxhdGlvbl9mbG93c19leHRlcm5hbF90b3RhbC9wb3B1bGF0aW9uX2Zsb3dzX2Zyb21fZXh0ZXJuYWxfdG90YWwpICU+JSBcbiAgICAgICAgICAgICAgICAgcGl2b3RfbG9uZ2VyKC1maXBzKSAlPiVcbiAgICAgICAgICAgICAgICAgbXV0YXRlKGRlc2NyaXB0aW9uPXBhc3RlMChcXG1vYmlsaXR5IFxcLCBuYW1lKSkgJT4lXG4gICAgICAgICAgICAgICAgIG11dGF0ZSh2YXJpYWJsZT1wYXN0ZTAoXFxzYWZlZ3JhcGhfXFwsIG5hbWUpKSAlPiVcbiAgICAgICAgICAgICAgICAgbXV0YXRlKGRhdGFzZXQ9XFxzYWZlZ3JhcGhcXCkgJT4lIGRwbHlyOjpzZWxlY3QoLW5hbWUpXG5cbnJoc19zYWZlZ3JhcGggICU+JSByZXhfY2xlYW4oKSAlPiUgYXJyb3c6OndyaXRlX3BhcnF1ZXQoZ2x1ZTo6Z2x1ZShcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YV9vdXQvcmhzL3Joc19zYWZlZ3JhcGgucGFycXVldFxcKSlcblxuXG5gYGBcbmBgYCJ9 -->

```r
```r

#County Flows
fnames <- list.files(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_temp/COVID19USFlows/weekly_flows/county2county\, pattern = \csv\, full.names = T)
flows_county2county <- rbindlist(lapply(fnames, fread), fill=T) %>% 
                         mutate(date_range_start=date_range %>% stringr::str_split(\ - \, simplify=T) %>% .[,1] %>% as.Date()) %>%
                                      filter(date_range_start<=as.Date(\2020-11-04\)) #cutoff at the election
#25,543,608

#These are pop flows from A to A
flows_county2county_selfvisits <- flows_county2county %>% dplyr::filter(geoid_o==geoid_d) %>% 
                                  group_by(fips=geoid_o) %>%
                                  summarise(population_flows_self_total=sum(pop_flows))


#These are pop flows from A to B
flows_county2county_externalvisits <- flows_county2county %>% dplyr::filter(geoid_o!=geoid_d)   %>% 
                                      group_by(fips=geoid_o) %>%
                                      summarise(population_flows_external_total=sum(pop_flows))

#These are pop flows from B to A
flows_county2county_fromexternalvisits <- flows_county2county %>% dplyr::filter(geoid_o!=geoid_d) %>% 
                                      filter(date_range_start<=as.Date(\2020-11-04\)) %>% 
                                      group_by(fips=geoid_d) %>%
                                      summarise(population_flows_from_external_total=sum(pop_flows))

safegraph <- flows_county2county_selfvisits %>% 
             full_join(flows_county2county_externalvisits) %>%
             full_join(flows_county2county_fromexternalvisits) 


rhs_safegraph <- safegraph %>% 
                 mutate(population_flows_external_ratio_to_internal = population_flows_external_total/population_flows_self_total) %>%
                 mutate(population_flows_from_external_total_ratio_to_internal = population_flows_from_external_total/population_flows_self_total) %>%
                 mutate(population_flows_ratio_in_to_out = population_flows_external_total/population_flows_from_external_total) %>% 
                 pivot_longer(-fips) %>%
                 mutate(description=paste0(\mobility \, name)) %>%
                 mutate(variable=paste0(\safegraph_\, name)) %>%
                 mutate(dataset=\safegraph\) %>% dplyr::select(-name)

rhs_safegraph  %>% rex_clean() %>% arrow::write_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_safegraph.parquet\))

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

## Infections


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5mbmFtZXMgPC0gbGlzdC5maWxlcyhcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YV90ZW1wL2NvdmlkMTktaW5mZWN0aW9uLWVzdGltYXRlcy1sYXRlc3QvY291bnRpZXNcXCwgcGF0dGVybiA9IFxcXmxhdGVzdF9cXCwgZnVsbC5uYW1lcyA9IFQpXG5jb3ZpZCA8LSByYmluZGxpc3QobGFwcGx5KGZuYW1lcywgZnJlYWQpLCBmaWxsPVQpXG5cbmNvdmlkX2NvdW50cyA8LSBjb3ZpZCAlPiUgZHBseXI6OmZpbHRlcihkYXRlPT1hcy5EYXRlKFxcMjAyMC0xMS0wNFxcKSkgICU+JVxuICAgICAgICAgICAgICAgICAgICBkcGx5cjo6c2VsZWN0KGZpcHMsIHRvdGFsX2RlYXRocywgdG90YWxfY2FzZXMsIHRvdGFsX2luZmVjdGVkX21lYW4pICU+JVxuICAgICAgICAgICAgICAgICAgICBtdXRhdGUocmF0aW9fZXN0aW1hdGVkX2Nhc2VzX3RvX21lYXN1cmVkPXRvdGFsX2luZmVjdGVkX21lYW4vdG90YWxfY2FzZXMpXG5cbnJoc19jb3ZpZCA8LSAgICAgY292aWRfY291bnRzICU+JSBwaXZvdF9sb25nZXIoLWZpcHMpICU+JVxuICAgICAgICAgICAgICAgICBtdXRhdGUoZGVzY3JpcHRpb249cGFzdGUwKFxcQ09WSUQgaW5mZWN0aW9ucyBcXCwgbmFtZSkpICU+JVxuICAgICAgICAgICAgICAgICBtdXRhdGUodmFyaWFibGU9cGFzdGUwKFxcY292aWQxOXByb2plY3Rpb25zX1xcLCBuYW1lKSkgJT4lXG4gICAgICAgICAgICAgICAgIG11dGF0ZShkYXRhc2V0PVxcY292aWQxOXByb2plY3Rpb25zXFwpICU+JSBkcGx5cjo6c2VsZWN0KC1uYW1lKVxuXG5yaHNfY292aWQgICU+JSByZXhfY2xlYW4oKSAlPiUgYXJyb3c6OndyaXRlX3BhcnF1ZXQoZ2x1ZTo6Z2x1ZShcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YV9vdXQvcmhzL3Joc19jb3ZpZC5wYXJxdWV0XFwpKVxuXG5gYGBcbmBgYCJ9 -->

```r
```r

fnames <- list.files(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_temp/covid19-infection-estimates-latest/counties\, pattern = \^latest_\, full.names = T)
covid <- rbindlist(lapply(fnames, fread), fill=T)

covid_counts <- covid %>% dplyr::filter(date==as.Date(\2020-11-04\))  %>%
                    dplyr::select(fips, total_deaths, total_cases, total_infected_mean) %>%
                    mutate(ratio_estimated_cases_to_measured=total_infected_mean/total_cases)

rhs_covid <-     covid_counts %>% pivot_longer(-fips) %>%
                 mutate(description=paste0(\COVID infections \, name)) %>%
                 mutate(variable=paste0(\covid19projections_\, name)) %>%
                 mutate(dataset=\covid19projections\) %>% dplyr::select(-name)

rhs_covid  %>% rex_clean() %>% arrow::write_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_covid.parquet\))

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## Geography


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5wX2xvYWQocm5hdHVyYWxlYXJ0aClcbnBfbG9hZChybmF0dXJhbGVhcnRoZGF0YSlcbmNvYXN0bGluZXMgPC0gbmVfY29hc3RsaW5lKHNjYWxlID0gMTEwLCByZXR1cm5jbGFzcyA9IGMoXFxzZlxcKSlcbiNjb3VudGllc190aWdyaXNfc2YgPC0gdGlncmlzOjpjb3VudGllcyhzdGF0ZSA9IE5VTEwsIGNiID0gRkFMU0UsIHJlc29sdXRpb24gPSBcXDVtXFwsIHllYXIgPSAyMDE5KVxuXG4jZ2cgPC0gZ2dwbG90KClcbiNnZyA8LSBnZyArIGdlb21fc2YoZGF0YSA9IGNvdW50aWVzX3NmLCBjb2xvcj1cXGJsYWNrXFwsXG4jICAgICAgICAgICAgICAgICAgIGZpbGw9XFx3aGl0ZVxcLCBzaXplPTAuMjUpXG4jZ2dcblxuXG5gYGBcbmBgYCJ9 -->

```r
```r

p_load(rnaturalearth)
p_load(rnaturalearthdata)
coastlines <- ne_coastline(scale = 110, returnclass = c(\sf\))
#counties_tigris_sf <- tigris::counties(state = NULL, cb = FALSE, resolution = \5m\, year = 2019)

#gg <- ggplot()
#gg <- gg + geom_sf(data = counties_sf, color=\black\,
#                   fill=\white\, size=0.25)
#gg

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### Google Mobility


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5nb29nbGVfbW9iaWxpdHkyMDIwIDwtIGZyZWFkKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhLzIwMjBfVVNfUmVnaW9uX01vYmlsaXR5X1JlcG9ydC5jc3ZcXClcbmdvb2dsZV9tb2JpbGl0eTIwMjEgPC0gZnJlYWQoXFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzL2RhdGEvMjAyMV9VU19SZWdpb25fTW9iaWxpdHlfUmVwb3J0LmNzdlxcKVxuXG5nb29nbGVfbW9iaWxpdHkgPC0gYmluZF9yb3dzKGdvb2dsZV9tb2JpbGl0eTIwMjAsIGdvb2dsZV9tb2JpbGl0eTIwMjEgKVxucmhzX2dvb2dsZW1vYmlsaXR5IDwtIGdvb2dsZV9tb2JpbGl0eSAlPiUgcmVuYW1lKGZpcHM9Y2Vuc3VzX2ZpcHNfY29kZSkgJT4lXG4gICAgICAgICAgICAgICAgICAgICAgICAgIGZpbHRlcihkYXRlPD1hcy5EYXRlKFxcMjAyMC0xMS0wNFxcKSkgJT4lICNjdXRvZmYgYXQgdGhlIGVsZWN0aW9uXG4gICAgICAgICAgICAgICAgICAgICAgICAgIGdyb3VwX2J5KGZpcHMpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICBzdW1tYXJpemVfaWYoaXMubnVtZXJpYywgbWVhbiwgbmEucm09VCkgJT4lIFxuICAgICAgICAgICAgICAgICAgICAgICAgICBtdXRhdGVfaWYoaXMubnVtZXJpYywgfnJlcGxhY2UoLiwgaXMubmFuKC4pLCBOQSkpICAlPiUgXG4gICAgICAgICAgICAgICAgICAgICAgICAgcGl2b3RfbG9uZ2VyKC1maXBzKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIG11dGF0ZShkZXNjcmlwdGlvbj1wYXN0ZTAoXFxtb2JpbGl0eSBcXCwgbmFtZSkpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKHZhcmlhYmxlPXBhc3RlMChcXGdvb2dsZV9cXCwgbmFtZSkpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGRhdGFzZXQ9XFxnb29nbGVcXCkgJT4lIGRwbHlyOjpzZWxlY3QoLW5hbWUpXG5cblxucmhzX2dvb2dsZW1vYmlsaXR5ICAlPiUgcmV4X2NsZWFuKCkgJT4lIGFycm93Ojp3cml0ZV9wYXJxdWV0KGdsdWU6OmdsdWUoXFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzL2RhdGFfb3V0L3Jocy9yaHNfZ29vZ2xlbW9iaWxpdHkucGFycXVldFxcKSlcblxuXG5gYGBcbmBgYCJ9 -->

```r
```r

google_mobility2020 <- fread(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/2020_US_Region_Mobility_Report.csv\)
google_mobility2021 <- fread(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/2021_US_Region_Mobility_Report.csv\)

google_mobility <- bind_rows(google_mobility2020, google_mobility2021 )
rhs_googlemobility <- google_mobility %>% rename(fips=census_fips_code) %>%
                          filter(date<=as.Date(\2020-11-04\)) %>% #cutoff at the election
                          group_by(fips) %>%
                          summarize_if(is.numeric, mean, na.rm=T) %>% 
                          mutate_if(is.numeric, ~replace(., is.nan(.), NA))  %>% 
                         pivot_longer(-fips) %>%
                           mutate(description=paste0(\mobility \, name)) %>%
                           mutate(variable=paste0(\google_\, name)) %>%
                           mutate(dataset=\google\) %>% dplyr::select(-name)


rhs_googlemobility  %>% rex_clean() %>% arrow::write_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_googlemobility.parquet\))

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### GEography 


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjpbImRpc3RhbmNlX3RvX2NvYXN0IDwtIHN0X2Rpc3RhbmNlKCIsIiAgeD1jb3VudGllc19zZl90aWdyaXMgJT4lIHN0X3RyYW5zZm9ybShjcnMgPSBzdF9jcnMoY29hc3RsaW5lcykpLCIsIiAgeT1jb2FzdGxpbmVzICU+JSBzdF9jb21iaW5lKCksIiwiICBieV9lbGVtZW50ID0gVCIsIiAgKSIsIiIsImRpc3RhbmNlX3RvX2NvYXN0X2RmIDwtIGNvdW50aWVzX3NmX3RpZ3JpcyAlPiUgYXMuZGF0YS5mcmFtZSgpICAlPiUgZHBseXI6Om11dGF0ZShmaXBzPSBwYXN0ZTAoU1RBVEVGUCxDT1VOVFlGUCkgJT4lIGFzLm51bWVyaWMoKSkgJT4lIG11dGF0ZShkaXN0YW5jZV90b19jb2FzdF9rbT0gYXMubnVtZXJpYyhkaXN0YW5jZV90b19jb2FzdC8xMDAwKSkgJT4lIGRwbHlyOjpzZWxlY3QoZmlwcywgZGlzdGFuY2VfdG9fY29hc3Rfa20pIl19 -->

```r
distance_to_coast <- st_distance(
  x=counties_sf_tigris %>% st_transform(crs = st_crs(coastlines)),
  y=coastlines %>% st_combine(),
  by_element = T
  )

distance_to_coast_df <- counties_sf_tigris %>% as.data.frame()  %>% dplyr::mutate(fips= paste0(STATEFP,COUNTYFP) %>% as.numeric()) %>% mutate(distance_to_coast_km= as.numeric(distance_to_coast/1000)) %>% dplyr::select(fips, distance_to_coast_km)
```



<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### Vaccine Providers


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG4jVmFjY2luZSBQcm92aWRlcnNcbiNodHRwczovL2dpdGh1Yi5jb20vR29vZ2xlQ2xvdWRQbGF0Zm9ybS9jb3ZpZC0xOS1vcGVuLWRhdGEvYmxvYi9tYWluL2RvY3MvdGFibGUtdmFjY2luYXRpb24tYWNjZXNzLm1kXG5mYWNpbGl0aWVzIDwtIGZyZWFkKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhL2ZhY2lsaXR5LWJvdW5kYXJ5LXVzLWFsbC5jc3ZcXClcblxuZmFjaWxpdGllc19zbWFsbCA8LSBmYWNpbGl0aWVzICU+JSBkcGx5cjo6c2VsZWN0KC1mYWNpbGl0eV9jYXRjaG1lbnRfYm91bmRhcnksIC1tb2RlX29mX3RyYW5zcG9ydGF0aW9uLCAtdHJhdmVsX3RpbWVfdGhyZXNob2xkX21pbnV0ZXMpICU+JSBkaXN0aW5jdCgpICNcbmRpbShmYWNpbGl0aWVzX3NtYWxsKSAjNTU1NDQgICAgMTJcblxucmhzX2NvdmlkZmFjaWxpdGllcyA8LSBmYWNpbGl0aWVzX3NtYWxsICU+JSBncm91cF9ieShmaXBzPWZhY2lsaXR5X3N1Yl9yZWdpb25fMl9jb2RlKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgc3VtbWFyaXNlKHZhY2NpbmVfZmFjaWxpdGllc19jb3VudD1uKCkpICU+JSBcbiAgICAgICAgICAgICAgICAgICAgICAgICBwaXZvdF9sb25nZXIoLWZpcHMpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGRlc2NyaXB0aW9uPXBhc3RlMChcXHN1cHBseSBcXCwgbmFtZSkpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKHZhcmlhYmxlPXBhc3RlMChcXGdvb2dsZV9cXCwgbmFtZSkpICU+JVxuICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGRhdGFzZXQ9XFxnb29nbGVcXCkgJT4lIGRwbHlyOjpzZWxlY3QoLW5hbWUpXG5cblxucmhzX2NvdmlkZmFjaWxpdGllcyAgJT4lIHJleF9jbGVhbigpICU+JSBhcnJvdzo6d3JpdGVfcGFycXVldChnbHVlOjpnbHVlKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX291dC9yaHMvcmhzX2NvdmlkZmFjaWxpdGllcy5wYXJxdWV0XFwpKVxuXG5cbmBgYFxuYGBgIn0= -->

```r
```r

#Vaccine Providers
#https://github.com/GoogleCloudPlatform/covid-19-open-data/blob/main/docs/table-vaccination-access.md
facilities <- fread(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/facility-boundary-us-all.csv\)

facilities_small <- facilities %>% dplyr::select(-facility_catchment_boundary, -mode_of_transportation, -travel_time_threshold_minutes) %>% distinct() #
dim(facilities_small) #55544    12

rhs_covidfacilities <- facilities_small %>% group_by(fips=facility_sub_region_2_code) %>%
                          summarise(vaccine_facilities_count=n()) %>% 
                         pivot_longer(-fips) %>%
                           mutate(description=paste0(\supply \, name)) %>%
                           mutate(variable=paste0(\google_\, name)) %>%
                           mutate(dataset=\google\) %>% dplyr::select(-name)


rhs_covidfacilities  %>% rex_clean() %>% arrow::write_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_covidfacilities.parquet\))

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



### Vaccine Distributors (vaccines.gov)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG52YWNjaW5lc19nb3YgPC0gZnJlYWQoXFxodHRwczovL2RhdGEuY2RjLmdvdi9hcGkvdmlld3MvNWpwMi1wZ2F3L3Jvd3MuY3N2P2FjY2Vzc1R5cGU9RE9XTkxPQURcXClcblxudmFjY2luZXNfZ292X2NvdW50aWVzIDwtIHZhY2NpbmVzX2dvdiAlPiUgXG4gICAgICAgICAgICAgICAgICAgICAgICAgIGZpbHRlcighaXMubmEobGF0aXR1ZGUpKSAlPiUgI3RoZXJlJ3MgYSBoYW5kZnVsIG1pc3NpbmcgbGF0bG9uZ1xuICAgICAgICAgICAgICAgICAgICAgICAgICBzdF9hc19zZihjb29yZHM9YygnbG9uZ2l0dWRlJywnbGF0aXR1ZGUnKSwgY3JzPXN0X2Nycyhjb3VudGllc19zZl90aWdyaXMpKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgc3Rfam9pbihjb3VudGllc19zZl90aWdyaXMgJT4lIGRwbHlyOjpzZWxlY3QoZmlwcz1HRU9JRCkpXG5cbnJoc192YWNjaW5lc19nb3ZfY291bnRpZXMgPC0gXG52YWNjaW5lc19nb3ZfY291bnRpZXMgJT4lIGFzLmRhdGEuZnJhbWUoKSAlPiVcbiAgZ3JvdXBfYnkoZmlwcykgJT4lIFxuICBzdW1tYXJpc2Uoc3VwcGx5X2xvY2F0aW9ucyA9IHN1bSghaXMubmEocHJvdmlkZXJfbG9jYXRpb25fZ3VpZCksIG5hLnJtPVQpLFxuICAgICAgICAgICAgc3VwcGx5X2xvY2F0aW9uc19pbnN0b2NrID0gc3VtKGluX3N0b2NrLCBuYS5ybT1UKSxcbiAgICAgICAgICAgIHN1cHBseV9sb2NhdGlvbnNfd2Fsa2luID0gc3VtKCB3YWxraW5zX2FjY2VwdGVkLCBuYS5ybT1UKSxcbiAgICAgICAgICAgIHN1cHBseV9sb2NhdGlvbnNfaW5zdXJhbmNlID0gc3VtKCB3YWxraW5zX2FjY2VwdGVkLCBuYS5ybT1UKSxcbiAgICAgICAgICAgIHN1cHBseV9sb2NhdGlvbnNfaW5zdG9ja193YWxraW4gPSBzdW0oaW5fc3RvY2sgJiB3YWxraW5zX2FjY2VwdGVkLCBuYS5ybT1UKSxcbiAgICAgICAgICAgIHN1cHBseV9sb2NhdGlvbnNfaW5zdG9ja19pbnN1cmFuY2UgPSBzdW0oaW5fc3RvY2sgJiB3YWxraW5zX2FjY2VwdGVkLCBuYS5ybT1UKSxcbiAgICAgICAgICAgICkgJT4lXG4gICAgICAgICAgcGl2b3RfbG9uZ2VyKC1maXBzKSAlPiVcbiAgICAgICAgICAgbXV0YXRlKGRlc2NyaXB0aW9uPXBhc3RlMChcXHZhY2NpbmUgXFwsIG5hbWUpKSAlPiVcbiAgICAgICAgICAgbXV0YXRlKHZhcmlhYmxlPXBhc3RlMChcXHZhY2NpbmVkb3Rnb3ZfXFwsIG5hbWUpKSAlPiVcbiAgICAgICAgICAgbXV0YXRlKGRhdGFzZXQ9XFx2YWNjaW5lZG90Z292XFwpICU+JSBkcGx5cjo6c2VsZWN0KC1uYW1lKVxuXG5cbnJoc192YWNjaW5lc19nb3ZfY291bnRpZXMgICU+JSByZXhfY2xlYW4oKSAlPiUgYXJyb3c6OndyaXRlX3BhcnF1ZXQoZ2x1ZTo6Z2x1ZShcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YV9vdXQvcmhzL3Joc192YWNjaW5lc19nb3ZfY291bnRpZXMucGFycXVldFxcKSlcblxuYGBgXG5gYGAifQ== -->

```r
```r

vaccines_gov <- fread(\https://data.cdc.gov/api/views/5jp2-pgaw/rows.csv?accessType=DOWNLOAD\)

vaccines_gov_counties <- vaccines_gov %>% 
                          filter(!is.na(latitude)) %>% #there's a handful missing latlong
                          st_as_sf(coords=c('longitude','latitude'), crs=st_crs(counties_sf_tigris)) %>%
                          st_join(counties_sf_tigris %>% dplyr::select(fips=GEOID))

rhs_vaccines_gov_counties <- 
vaccines_gov_counties %>% as.data.frame() %>%
  group_by(fips) %>% 
  summarise(supply_locations = sum(!is.na(provider_location_guid), na.rm=T),
            supply_locations_instock = sum(in_stock, na.rm=T),
            supply_locations_walkin = sum( walkins_accepted, na.rm=T),
            supply_locations_insurance = sum( walkins_accepted, na.rm=T),
            supply_locations_instock_walkin = sum(in_stock & walkins_accepted, na.rm=T),
            supply_locations_instock_insurance = sum(in_stock & walkins_accepted, na.rm=T),
            ) %>%
          pivot_longer(-fips) %>%
           mutate(description=paste0(\vaccine \, name)) %>%
           mutate(variable=paste0(\vaccinedotgov_\, name)) %>%
           mutate(dataset=\vaccinedotgov\) %>% dplyr::select(-name)


rhs_vaccines_gov_counties  %>% rex_clean() %>% arrow::write_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_vaccines_gov_counties.parquet\))

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


## countyhealthrankings


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG4jaHR0cHM6Ly93d3cuY291bnR5aGVhbHRocmFua2luZ3Mub3JnL2V4cGxvcmUtaGVhbHRoLXJhbmtpbmdzL3JhbmtpbmdzLWRhdGEtZG9jdW1lbnRhdGlvblxuYTAwIDwtIGZyZWFkKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhL2NvdW50eWhlYWx0aHJhbmtpbmdzL2FuYWx5dGljX2RhdGEyMDIxLmNzdlxcKSAlPiUgY2xlYW5fbmFtZXMoKVxuXG4jT24gaG93IHRoZXkgZ2V0IGNvdW50eSBlc3RpbWF0ZXMgd2hlbiB0aGUgdW5pdCBpcyBNTVNBXG4jaHR0cHM6Ly93d3cuY2RjLmdvdi9icmZzcy9zbWFydC9zbWFydF9mYXEuaHRtXG4jT2J0YWluaW5nIGxvY2FsIGRhdGEgZnJvbSBCZWhhdmlvciBSaXNrIEZhY3RvciBTdXJ2ZWlsbGFuY2UgU3lzdGVtIChCUkZTUylcbiNodHRwczovL3d3dy5jaXR5bWF0Y2gub3JnL3dwLWNvbnRlbnQvdXBsb2Fkcy8yMDE4LzEyL09idGFpbmluZy1sb2NhbC1kYXRhLWZyb20tQmVoYXZpb3ItUmlzay1GYWN0b3ItU3VydmVpbGxhbmNlLnBkZlxuXG5yaHNfY291bnR5aGVhbHRocmFua2luZ3MgPC0gYTAwICU+JSBkcGx5cjo6c2VsZWN0KFxuICBmaXBzPXg1X2RpZ2l0X2ZpcHNfY29kZSwgXG4gIHBvb3Jfb3JfZmFpcl9oZWFsdGhfcGVyY19icmZzczIwMTggPSBwb29yX29yX2ZhaXJfaGVhbHRoX3Jhd192YWx1ZSxcbiAgbG93X2JpcnRod2VpZ2h0X3BlcmNfbmNoczIwMTk9bG93X2JpcnRod2VpZ2h0X3Jhd192YWx1ZSxcbiAgYWR1bHRfc21va2luZ19wZXJjX2JyZnNzMjAxOD1hZHVsdF9zbW9raW5nX3Jhd192YWx1ZSxcbiAgYWR1bHRfb2Jlc2l0eV9wZXJjX2RzczIwMTc9YWR1bHRfb2Jlc2l0eV9yYXdfdmFsdWUsICNVbml0ZWQgU3RhdGVzIERpYWJldGVzIFN1cnZlaWxsYW5jZSBTeXN0ZW1cbiAgdW5pbnN1cmVkX3BlcmNfc2FoaTIwMTggPXVuaW5zdXJlZF9yYXdfdmFsdWUsICNTbWFsbCBBcmVhIEhlYWx0aCBJbnN1cmFuY2UgRXN0aW1hdGVzXG4gIHByaW1hcnlfY2FyZV9waHlzaWNpYW5zX3BlcmNhcF8yMDE4ID1wcmltYXJ5X2NhcmVfcGh5c2ljaWFuc19yYXdfdmFsdWUsICNBcmVhIEhlYWx0aCBSZXNvdXJjZSBGaWxlL0FtZXJpY2FuIE1lZGljYWwgQXNzb2NpYXRpb25cbiAgZGVudGlzdHNfcGVyY2FwXzIwMTkgPWRlbnRpc3RzX3Jhd192YWx1ZSwgI0FyZWEgSGVhbHRoIFJlc291cmNlIEZpbGUvTmF0aW9uYWwgUHJvdmlkZXIgSWRlbnRpZmljYXRpb24gZmlsZVxuICBtZW50YWxfaGVhbHRoX3Byb3ZpZGVyc19wZXJjYXBfMjAyMCA9bWVudGFsX2hlYWx0aF9wcm92aWRlcnNfcmF3X3ZhbHVlICwgI0NNUyBOYXRpb25hbCBQcm92aWRlciBJZGVudGlmaWNhdGlvblxuICBwcmV2ZW50YWJsZV9ob3NwaXRhbF9zdGF5c19wZXJjYXAyMDE4ID1wcmV2ZW50YWJsZV9ob3NwaXRhbF9zdGF5c19yYXdfdmFsdWUsICNSYXRlIG9mIGhvc3BpdGFsIHN0YXlzIGZvciBhbWJ1bGF0b3J5LWNhcmUgc2Vuc2l0aXZlIGNvbmRpdGlvbnMgcGVyIDEwMCwwMDAgTWVkaWNhcmUgZW5yb2xsZWVzLlxuICBtYW1tb2dyYXBoeV9zY3JlZW5pbmdfcGVyY2FwMjAxOCA9bWFtbW9ncmFwaHlfc2NyZWVuaW5nX3Jhd192YWx1ZSwgI1BlcmNlbnRhZ2Ugb2YgZmVtYWxlIE1lZGljYXJlIGVucm9sbGVlcyBhZ2VzIDY1LTc0IHRoYXQgcmVjZWl2ZWQgYW4gYW5udWFsIG1hbW1vZ3JhcGh5IHNjcmVlbmluZy5cbiAgZmx1X3ZhY2NpbmF0aW9uc19wZXJjX21lZGljYXJlMjAxOCA9Zmx1X3ZhY2NpbmF0aW9uc19yYXdfdmFsdWUgI1BlcmNlbnRhZ2Ugb2YgZmVlLWZvci1zZXJ2aWNlIChGRlMpIE1lZGljYXJlIGVucm9sbGVlcyB0aGF0IGhhZCBhbiBhbm51YWwgZmx1IHZhY2NpbmF0aW9uLlxuKSAlPiVcbiAgcGl2b3RfbG9uZ2VyKC1maXBzKSAlPiVcbiAgIG11dGF0ZShkZXNjcmlwdGlvbj1wYXN0ZTAoXFxcXCwgbmFtZSkpICU+JVxuICAgbXV0YXRlKHZhcmlhYmxlPXBhc3RlMChcXGNvdW50eWhlYWx0aHJhbmtpbmdzX1xcLCBuYW1lKSkgJT4lXG4gICBtdXRhdGUoZGF0YXNldD1cXGNvdW50eWhlYWx0aHJhbmtpbmdzXFwpICU+JSBkcGx5cjo6c2VsZWN0KC1uYW1lKVxuXG5yaHNfY291bnR5aGVhbHRocmFua2luZ3MgICU+JSByZXhfY2xlYW4oKSAlPiUgYXJyb3c6OndyaXRlX3BhcnF1ZXQoZ2x1ZTo6Z2x1ZShcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YV9vdXQvcmhzL3Joc19jb3VudHloZWFsdGhyYW5raW5ncy5wYXJxdWV0XFwpKVxuXG5cbmBgYFxuYGBgIn0= -->

```r
```r

#https://www.countyhealthrankings.org/explore-health-rankings/rankings-data-documentation
a00 <- fread(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/countyhealthrankings/analytic_data2021.csv\) %>% clean_names()

#On how they get county estimates when the unit is MMSA
#https://www.cdc.gov/brfss/smart/smart_faq.htm
#Obtaining local data from Behavior Risk Factor Surveillance System (BRFSS)
#https://www.citymatch.org/wp-content/uploads/2018/12/Obtaining-local-data-from-Behavior-Risk-Factor-Surveillance.pdf

rhs_countyhealthrankings <- a00 %>% dplyr::select(
  fips=x5_digit_fips_code, 
  poor_or_fair_health_perc_brfss2018 = poor_or_fair_health_raw_value,
  low_birthweight_perc_nchs2019=low_birthweight_raw_value,
  adult_smoking_perc_brfss2018=adult_smoking_raw_value,
  adult_obesity_perc_dss2017=adult_obesity_raw_value, #United States Diabetes Surveillance System
  uninsured_perc_sahi2018 =uninsured_raw_value, #Small Area Health Insurance Estimates
  primary_care_physicians_percap_2018 =primary_care_physicians_raw_value, #Area Health Resource File/American Medical Association
  dentists_percap_2019 =dentists_raw_value, #Area Health Resource File/National Provider Identification file
  mental_health_providers_percap_2020 =mental_health_providers_raw_value , #CMS National Provider Identification
  preventable_hospital_stays_percap2018 =preventable_hospital_stays_raw_value, #Rate of hospital stays for ambulatory-care sensitive conditions per 100,000 Medicare enrollees.
  mammography_screening_percap2018 =mammography_screening_raw_value, #Percentage of female Medicare enrollees ages 65-74 that received an annual mammography screening.
  flu_vaccinations_perc_medicare2018 =flu_vaccinations_raw_value #Percentage of fee-for-service (FFS) Medicare enrollees that had an annual flu vaccination.
) %>%
  pivot_longer(-fips) %>%
   mutate(description=paste0(\\, name)) %>%
   mutate(variable=paste0(\countyhealthrankings_\, name)) %>%
   mutate(dataset=\countyhealthrankings\) %>% dplyr::select(-name)

rhs_countyhealthrankings  %>% rex_clean() %>% arrow::write_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_countyhealthrankings.parquet\))

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


##


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjpbImEwIDwtIGZyZWFkKFwiL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhL1ZhY2NpbmF0aW9uX0NvdmVyYWdlX2Ftb25nX1lvdW5nX0NoaWxkcmVuX18wLTM1X01vbnRoc18uY3N2XCIpICU+JSBjbGVhbl9uYW1lcygpIiwiIiwiYTBfY2xlYW4gPC0gYTAgJT4lIG11dGF0ZSh2YWNjaW5hdGVkPWVzdGltYXRlX3BlcmNlbnQqc2FtcGxlX3NpemUpICU+JSBncm91cF9ieSh2YWNjaW5lLCBnZW9ncmFwaHkpICU+JSBzdW1tYXJpc2UodmFjY2luYXRlZD1zdW0odmFjY2luYXRlZCksIHNhbXBsZV9zaXplPXN1bShzYW1wbGVfc2l6ZSkpICU+JSBtdXRhdGUodmFjY2luYXRlZF9wZXJjPXZhY2NpbmF0ZWQvc2FtcGxlX3NpemUpIiwidGFibGUoYTBfY2xlYW4kdmFjY2luZSwgYTBfY2xlYW4kZ2VvZ3JhcGh5KSAjVGhlcmUncyBhIGNvdXBsZSBvZiB2YWNjaW5lcyBtaXNzaW5nIGF0IHRoZSBjb3VudCBhbmQgUFIgbGV2ZWwgYnV0IHRoZSBzdGF0ZXMgaGF2ZSBhbGwgb2YgdGhlbS4iLCIiLCJhMF9jbGVhbl9zdGF0ZSA8LSBhMCAlPiUgbXV0YXRlKHZhY2NpbmF0ZWQ9ZXN0aW1hdGVfcGVyY2VudCpzYW1wbGVfc2l6ZSkgJT4lIGdyb3VwX2J5KGdlb2dyYXBoeSkgJT4lIHN1bW1hcmlzZSh2YWNjaW5hdGVkPXN1bSh2YWNjaW5hdGVkKSwgc2FtcGxlX3NpemU9c3VtKHNhbXBsZV9zaXplKSkgJT4lIG11dGF0ZSh2YWNjaW5hdGVkX3BlcmM9dmFjY2luYXRlZC9zYW1wbGVfc2l6ZSkiLCIiLCIjaGlzdChhMF9jbGVhbl9zdGF0ZSR2YWNjaW5hdGVkX3BlcmMpIiwiIiwic3RhdGVfcHJldmlvdXNfY2hpbGRfdmFjY2luYXRlZF9wZXJjIDwtIGEwX2NsZWFuX3N0YXRlICU+JSBkcGx5cjo6c2VsZWN0KG5hbWVfc3RhdGU9Z2VvZ3JhcGh5LCBwcmV2aW91c19jaGlsZF92YWNjaW5hdGVkX3BlcmM9dmFjY2luYXRlZF9wZXJjKSAlPiUiLCIgIGxlZnRfam9pbihzdGF0ZXNfc2ZfdGlncmlzICU+JSBtdXRhdGUoZmlwc19zdGF0ZT1hcy5udW1lcmljKFNUQVRFRlApKjEwMDApICU+JSBhcy5kYXRhLmZyYW1lKCkgJT4lIGRwbHlyOjpzZWxlY3QobmFtZV9zdGF0ZT1OQU1FLGZpcHNfc3RhdGUpICkgJT4lIGRwbHlyOjpmaWx0ZXIoIWlzLm5hKGZpcHNfc3RhdGUpKSIsIiIsIiNhIDwtIGZyZWFkKFwiMTk3Ni0yMDIwLXByZXNpZGVudC5jc3ZcIikiLCIiLCJhIDwtIGZyZWFkKFwiaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL255dGltZXMvY292aWQtMTktZGF0YS9tYXN0ZXIvdXMtY291bnRpZXMuY3N2XCIpICU+JSIsIiAgICAgZmlsdGVyKGRhdGU9PVwiMjAyMC0xMS0wNFwiKSAlPiUgZHBseXI6OnNlbGVjdChmaXBzLCBkZWF0aHMpIiwiIiwiI2IgPC0gZnJlYWQoXCIvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzLzIwMTJwcmVzLmNzdlwiKSAlPiUgY2xlYW5fbmFtZXMoKSAlPiUiLCIjICAgICBtdXRhdGUocm9tbmV5X3BlcmM9MTAwKndpbGxhcmRfbWl0dF9yb21uZXkgLyAoYmFyYWNrX2hfb2JhbWEgKyB3aWxsYXJkX21pdHRfcm9tbmV5KSkgJT4lIiwiIyAgICBkcGx5cjo6c2VsZWN0KGZpcHMscm9tbmV5X3BlcmMpIiwiIiwiI2MgPC0gZnJlYWQoXCIvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzLzIwMjBwcmVzLmNzdlwiKSAlPiUgY2xlYW5fbmFtZXMoKSAlPiUgIiwiIyAgICAgbXV0YXRlKHRydW1wX3BlcmM9MTAwKmRvbmFsZF9qX3RydW1wIC8gKGpvc2VwaF9yX2JpZGVuX2pyICsgZG9uYWxkX2pfdHJ1bXApKSAlPiUiLCIjICAgICBkcGx5cjo6c2VsZWN0KGZpcHMsdHJ1bXBfcGVyYykiLCIiLCIjRG9uJ3QgbmVlZCBhbnltb3JlIiwiI2QgPC0gcmVhZFJEUyhcIi9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvY2MtZXN0MjAxOS1hbGxkYXRhLlJkc1wiKSAlPiUgY2xlYW5fbmFtZXMoKSAlPiUiLCIjICAgICBmaWx0ZXIoeWVhcj09MTIsIGFnZWdycD09MCkgJT4lIiwiIyAgICAgbXV0YXRlKGJsYWNrX3BlcmMgPSAxMDAqKGJhY19tYWxlICsgYmFjX2ZlbWFsZSkvdG90X3BvcCkgJT4lIiwiIyAgICAgbXV0YXRlKG5hdGl2ZV9wZXJjID0gMTAwKihpYWNfbWFsZSArIGlhY19mZW1hbGUpL3RvdF9wb3ApICU+JSIsIiMgICAgIG11dGF0ZShoaXNwYW5pY19wZXJjID0gMTAwKihoX21hbGUgKyBoX2ZlbWFsZSkvdG90X3BvcCkgJT4lIiwiIyAgICAgbXV0YXRlKGZpcHM9cGFzdGUwKHN0YXRlLHN0cl9wYWQoY291bnR5LCAzLCBwYWQgPSBcIjBcIikgKSAlPiUgYXMubnVtZXJpYygpICApICU+JSIsIiMgICAgIGRwbHlyOjpzZWxlY3QoZmlwcyx0b3RfcG9wLGJsYWNrX3BlcmMsbmF0aXZlX3BlcmMsaGlzcGFuaWNfcGVyYywgc3RhdGVfbmFtZT1zdG5hbWUsIGNvdW50eV9uYW1lPWN0eW5hbWUpIl19 -->

```r
a0 <- fread("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/Vaccination_Coverage_among_Young_Children__0-35_Months_.csv") %>% clean_names()

a0_clean <- a0 %>% mutate(vaccinated=estimate_percent*sample_size) %>% group_by(vaccine, geography) %>% summarise(vaccinated=sum(vaccinated), sample_size=sum(sample_size)) %>% mutate(vaccinated_perc=vaccinated/sample_size)
table(a0_clean$vaccine, a0_clean$geography) #There's a couple of vaccines missing at the count and PR level but the states have all of them.

a0_clean_state <- a0 %>% mutate(vaccinated=estimate_percent*sample_size) %>% group_by(geography) %>% summarise(vaccinated=sum(vaccinated), sample_size=sum(sample_size)) %>% mutate(vaccinated_perc=vaccinated/sample_size)

#hist(a0_clean_state$vaccinated_perc)

state_previous_child_vaccinated_perc <- a0_clean_state %>% dplyr::select(name_state=geography, previous_child_vaccinated_perc=vaccinated_perc) %>%
  left_join(states_sf_tigris %>% mutate(fips_state=as.numeric(STATEFP)*1000) %>% as.data.frame() %>% dplyr::select(name_state=NAME,fips_state) ) %>% dplyr::filter(!is.na(fips_state))

#a <- fread("1976-2020-president.csv")

a <- fread("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv") %>%
     filter(date=="2020-11-04") %>% dplyr::select(fips, deaths)

#b <- fread("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/2012pres.csv") %>% clean_names() %>%
#     mutate(romney_perc=100*willard_mitt_romney / (barack_h_obama + willard_mitt_romney)) %>%
#    dplyr::select(fips,romney_perc)

#c <- fread("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/2020pres.csv") %>% clean_names() %>% 
#     mutate(trump_perc=100*donald_j_trump / (joseph_r_biden_jr + donald_j_trump)) %>%
#     dplyr::select(fips,trump_perc)

#Don't need anymore
#d <- readRDS("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/cc-est2019-alldata.Rds") %>% clean_names() %>%
#     filter(year==12, agegrp==0) %>%
#     mutate(black_perc = 100*(bac_male + bac_female)/tot_pop) %>%
#     mutate(native_perc = 100*(iac_male + iac_female)/tot_pop) %>%
#     mutate(hispanic_perc = 100*(h_male + h_female)/tot_pop) %>%
#     mutate(fips=paste0(state,str_pad(county, 3, pad = "0") ) %>% as.numeric()  ) %>%
#     dplyr::select(fips,tot_pop,black_perc,native_perc,hispanic_perc, state_name=stname, county_name=ctyname)
```



<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Skipping this bad old measure of rural


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjpbImxpYnJhcnkocmVhZHhsKSIsImcgPC0gcmVhZF9leGNlbChcIi9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvcnVyYWx1cmJhbmNvZGVzMjAxMy54bHNcIikgJT4lIGNsZWFuX25hbWVzKCkgJT4lIGRwbHlyOjpzZWxlY3QoZmlwcyxydWNjXzIwMTMpICU+JSIsIiAgICAgbXV0YXRlKGZpcHM9ZmlwcyAlPiUgYXMubnVtZXJpYygpKSAiLCJkaW0oZykiXX0= -->

```r
library(readxl)
g <- read_excel("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/ruralurbancodes2013.xls") %>% clean_names() %>% dplyr::select(fips,rucc_2013) %>%
     mutate(fips=fips %>% as.numeric()) 
dim(g)
```



<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



Skipping this in favor some of spatial thing we'll try later

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjpbInBvcHVsYXRpb25fZGlmZmVyZW50aWFsIDwtIGR5YWRfZGYgJT4lICIsIiAgICAgICAgICAgICAgICAgICAgICAgICAgICBsZWZ0X2pvaW4oaCAlPiUgZHBseXI6OnNlbGVjdChmaXBzX3g9ZmlwcywgcG9wdWxhdGlvbl90b3RhbF94PXBvcHVsYXRpb25fdG90YWwpKSAlPiUiLCIgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGVmdF9qb2luKGggJT4lIGRwbHlyOjpzZWxlY3QoZmlwc195PWZpcHMsIHBvcHVsYXRpb25fdG90YWxfeT1wb3B1bGF0aW9uX3RvdGFsKSkgJT4lIiwiICAgICAgICAgICAgICAgICAgICAgICAgICAgIG11dGF0ZShwb3B1bGF0aW9uX2RpZmZlcmVudGlhbD1wb3B1bGF0aW9uX3RvdGFsX3gvcG9wdWxhdGlvbl90b3RhbF95KSAlPiUiLCIgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3JvdXBfYnkoZmlwcz1maXBzX3gpICU+JSIsIiAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdW1tYXJpc2UocG9wdWxhdGlvbl9kaWZmZXJlbnRpYWw9bWluKHBvcHVsYXRpb25fZGlmZmVyZW50aWFsLCBuYS5ybT1UKSkgJT4lIiwiICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZpbHRlcihpcy5maW5pdGUocG9wdWxhdGlvbl9kaWZmZXJlbnRpYWwpKSJdfQ== -->

```r
population_differential <- dyad_df %>% 
                            left_join(h %>% dplyr::select(fips_x=fips, population_total_x=population_total)) %>%
                            left_join(h %>% dplyr::select(fips_y=fips, population_total_y=population_total)) %>%
                            mutate(population_differential=population_total_x/population_total_y) %>%
                            group_by(fips=fips_x) %>%
                            summarise(population_differential=min(population_differential, na.rm=T)) %>%
                            filter(is.finite(population_differential))
```



<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->





### VA Data

Locked on July 14


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG4jaW5zdGFsbC5wYWNrYWdlcyhcXHJlbW90ZXNcXClcbiNyZW1vdGVzOjppbnN0YWxsX2dpdGh1YihcXG1pY2hhZWxkb3JtYW4vbWFwc2FwaVxcKVxuaWYoZnJvbXNjcmF0Y2gpe1xuICBjb3VudGllc19zZl90aWdyaXMgPC0gdGlncmlzOjpjb3VudGllcyhzdGF0ZSA9IE5VTEwsIGNiID0gRkFMU0UsIHJlc29sdXRpb24gPSBcXDVtXFwsIHllYXIgPSAyMDE5KSAlPiUgbXV0YXRlKGZpcHM9cGFzdGUwKFNUQVRFRlAsIENPVU5UWUZQKSAlPiUgYXMubnVtZXJpYykgJT4lIGFycmFuZ2UoZmlwcylcblxuICB2YWNvdmlkMTlzdW1tYXJ5IDwtIGZyZWFkKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhL3ZhY292aWQxOXN1bW1hcnkuY3N2XFwpICU+JSBqYW5pdG9yOjpjbGVhbl9uYW1lcygpXG5cbiAgbGlicmFyeShtYXBzYXBpKVxuICBrZXkgPSBcXEFJemFTeURiYzVwMVppbzBoUm1jNzRwWnJDaTVCRXhBalNMWnRGd1xcXG4gIHBsYWNlX2xpc3QgPC0gbGlzdCgpXG4gIGZvcihxIGluIHZhY292aWQxOXN1bW1hcnkkZmFjaWxpdHlfbmFtZSl7XG4gICBwcmludChxKVxuICAgIGRvYyA9IG1wX2dlb2NvZGUoXG4gICAgICBhZGRyZXNzZXMgPSBxLFxuICAgICAga2V5ID0ga2V5LFxuICAgICAgcXVpZXQgPSBUUlVFXG4gICAgKVxuICAgIHBudCA9IG1wX2dldF9wb2ludHMoZG9jKVxuICAgIHJlc3VsdCA8LSBwbnQgJT4lIHN0X3RyYW5zZm9ybShzdF9jcnMoY291bnRpZXNfc2ZfdGlncmlzKSkgJT4lIHN0X2pvaW4oY291bnRpZXNfc2ZfdGlncmlzKVxuICAgIHJlc3VsdCRmYWNpbGl0eV9uYW1lIDwtIHFcbiAgICBwbGFjZV9saXN0W1txXV0gPC0gcmVzdWx0XG4gIH1cbiAgdmFjb3ZpZDE5c3VtbWFyeV9nZW9sb2NhdGVkIDwtIHZhY292aWQxOXN1bW1hcnkgJT4lIGxlZnRfam9pbiggYmluZF9yb3dzKHBsYWNlX2xpc3QpKVxuICBzYXZlUkRTKHZhY292aWQxOXN1bW1hcnlfZ2VvbG9jYXRlZCwgXFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzL2RhdGEvdmFjb3ZpZDE5c3VtbWFyeV9nZW9sb2NhdGVkLlJkc1xcKVxuXG59XG5cbnZhY292aWQxOXN1bW1hcnlfZ2VvbG9jYXRlZF9jbGVhbiA8LSByZWFkUkRTKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhL3ZhY292aWQxOXN1bW1hcnlfZ2VvbG9jYXRlZC5SZHNcXCkgJT4lIGNsZWFuX25hbWVzKCkgJT4lXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG11dGF0ZShwZW9wbGVfcGFydGlhbF92YT1kb3NlXzFfb2ZfMl9wZml6ZXJfb3JfbW9kZXJuYStkb3NlXzFfb2ZfMV9qYW5zc2VuLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwZW9wbGVfY29tcGxldGVfdmE9IGRvc2VfMl9vZl8yX3BmaXplcl9vcl9tb2Rlcm5hK2Rvc2VfMV9vZl8xX2phbnNzZW4pICAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBncm91cF9ieShmaXBzKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN1bW1hcmlzZShwZW9wbGVfcGFydGlhbF92YT1zdW0ocGVvcGxlX3BhcnRpYWxfdmEpLCBwZW9wbGVfY29tcGxldGVfdmE9c3VtKHBlb3BsZV9jb21wbGV0ZV92YSkpXG4jMyw0ODAsNjQyICMzLjQgbWlsbGlvblxuXG5yaHNfdmFjb3ZpZDE5c3VtbWFyeV9nZW9sb2NhdGVkICA8LSB2YWNvdmlkMTlzdW1tYXJ5X2dlb2xvY2F0ZWRfY2xlYW4gICU+JSBcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBpdm90X2xvbmdlcigtZmlwcykgJT4lIFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0YXRlKGRlc2NyaXB0aW9uPWlmZWxzZShuYW1lPT0ncGVvcGxlX3BhcnRpYWxfdmEnLCd2YWNjaW5hdGlvbnMgdGhyb3VnaCB2ZXRlcmFucyBhZmZhaXJzIHBlb3BsZSBwYXJ0aWFsbHkgdmFjY2luYXRlZCcsJ3ZhY2NpbmF0aW9ucyB0aHJvdWdoIHZldGVyYW5zIGFmZmFpcnMgcGVvcGxlIGZ1bGx5IHZhY2NpbmF0ZWQnKSkgJT4lXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdXRhdGUodmFyaWFibGU9aWZlbHNlKG5hbWU9PSdwZW9wbGVfcGFydGlhbF92YScsJ3ZhY2NpbmF0ZWRfcGFydGlhbGx5X3Rocm91Z2hfdmEnLCd2YWNjaW5hdGVkX2Z1bGx5X3Rocm91Z2hfdmEnKSkgJT4lXG4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdXRhdGUoZGF0YXNldD1cXHZldGVyYW5zX2FmZmFpcnNcXClcbiAgXG5cbnJoc192YWNvdmlkMTlzdW1tYXJ5X2dlb2xvY2F0ZWQgICU+JSByZXhfY2xlYW4oKSAlPiUgYXJyb3c6OndyaXRlX3BhcnF1ZXQoZ2x1ZTo6Z2x1ZShcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YV9vdXQvcmhzL3Joc192YWNvdmlkMTlzdW1tYXJ5X2dlb2xvY2F0ZWQucGFycXVldFxcKSlcblxuXG5gYGBcbmBgYCJ9 -->

```r
```r

#install.packages(\remotes\)
#remotes::install_github(\michaeldorman/mapsapi\)
if(fromscratch){
  counties_sf_tigris <- tigris::counties(state = NULL, cb = FALSE, resolution = \5m\, year = 2019) %>% mutate(fips=paste0(STATEFP, COUNTYFP) %>% as.numeric) %>% arrange(fips)

  vacovid19summary <- fread(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/vacovid19summary.csv\) %>% janitor::clean_names()

  library(mapsapi)
  key = \AIzaSyDbc5p1Zio0hRmc74pZrCi5BExAjSLZtFw\
  place_list <- list()
  for(q in vacovid19summary$facility_name){
   print(q)
    doc = mp_geocode(
      addresses = q,
      key = key,
      quiet = TRUE
    )
    pnt = mp_get_points(doc)
    result <- pnt %>% st_transform(st_crs(counties_sf_tigris)) %>% st_join(counties_sf_tigris)
    result$facility_name <- q
    place_list[[q]] <- result
  }
  vacovid19summary_geolocated <- vacovid19summary %>% left_join( bind_rows(place_list))
  saveRDS(vacovid19summary_geolocated, \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/vacovid19summary_geolocated.Rds\)

}

vacovid19summary_geolocated_clean <- readRDS(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/vacovid19summary_geolocated.Rds\) %>% clean_names() %>%
                                      mutate(people_partial_va=dose_1_of_2_pfizer_or_moderna+dose_1_of_1_janssen,
                                      people_complete_va= dose_2_of_2_pfizer_or_moderna+dose_1_of_1_janssen)  %>%
                                     group_by(fips) %>%
                                    summarise(people_partial_va=sum(people_partial_va), people_complete_va=sum(people_complete_va))
#3,480,642 #3.4 million

rhs_vacovid19summary_geolocated  <- vacovid19summary_geolocated_clean  %>% 
                                    pivot_longer(-fips) %>% 
                                    mutate(description=ifelse(name=='people_partial_va','vaccinations through veterans affairs people partially vaccinated','vaccinations through veterans affairs people fully vaccinated')) %>%
                                    mutate(variable=ifelse(name=='people_partial_va','vaccinated_partially_through_va','vaccinated_fully_through_va')) %>%
                                    mutate(dataset=\veterans_affairs\)
  

rhs_vacovid19summary_geolocated  %>% rex_clean() %>% arrow::write_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_vacovid19summary_geolocated.parquet\))

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### JHU State Data

Ok so what I think we do is sum up everything we have for all the counties. Calculate the difference between the state total and that. Distribute the difference proportionally by population to the counties in that state. And then add the VA numbers right at the end. That should give us everything minus the DOD.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5pZihmcm9tc2NyYXRjaCl7XG4gIGpodSA8LSBmcmVhZChcXGh0dHBzOi8vcmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbS9nb3ZleC9DT1ZJRC0xOS9tYXN0ZXIvZGF0YV90YWJsZXMvdmFjY2luZV9kYXRhL3VzX2RhdGEvaG91cmx5L3ZhY2NpbmVfcGVvcGxlX3ZhY2NpbmF0ZWRfVVMuY3N2XFwpXG4gIHNhdmVSRFMoamh1LCBcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL1RydW1wU3VwcG9ydFZhY2NpbmF0aW9uUmF0ZXMvZGF0YS92YWNvdmlkMTlzdW1tYXJ5LlJkc1xcKVxufVxucmhzX2podV9zdGF0ZSA8LSByZWFkUkRTKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhL3ZhY292aWQxOXN1bW1hcnkuUmRzXFwpXG5cbiNEb24ndCBzYXZlIHRoaXMgdG8gdGhlIFJIUyBmb2xkZXIgd2l0aG91dCBtb3JlIG1vZGlmaWNhdGlvbnNcbiNyaHNfamh1X3N0YXRlICAlPiUgXG4gICNyZXhfY2xlYW4oKSAlPiUgICNub3QgcmVhZHkgeWV0XG4gICNhcnJvdzo6d3JpdGVfcGFycXVldChnbHVlOjpnbHVlKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhX291dC9yaHMvcmhzX2podV9zdGF0ZS5wYXJxdWV0XFwpKVxuXG5cbmBgYFxuYGBgIn0= -->

```r
```r

if(fromscratch){
  jhu <- fread(\https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/us_data/hourly/vaccine_people_vaccinated_US.csv\)
  saveRDS(jhu, \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/vacovid19summary.Rds\)
}
rhs_jhu_state <- readRDS(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/vacovid19summary.Rds\)

#Don't save this to the RHS folder without more modifications
#rhs_jhu_state  %>% 
  #rex_clean() %>%  #not ready yet
  #arrow::write_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_jhu_state.parquet\))

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



### Religion

U.S. Religion Census: Religious Congregations and Membership Study, 2010 (County File)
https://www.thearda.com/Archive/Files/Descriptions/RCMSCY10.asp


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG50aGVhcmRhX2NvZGVib29rIDwtIGRhdGEuZnJhbWUoXG4gIHN0cmluZ3NBc0ZhY3RvcnMgPSBGQUxTRSxcbiAgICAgICAgICB2YXJpYWJsZSA9IGMoXFwxKSBUT1RDTkdcXCxcXDEwKSBNUFJUQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTAwKSBCQ0NDTkdcXCxcXDEwMSkgQlJVRENOR1xcLFxcMTAyKSBCUlVEQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTAzKSBCUlVEUkFURVxcLFxcMTA0KSBCVURNQ05HXFwsXFwxMDUpIEJVRE1BREhcXCxcXDEwNikgQlVETVJBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwxMDcpIEJVRFRDTkdcXCxcXDEwOCkgQlVEVEFESFxcLFxcMTA5KSBCVURUUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDExKSBNUFJUQURIXFwsXFwxMTApIEJVRFZDTkdcXCxcXDExMSkgQlVEVkFESFxcLFxcMTEyKSBCVURWUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDExMykgQlVMR0NOR1xcLFxcMTE0KSBCVUxHQURIXFwsXFwxMTUpIEJVTEdSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTE2KSBDQ0ZDQ05HXFwsXFwxMTcpIENBUkNDTkdcXCxcXDExOCkgQ1RIQ05HXFwsXFwxMTkpIENUSEFESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDEyKSBNUFJUUkFURVxcLFxcMTIwKSBDVEhSQVRFXFwsXFwxMjEpIENZTUZDTkdcXCxcXDEyMikgQ1lNRkFESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDEyMykgQ1lNRlJBVEVcXCxcXDEyNCkgQ01BQ05HXFwsXFwxMjUpIENNQUFESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDEyNikgQ01BUkFURVxcLFxcMTI3KSBDQkNOR1xcLFxcMTI4KSBDQ0RDQ05HXFwsXFwxMjkpIENDRENBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwxMykgQ0FUSENOR1xcLFxcMTMwKSBDQ0RDUkFURVxcLFxcMTMxKSBDQ0NDQ05HXFwsXFwxMzIpIENDQ0NBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwxMzMpIENDQ0NSQVRFXFwsXFwxMzQpIENNRUNOR1xcLFxcMTM1KSBDTUVBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwxMzYpIENNRVJBVEVcXCxcXDEzNykgQ1JDQ05HXFwsXFwxMzgpIENSQ0FESFxcLFxcMTM5KSBDUkNSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTQpIENBVEhBREhcXCxcXDE0MCkgQ1VDTkdcXCxcXDE0MSkgQ0NIQ05HXFwsXFwxNDIpIENDU0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDE0MykgQ0dBSUNOR1xcLFxcMTQ0KSBDR0FJQURIXFwsXFwxNDUpIENHQUlSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTQ2KSBDR0NUQ05HXFwsXFwxNDcpIENHQ1RBREhcXCxcXDE0OCkgQ0dDVFJBVEVcXCxcXDE0OSkgQ0c3RENOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDE1KSBDQVRIUkFURVxcLFxcMTUwKSBDR0ZDTkdcXCxcXDE1MSkgQ0dHQ0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDE1MikgQ0dHQ0FESFxcLFxcMTUzKSBDR0dDUkFURVxcLFxcMTU0KSBDR0NDTkdcXCxcXDE1NSkgQ0dDQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTU2KSBDR0NSQVRFXFwsXFwxNTcpIENHQ01DTkdcXCxcXDE1OCkgQ0dDTUFESFxcLFxcMTU5KSBDR0NNUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDE2KSBPUlRIQ05HXFwsXFwxNjApIENHUENOR1xcLFxcMTYxKSBDR1BBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwxNjIpIENHUFJBVEVcXCxcXDE2MykgQ0dBRkNOR1xcLFxcMTY0KSBDR01BQ05HXFwsXFwxNjUpIExEU0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDE2NikgTERTQURIXFwsXFwxNjcpIExEU1JBVEVcXCxcXDE2OCkgQ0FGQ05HXFwsXFwxNjkpIENCUkNOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDE3KSBPUlRIQURIXFwsXFwxNzApIENCUkFESFxcLFxcMTcxKSBDQlJSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTcyKSBDTEJBQ05HXFwsXFwxNzMpIENMQkFBREhcXCxcXDE3NCkgQ0xCQVJBVEVcXCxcXDE3NSkgQ0xDQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTc2KSBOQVpDTkdcXCxcXDE3NykgTkFaQURIXFwsXFwxNzgpIE5BWlJBVEVcXCxcXDE3OSkgQ1VCQ0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDE4KSBPUlRIUkFURVxcLFxcMTgwKSBDVUJDQURIXFwsXFwxODEpIENVQkNSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTgyKSBDSENIQ05HXFwsXFwxODMpIENIQ0hBREhcXCxcXDE4NCkgQ0hDSFJBVEVcXCxcXDE4NSkgQ0NDVUNOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDE4NikgQ0hHTkNOR1xcLFxcMTg3KSBDSEdOQURIXFwsXFwxODgpIENIR05SQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTg5KSBDUkVDQ05HXFwsXFwxOSkgT1RIQ05HXFwsXFwxOTApIENPQ0NOR1xcLFxcMTkxKSBDT0NBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwxOTIpIENPQ1JBVEVcXCxcXDE5MykgQ0NDQ05HXFwsXFwxOTQpIENDQ0FESFxcLFxcMTk1KSBDQ0NSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMTk2KSBDSENDTkdcXCxcXDE5NykgQ0hDQURIXFwsXFwxOTgpIENIQ1JBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwxOTkpIENNQ0NOR1xcLFxcMikgVE9UQURIXFwsXFwyMCkgT1RIQURIXFwsXFwyMDApIENNQ0FESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDIwMSkgQ01DUkFURVxcLFxcMjAyKSBDQkFDTkdcXCxcXDIwMykgQ0NPTkNOR1xcLFxcMjA0KSBDQ09OQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMjA1KSBDQ09OUkFURVxcLFxcMjA2KSBDSlVEQ05HXFwsXFwyMDcpIENKVURBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyMDgpIENKVURSQVRFXFwsXFwyMDkpIENMQUNOR1xcLFxcMjEpIE9USFJBVEVcXCxcXDIxMCkgQ01DT0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDIxMSkgQ01DT0FESFxcLFxcMjEyKSBDTUNPUkFURVxcLFxcMjEzKSBDWUZSQ05HXFwsXFwyMTQpIENZRlJBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyMTUpIENZRlJSQVRFXFwsXFwyMTYpIE9GV0JDTkdcXCxcXDIxNykgT0ZXQkFESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDIxOCkgT0ZXQlJBVEVcXCxcXDIxOSkgQ1dDTkdcXCxcXDIyKSBPQ0dDTkdcXCxcXDIyMCkgQ1dBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyMjEpIENXUkFURVxcLFxcMjIyKSBDT1BUQ05HXFwsXFwyMjMpIENPUFRBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyMjQpIENPUFRSQVRFXFwsXFwyMjUpIENSUENDTkdcXCxcXDIyNikgQ1VNQkNOR1xcLFxcMjI3KSBDVU1CQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMjI4KSBDVU1CUkFURVxcLFxcMjI5KSBDUENBQ05HXFwsXFwyMykgQU1FQ05HXFwsXFwyMzApIEVMSU1DTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyMzEpIEVCQUNOR1xcLFxcMjMyKSBFQ0NOR1xcLFxcMjMzKSBFQ0FESFxcLFxcMjM0KSBFQ1JBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyMzUpIEVPQ05HXFwsXFwyMzYpIEVPQURIXFwsXFwyMzcpIEVPUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDIzOCkgRVRIT0NOR1xcLFxcMjM5KSBFQVJDTkdcXCxcXDI0KSBBTUVBREhcXCxcXDI0MCkgRVZDSENOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDI0MSkgRUNDQ05HXFwsXFwyNDIpIEVDQ0FESFxcLFxcMjQzKSBFQ0NSQVRFXFwsXFwyNDQpIEVDT1ZDTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyNDUpIEVDT1ZBREhcXCxcXDI0NikgRUNPVlJBVEVcXCxcXDI0NykgRUZDQUNOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDI0OCkgRUZDQUFESFxcLFxcMjQ5KSBFRkNBUkFURVxcLFxcMjUpIEFNRVJBVEVcXCxcXDI1MCkgRUZDSUNOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDI1MSkgRUZDSUFESFxcLFxcMjUyKSBFRkNJUkFURVxcLFxcMjUzKSBFTENBQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMjU0KSBFTENBQURIXFwsXFwyNTUpIEVMQ0FSQVRFXFwsXFwyNTYpIEVMU0NOR1xcLFxcMjU3KSBFTFNBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyNTgpIEVMU1JBVEVcXCxcXDI1OSkgRU1DQ05HXFwsXFwyNikgQU1FWkNOR1xcLFxcMjYwKSBFUENDTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyNjEpIEVQQ0FESFxcLFxcMjYyKSBFUENSQVRFXFwsXFwyNjMpIEZSQ0NOR1xcLFxcMjY0KSBGRUJDQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMjY1KSBGRUJDQURIXFwsXFwyNjYpIEZFQkNSQVRFXFwsXFwyNjcpIEZFQ0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDI2OCkgRkVDQURIXFwsXFwyNjkpIEZFQ1JBVEVcXCxcXDI3KSBBTUVaQURIXFwsXFwyNzApIEZPVVJDTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyNzEpIEZPVVJBREhcXCxcXDI3MikgRk9VUlJBVEVcXCxcXDI3MykgRkNTQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMjc0KSBGTUNDTkdcXCxcXDI3NSkgRk1DQURIXFwsXFwyNzYpIEZNQ1JBVEVcXCxcXDI3NykgRlBDQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMjc4KSBGUkNIQ05HXFwsXFwyNzkpIEZSTkRDTkdcXCxcXDI4KSBBTUVaUkFURVxcLFxcMjgwKSBGUk5EQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMjgxKSBGUk5EUkFURVxcLFxcMjgyKSBGR0NDTkdcXCxcXDI4MykgRkdDQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMjg0KSBGR0NSQVRFXFwsXFwyODUpIEZVTUNOR1xcLFxcMjg2KSBGVU1BREhcXCxcXDI4NykgRlVNUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDI4OCkgRkdCQ05HXFwsXFwyODkpIEZCRkNOR1xcLFxcMjkpIEFMQkNOR1xcLFxcMjkwKSBHQVJCQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMjkxKSBHT1BDTkdcXCxcXDI5MikgR09QQURIXFwsXFwyOTMpIEdPUFJBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyOTQpIEZHQkNDTkdcXCxcXDI5NSkgR0dGQ05HXFwsXFwyOTYpIEdSS0NOR1xcLFxcMjk3KSBHUktBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwyOTgpIEdSS1JBVEVcXCxcXDI5OSkgSFJDQ05HXFwsXFwzKSBUT1RSQVRFXFwsXFwzMCkgQUxCQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMzAwKSBIUkNBREhcXCxcXDMwMSkgSFJDUkFURVxcLFxcMzAyKSBITklDTkdcXCxcXDMwMykgSE5JQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMzA0KSBITklSQVRFXFwsXFwzMDUpIEhOUFJDTkdcXCxcXDMwNikgSE5QUkFESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDMwNykgSE5QUlJBVEVcXCxcXDMwOCkgSE5SQ05HXFwsXFwzMDkpIEhOUkFESFxcLFxcMzEpIEFMQlJBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwzMTApIEhOUlJBVEVcXCxcXDMxMSkgSE5UVENOR1xcLFxcMzEyKSBITlRUQURIXFwsXFwzMTMpIEhOVFRSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMzE0KSBIT0NDTkdcXCxcXDMxNSkgSE9DQURIXFwsXFwzMTYpIEhPQ1JBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwzMTcpIEhVTkdDTkdcXCxcXDMxOCkgSFVUVENOR1xcLFxcMzE5KSBJQkZJQ05HXFwsXFwzMikgQVdNQ0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDMyMCkgSUZDQUNOR1xcLFxcMzIxKSBJWU1GQ05HXFwsXFwzMjIpIElZTUZBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwzMjMpIElZTUZSQVRFXFwsXFwzMjQpIElDQ0NOR1xcLFxcMzI1KSBJQ0NBREhcXCxcXDMyNikgSUNDUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDMyNykgSUNDQ0NOR1xcLFxcMzI4KSBJRkJDQ05HXFwsXFwzMjkpIElOVEZDTkdcXCxcXDMzKSBBV01DQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMzMwKSBJUENDQ05HXFwsXFwzMzEpIElQQ0NBREhcXCxcXDMzMikgSVBDQ1JBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwzMzMpIElQSENDTkdcXCxcXDMzNCkgSVBIQ0FESFxcLFxcMzM1KSBJUEhDUkFURVxcLFxcMzM2KSBKQUlOQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMzM3KSBKV0NOR1xcLFxcMzM4KSBLUFJTQ05HXFwsXFwzMzkpIEtQQ0FDTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwzNCkgQVdNQ1JBVEVcXCxcXDM0MCkgS0FQQ0NOR1xcLFxcMzQxKSBMQ01TQ05HXFwsXFwzNDIpIExDTVNBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwzNDMpIExDTVNSQVRFXFwsXFwzNDQpIExDTUNDTkdcXCxcXDM0NSkgTENNQ0FESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDM0NikgTENNQ1JBVEVcXCxcXDM0NykgTU9DQ05HXFwsXFwzNDgpIE1PQ0FESFxcLFxcMzQ5KSBNT0NSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMzUpIEFMQlBDTkdcXCxcXDM1MCkgTUFMQUNOR1xcLFxcMzUxKSBNQUxBQURIXFwsXFwzNTIpIE1BTEFSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMzUzKSBNT1NDQ05HXFwsXFwzNTQpIE1PU0NBREhcXCxcXDM1NSkgTU9TQ1JBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwzNTYpIE1BTUNOR1xcLFxcMzU3KSBNQU1BREhcXCxcXDM1OCkgTUFNUkFURVxcLFxcMzU5KSBNQ0ZDTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwzNikgQU1BTkNOR1xcLFxcMzYwKSBNQ0ZBREhcXCxcXDM2MSkgTUNGUkFURVxcLFxcMzYyKSBNRU5OQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMzYzKSBNRU5OQURIXFwsXFwzNjQpIE1FTk5SQVRFXFwsXFwzNjUpIE1DQ0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDM2NikgTUNDQURIXFwsXFwzNjcpIE1DQ1JBVEVcXCxcXDM2OCkgTUJBTUNOR1xcLFxcMzY5KSBNQkFNQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMzcpIEFNQU5BREhcXCxcXDM3MCkgTUJBTVJBVEVcXCxcXDM3MSkgTUNDRkNOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDM3MikgTUNDRkFESFxcLFxcMzczKSBNQ0NGUkFURVxcLFxcMzc0KSBNSVNTQ05HXFwsXFwzNzUpIE1JU1NBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwzNzYpIE1JU1NSQVRFXFwsXFwzNzcpIE1WQUtDTkdcXCxcXDM3OCkgTVZBS0FESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDM3OSkgTVZBS1JBVEVcXCxcXDM4KSBBTUFOUkFURVxcLFxcMzgwKSBNVk5PQ05HXFwsXFwzODEpIE1WTk9BREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwzODIpIE1WTk9SQVRFXFwsXFwzODMpIE1WU09DTkdcXCxcXDM4NCkgTVZTT0FESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDM4NSkgTVZTT1JBVEVcXCxcXDM4NikgTVNMTUNOR1xcLFxcMzg3KSBNU0xNQURIXFwsXFwzODgpIE1TTE1SQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcMzg5KSBOQUNDQ05HXFwsXFwzOSkgQUFNQ05HXFwsXFwzOTApIE5BQ0NBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFwzOTEpIE5BQ0NSQVRFXFwsXFwzOTIpIEZXQkNOR1xcLFxcMzkzKSBGV0JBREhcXCxcXDM5NCkgRldCUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDM5NSkgTkJDQUNOR1xcLFxcMzk2KSBOQkNBQURIXFwsXFwzOTcpIE5CQ0FSQVRFXFwsXFwzOTgpIE5CQ0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDM5OSkgTkJDQURIXFwsXFw0KSBFVkFOQ05HXFwsXFw0MCkgQUFNQURIXFwsXFw0MDApIE5CQ1JBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0MDEpIE5NQkNDTkdcXCxcXDQwMikgTk1CQ0FESFxcLFxcNDAzKSBOTUJDUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDQwNCkgTlNBQ0NOR1xcLFxcNDA1KSBOV0FQQ05HXFwsXFw0MDYpIElCQ0NOR1xcLFxcNDA3KSBOT05EQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNDA4KSBOT05EQURIXFwsXFw0MDkpIE5PTkRSQVRFXFwsXFw0MSkgQUFNUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDQxMCkgTkFCQ0NOR1xcLFxcNDExKSBOQUJDQURIXFwsXFw0MTIpIE5BQkNSQVRFXFwsXFw0MTMpIE5BTENDTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0MTQpIE9PUkJDTkdcXCxcXDQxNSkgT09SQkFESFxcLFxcNDE2KSBPT1JCUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDQxNykgT0JTQ0NOR1xcLFxcNDE4KSBPQlNDQURIXFwsXFw0MTkpIE9CU0NSQVRFXFwsXFw0MikgQUFMQ0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDQyMCkgT0NBQ05HXFwsXFw0MjEpIE9DQUFESFxcLFxcNDIyKSBPQ0FSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNDIzKSBPSlVEQ05HXFwsXFw0MjQpIE9KVURBREhcXCxcXDQyNSkgT0pVRFJBVEVcXCxcXDQyNikgT1BDQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNDI3KSBPUENBREhcXCxcXDQyOCkgT1BDUkFURVxcLFxcNDI5KSBST0NDTkdcXCxcXDQzKSBBQkFDTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0MzApIFJPQ0FESFxcLFxcNDMxKSBST0NSQVRFXFwsXFw0MzIpIFBDQ0NOR1xcLFxcNDMzKSBQQ0NBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0MzQpIFBDQ1JBVEVcXCxcXDQzNSkgRkJIQ0NOR1xcLFxcNDM2KSBQRldCQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNDM3KSBQSUxMQ05HXFwsXFw0MzgpIFBJTExBREhcXCxcXDQzOSkgUElMTFJBVEVcXCxcXDQ0KSBBQkFBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0NDApIFBOQ0NDTkdcXCxcXDQ0MSkgUENDTkdcXCxcXDQ0MikgUENBREhcXCxcXDQ0MykgUENSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNDQ0KSBQQ0FDTkdcXCxcXDQ0NSkgUENBQURIXFwsXFw0NDYpIFBDQVJBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0NDcpIFBSQ0NOR1xcLFxcNDQ4KSBQQkVEQ05HXFwsXFw0NDkpIFBCRURBREhcXCxcXDQ1KSBBQkFSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNDUwKSBQQkVEUkFURVxcLFxcNDUxKSBQTUNDTkdcXCxcXDQ1MikgUE5CQ0NOR1xcLFxcNDUzKSBQTkJDQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNDU0KSBQTkJDUkFURVxcLFxcNDU1KSBQUkNBQ05HXFwsXFw0NTYpIFBSQ0FBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0NTcpIFBSQ0FSQVRFXFwsXFw0NTgpIFJKVURDTkdcXCxcXDQ1OSkgUkpVREFESFxcLFxcNDYpIEFCQ0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDQ2MCkgUkpVRFJBVEVcXCxcXDQ2MSkgUkZSTUNOR1xcLFxcNDYyKSBSRlJNQURIXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNDYzKSBSRlJNUkFURVxcLFxcNDY0KSBSQkNDTkdcXCxcXDQ2NSkgUkNBQ05HXFwsXFw0NjYpIFJDQUFESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDQ2NykgUkNBUkFURVxcLFxcNDY4KSBSQ1VTQ05HXFwsXFw0NjkpIFJDVVNBREhcXCxcXDQ3KSBBQkNBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0NzApIFJDVVNSQVRFXFwsXFw0NzEpIFJNQ0NOR1xcLFxcNDcyKSBSTUNBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0NzMpIFJNQ1JBVEVcXCxcXDQ3NCkgUlBDQ05HVlxcLFxcNDc1KSBSUEhQQ05HXFwsXFw0NzYpIFJQVVNDTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0NzcpIFJQTkFDTkdcXCxcXDQ3OCkgUlBOQUFESFxcLFxcNDc5KSBSUE5BUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDQ4KSBBQkNSQVRFXFwsXFw0ODApIFJPQUFDTkdcXCxcXDQ4MSkgUk9BQUFESFxcLFxcNDgyKSBST0FBUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDQ4MykgUk9PUkNOR1xcLFxcNDg0KSBST09SQURIXFwsXFw0ODUpIFJPT1JSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNDg2KSBTQUxWQ05HXFwsXFw0ODcpIFNBTFZBREhcXCxcXDQ4OCkgU0FMVlJBVEVcXCxcXDQ4OSkgU0NIV0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDQ5KSBBQ1JPQ05HXFwsXFw0OTApIFNDSFdBREhcXCxcXDQ5MSkgU0NIV1JBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0OTIpIFNFUkJDTkdcXCxcXDQ5MykgU0VSQkFESFxcLFxcNDk0KSBTRVJCUkFURVxcLFxcNDk1KSBTREJDTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw0OTYpIFNEQkFESFxcLFxcNDk3KSBTREJSQVRFXFwsXFw0OTgpIFNEQUNDTkdcXCxcXDQ5OSkgU0RBQ0FESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDUpIEVWQU5BREhcXCxcXDUwKSBBQ1JPQURIXFwsXFw1MDApIFNEQUNSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNTAxKSBTSE5UQ05HXFwsXFw1MDIpIFNJS0hDTkdcXCxcXDUwMykgU0JDQ05HXFwsXFw1MDQpIFNCQ0FESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDUwNSkgU0JDUkFURVxcLFxcNTA2KSBTTUNDTkdcXCxcXDUwNykgU1dFRENOR1xcLFxcNTA4KSBTT0NBQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNTA5KSBTT0NBQURIXFwsXFw1MSkgQUNST1JBVEVcXCxcXDUxMCkgU09DQVJBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw1MTEpIFRBTUNOR1xcLFxcNTEyKSBUQU1BREhcXCxcXDUxMykgVEFNUkFURVxcLFxcNTE0KSBUQU9DTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw1MTUpIFVTTUJDTkdcXCxcXDUxNikgVVNNQkFESFxcLFxcNTE3KSBVU01CUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDUxOCkgVU9DQ05HXFwsXFw1MTkpIFVPQ0FESFxcLFxcNTIpIEFQQ0NOR1xcLFxcNTIwKSBVT0NSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNTIxKSBVQ0FNQ05HXFwsXFw1MjIpIFVDQU1BREhcXCxcXDUyMykgVUNBTVJBVEVcXCxcXDUyNCkgVUZNQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNTI1KSBVTUpDQ05HXFwsXFw1MjYpIFVVQUNOR1xcLFxcNTI3KSBVVUFBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw1MjgpIFVVQVJBVEVcXCxcXDUyOSkgVUNUSENOR1xcLFxcNTMpIEFNU0hDTkdcXCxcXDUzMCkgVUNUSEFESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDUzMSkgVUNUSFJBVEVcXCxcXDUzMikgVUNDQ05HXFwsXFw1MzMpIFVDQ0FESFxcLFxcNTM0KSBVQ0NSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNTM1KSBVSENBQ05HXFwsXFw1MzYpIFVNQ0NOR1xcLFxcNTM3KSBVTUNBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw1MzgpIFVNQ1JBVEVcXCxcXDUzOSkgVVBDSUNOR1xcLFxcNTQpIEFNU0hBREhcXCxcXDU0MCkgVVBDQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNTQxKSBVUkNDTkdcXCxcXDU0MikgVVpDQ05HXFwsXFw1NDMpIFVaQ0FESFxcLFxcNTQ0KSBVWkNSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNTQ1KSBVTlRZQ05HXFwsXFw1NDYpIFVOQlJDTkdcXCxcXDU0NykgUEpPQ0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDU0OCkgUEpPQ0FESFxcLFxcNTQ5KSBQSk9DUkFURVxcLFxcNTUpIEFNU0hSQVRFXFwsXFw1NTApIFZJTkVDTkdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw1NTEpIFZJTkVBREhcXCxcXDU1MikgVklORVJBVEVcXCxcXDU1MykgV0VTQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNTU0KSBXRVNBREhcXCxcXDU1NSkgV0VTUkFURVxcLFxcNTU2KSBXRUxTQ05HXFwsXFw1NTcpIFdFTFNBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw1NTgpIFdFTFNSQVRFXFwsXFw1NTkpIFpPUk9DTkdcXCxcXDU2KSBBQ05BQ05HXFwsXFw1NjApIFpPUk9BREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw1NjEpIFpPUk9SQVRFXFwsXFw1NjIpIEZJUFNcXCxcXDU2MykgU1RDT0RFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNTY0KSBTVEFCQlJcXCxcXDU2NSkgU1ROQU1FXFwsXFw1NjYpIENOVFlDT0RFXFwsXFw1NjcpIENOVFlOQU1FXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNTY4KSBQT1AyMDEwXFwsXFw1NykgQU9DQUNOR1xcLFxcNTgpIEFPQ0FBREhcXCxcXDU5KSBBT0NBUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDYpIEVWQU5SQVRFXFwsXFw2MCkgQUNDQUNOR1xcLFxcNjEpIEFDQ0FBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw2MikgQUNDQVJBVEVcXCxcXDYzKSBBRk1DTkdcXCxcXDY0KSBBRk1BREhcXCxcXDY1KSBBRk1SQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNjYpIEFMQ0FDTkdcXCxcXDY3KSBBQUNBQ05HXFwsXFw2OCkgQUFDQUFESFxcLFxcNjkpIEFBQ0FSQVRFXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcNykgQlBSVENOR1xcLFxcNzApIEFSTUNOR1xcLFxcNzEpIEFSTUFESFxcLFxcNzIpIEFSTVJBVEVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw3MykgQUVDQ05HXFwsXFw3NCkgQUdDTkdcXCxcXDc1KSBBR0FESFxcLFxcNzYpIEFHUkFURVxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDc3KSBBR0lGQ05HXFwsXFw3OCkgQVJQQ0NOR1xcLFxcNzkpIEFSUENBREhcXCxcXDgpIEJQUlRBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw4MCkgQVJQQ1JBVEVcXCxcXDgxKSBBRkxDQ05HXFwsXFw4MikgQU1DQ05HXFwsXFw4MykgQVJCQ0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDg0KSBCQUhDTkdcXCxcXDg1KSBCQUhBREhcXCxcXDg2KSBCQUhSQVRFXFwsXFw4NykgQkFNQ0NOR1xcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDg4KSBCQU1DQURIXFwsXFw4OSkgQkFNQ1JBVEVcXCxcXDkpIEJQUlRSQVRFXFwsXFw5MCkgQkFNQ05HXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcOTEpIEJBTUFESFxcLFxcOTIpIEJBTVJBVEVcXCxcXDkzKSBCRkNDTkdcXCxcXDk0KSBCRkNBREhcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgXFw5NSkgQkZDUkFURVxcLFxcOTYpIEJQQ0NOR1xcLFxcOTcpIEJDQUNOR1xcLFxcOTgpIEJDQUFESFxcLFxuICAgICAgICAgICAgICAgICAgICAgICBcXDk5KSBCQ0FSQVRFXFwpLFxuICAgICAgIGRlc2NyaXB0aW9uID0gYyhcXEFsbCBkZW5vbWluYXRpb25zL2dyb3Vwcy0tVG90YWwgbnVtYmVyIG9mIGNvbmdyZWdhdGlvbnMgKDIwMTApXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcTWFpbmxpbmUgUHJvdGVzdGFudC0tVG90YWwgbnVtYmVyIG9mIGNvbmdyZWdhdGlvbnMgKDIwMTApXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcQnJldGhyZW4gaW4gQ2hyaXN0IENodXJjaC0tVG90YWwgbnVtYmVyIG9mIGNvbmdyZWdhdGlvbnMgKDIwMTApXFwsXG4gICAgICAgICAgICAgICAgICAgICAgIFxcQnJ1ZGVyaG9mIENvbW11bml0aWVzXG5gYGAifQ== -->

```r
```r

thearda_codebook <- data.frame(
  stringsAsFactors = FALSE,
          variable = c(\1) TOTCNG\,\10) MPRTCNG\,
                       \100) BCCCNG\,\101) BRUDCNG\,\102) BRUDADH\,
                       \103) BRUDRATE\,\104) BUDMCNG\,\105) BUDMADH\,\106) BUDMRATE\,
                       \107) BUDTCNG\,\108) BUDTADH\,\109) BUDTRATE\,
                       \11) MPRTADH\,\110) BUDVCNG\,\111) BUDVADH\,\112) BUDVRATE\,
                       \113) BULGCNG\,\114) BULGADH\,\115) BULGRATE\,
                       \116) CCFCCNG\,\117) CARCCNG\,\118) CTHCNG\,\119) CTHADH\,
                       \12) MPRTRATE\,\120) CTHRATE\,\121) CYMFCNG\,\122) CYMFADH\,
                       \123) CYMFRATE\,\124) CMACNG\,\125) CMAADH\,
                       \126) CMARATE\,\127) CBCNG\,\128) CCDCCNG\,\129) CCDCADH\,
                       \13) CATHCNG\,\130) CCDCRATE\,\131) CCCCCNG\,\132) CCCCADH\,
                       \133) CCCCRATE\,\134) CMECNG\,\135) CMEADH\,
                       \136) CMERATE\,\137) CRCCNG\,\138) CRCADH\,\139) CRCRATE\,
                       \14) CATHADH\,\140) CUCNG\,\141) CCHCNG\,\142) CCSCNG\,
                       \143) CGAICNG\,\144) CGAIADH\,\145) CGAIRATE\,
                       \146) CGCTCNG\,\147) CGCTADH\,\148) CGCTRATE\,\149) CG7DCNG\,
                       \15) CATHRATE\,\150) CGFCNG\,\151) CGGCCNG\,
                       \152) CGGCADH\,\153) CGGCRATE\,\154) CGCCNG\,\155) CGCADH\,
                       \156) CGCRATE\,\157) CGCMCNG\,\158) CGCMADH\,\159) CGCMRATE\,
                       \16) ORTHCNG\,\160) CGPCNG\,\161) CGPADH\,
                       \162) CGPRATE\,\163) CGAFCNG\,\164) CGMACNG\,\165) LDSCNG\,
                       \166) LDSADH\,\167) LDSRATE\,\168) CAFCNG\,\169) CBRCNG\,
                       \17) ORTHADH\,\170) CBRADH\,\171) CBRRATE\,
                       \172) CLBACNG\,\173) CLBAADH\,\174) CLBARATE\,\175) CLCCNG\,
                       \176) NAZCNG\,\177) NAZADH\,\178) NAZRATE\,\179) CUBCCNG\,
                       \18) ORTHRATE\,\180) CUBCADH\,\181) CUBCRATE\,
                       \182) CHCHCNG\,\183) CHCHADH\,\184) CHCHRATE\,\185) CCCUCNG\,
                       \186) CHGNCNG\,\187) CHGNADH\,\188) CHGNRATE\,
                       \189) CRECCNG\,\19) OTHCNG\,\190) COCCNG\,\191) COCADH\,
                       \192) COCRATE\,\193) CCCCNG\,\194) CCCADH\,\195) CCCRATE\,
                       \196) CHCCNG\,\197) CHCADH\,\198) CHCRATE\,
                       \199) CMCCNG\,\2) TOTADH\,\20) OTHADH\,\200) CMCADH\,
                       \201) CMCRATE\,\202) CBACNG\,\203) CCONCNG\,\204) CCONADH\,
                       \205) CCONRATE\,\206) CJUDCNG\,\207) CJUDADH\,
                       \208) CJUDRATE\,\209) CLACNG\,\21) OTHRATE\,\210) CMCOCNG\,
                       \211) CMCOADH\,\212) CMCORATE\,\213) CYFRCNG\,\214) CYFRADH\,
                       \215) CYFRRATE\,\216) OFWBCNG\,\217) OFWBADH\,
                       \218) OFWBRATE\,\219) CWCNG\,\22) OCGCNG\,\220) CWADH\,
                       \221) CWRATE\,\222) COPTCNG\,\223) COPTADH\,
                       \224) COPTRATE\,\225) CRPCCNG\,\226) CUMBCNG\,\227) CUMBADH\,
                       \228) CUMBRATE\,\229) CPCACNG\,\23) AMECNG\,\230) ELIMCNG\,
                       \231) EBACNG\,\232) ECCNG\,\233) ECADH\,\234) ECRATE\,
                       \235) EOCNG\,\236) EOADH\,\237) EORATE\,
                       \238) ETHOCNG\,\239) EARCNG\,\24) AMEADH\,\240) EVCHCNG\,
                       \241) ECCCNG\,\242) ECCADH\,\243) ECCRATE\,\244) ECOVCNG\,
                       \245) ECOVADH\,\246) ECOVRATE\,\247) EFCACNG\,
                       \248) EFCAADH\,\249) EFCARATE\,\25) AMERATE\,\250) EFCICNG\,
                       \251) EFCIADH\,\252) EFCIRATE\,\253) ELCACNG\,
                       \254) ELCAADH\,\255) ELCARATE\,\256) ELSCNG\,\257) ELSADH\,
                       \258) ELSRATE\,\259) EMCCNG\,\26) AMEZCNG\,\260) EPCCNG\,
                       \261) EPCADH\,\262) EPCRATE\,\263) FRCCNG\,\264) FEBCCNG\,
                       \265) FEBCADH\,\266) FEBCRATE\,\267) FECCNG\,
                       \268) FECADH\,\269) FECRATE\,\27) AMEZADH\,\270) FOURCNG\,
                       \271) FOURADH\,\272) FOURRATE\,\273) FCSCNG\,
                       \274) FMCCNG\,\275) FMCADH\,\276) FMCRATE\,\277) FPCCNG\,
                       \278) FRCHCNG\,\279) FRNDCNG\,\28) AMEZRATE\,\280) FRNDADH\,
                       \281) FRNDRATE\,\282) FGCCNG\,\283) FGCADH\,
                       \284) FGCRATE\,\285) FUMCNG\,\286) FUMADH\,\287) FUMRATE\,
                       \288) FGBCNG\,\289) FBFCNG\,\29) ALBCNG\,\290) GARBCNG\,
                       \291) GOPCNG\,\292) GOPADH\,\293) GOPRATE\,
                       \294) FGBCCNG\,\295) GGFCNG\,\296) GRKCNG\,\297) GRKADH\,
                       \298) GRKRATE\,\299) HRCCNG\,\3) TOTRATE\,\30) ALBADH\,
                       \300) HRCADH\,\301) HRCRATE\,\302) HNICNG\,\303) HNIADH\,
                       \304) HNIRATE\,\305) HNPRCNG\,\306) HNPRADH\,
                       \307) HNPRRATE\,\308) HNRCNG\,\309) HNRADH\,\31) ALBRATE\,
                       \310) HNRRATE\,\311) HNTTCNG\,\312) HNTTADH\,\313) HNTTRATE\,
                       \314) HOCCNG\,\315) HOCADH\,\316) HOCRATE\,
                       \317) HUNGCNG\,\318) HUTTCNG\,\319) IBFICNG\,\32) AWMCCNG\,
                       \320) IFCACNG\,\321) IYMFCNG\,\322) IYMFADH\,
                       \323) IYMFRATE\,\324) ICCCNG\,\325) ICCADH\,\326) ICCRATE\,
                       \327) ICCCCNG\,\328) IFBCCNG\,\329) INTFCNG\,\33) AWMCADH\,
                       \330) IPCCCNG\,\331) IPCCADH\,\332) IPCCRATE\,
                       \333) IPHCCNG\,\334) IPHCADH\,\335) IPHCRATE\,\336) JAINCNG\,
                       \337) JWCNG\,\338) KPRSCNG\,\339) KPCACNG\,
                       \34) AWMCRATE\,\340) KAPCCNG\,\341) LCMSCNG\,\342) LCMSADH\,
                       \343) LCMSRATE\,\344) LCMCCNG\,\345) LCMCADH\,
                       \346) LCMCRATE\,\347) MOCCNG\,\348) MOCADH\,\349) MOCRATE\,
                       \35) ALBPCNG\,\350) MALACNG\,\351) MALAADH\,\352) MALARATE\,
                       \353) MOSCCNG\,\354) MOSCADH\,\355) MOSCRATE\,
                       \356) MAMCNG\,\357) MAMADH\,\358) MAMRATE\,\359) MCFCNG\,
                       \36) AMANCNG\,\360) MCFADH\,\361) MCFRATE\,\362) MENNCNG\,
                       \363) MENNADH\,\364) MENNRATE\,\365) MCCCNG\,
                       \366) MCCADH\,\367) MCCRATE\,\368) MBAMCNG\,\369) MBAMADH\,
                       \37) AMANADH\,\370) MBAMRATE\,\371) MCCFCNG\,
                       \372) MCCFADH\,\373) MCCFRATE\,\374) MISSCNG\,\375) MISSADH\,
                       \376) MISSRATE\,\377) MVAKCNG\,\378) MVAKADH\,
                       \379) MVAKRATE\,\38) AMANRATE\,\380) MVNOCNG\,\381) MVNOADH\,
                       \382) MVNORATE\,\383) MVSOCNG\,\384) MVSOADH\,
                       \385) MVSORATE\,\386) MSLMCNG\,\387) MSLMADH\,\388) MSLMRATE\,
                       \389) NACCCNG\,\39) AAMCNG\,\390) NACCADH\,
                       \391) NACCRATE\,\392) FWBCNG\,\393) FWBADH\,\394) FWBRATE\,
                       \395) NBCACNG\,\396) NBCAADH\,\397) NBCARATE\,\398) NBCCNG\,
                       \399) NBCADH\,\4) EVANCNG\,\40) AAMADH\,\400) NBCRATE\,
                       \401) NMBCCNG\,\402) NMBCADH\,\403) NMBCRATE\,
                       \404) NSACCNG\,\405) NWAPCNG\,\406) IBCCNG\,\407) NONDCNG\,
                       \408) NONDADH\,\409) NONDRATE\,\41) AAMRATE\,
                       \410) NABCCNG\,\411) NABCADH\,\412) NABCRATE\,\413) NALCCNG\,
                       \414) OORBCNG\,\415) OORBADH\,\416) OORBRATE\,
                       \417) OBSCCNG\,\418) OBSCADH\,\419) OBSCRATE\,\42) AALCCNG\,
                       \420) OCACNG\,\421) OCAADH\,\422) OCARATE\,
                       \423) OJUDCNG\,\424) OJUDADH\,\425) OJUDRATE\,\426) OPCCNG\,
                       \427) OPCADH\,\428) OPCRATE\,\429) ROCCNG\,\43) ABACNG\,
                       \430) ROCADH\,\431) ROCRATE\,\432) PCCCNG\,\433) PCCADH\,
                       \434) PCCRATE\,\435) FBHCCNG\,\436) PFWBCNG\,
                       \437) PILLCNG\,\438) PILLADH\,\439) PILLRATE\,\44) ABAADH\,
                       \440) PNCCCNG\,\441) PCCNG\,\442) PCADH\,\443) PCRATE\,
                       \444) PCACNG\,\445) PCAADH\,\446) PCARATE\,
                       \447) PRCCNG\,\448) PBEDCNG\,\449) PBEDADH\,\45) ABARATE\,
                       \450) PBEDRATE\,\451) PMCCNG\,\452) PNBCCNG\,\453) PNBCADH\,
                       \454) PNBCRATE\,\455) PRCACNG\,\456) PRCAADH\,
                       \457) PRCARATE\,\458) RJUDCNG\,\459) RJUDADH\,\46) ABCCNG\,
                       \460) RJUDRATE\,\461) RFRMCNG\,\462) RFRMADH\,
                       \463) RFRMRATE\,\464) RBCCNG\,\465) RCACNG\,\466) RCAADH\,
                       \467) RCARATE\,\468) RCUSCNG\,\469) RCUSADH\,\47) ABCADH\,
                       \470) RCUSRATE\,\471) RMCCNG\,\472) RMCADH\,
                       \473) RMCRATE\,\474) RPCCNGV\,\475) RPHPCNG\,\476) RPUSCNG\,
                       \477) RPNACNG\,\478) RPNAADH\,\479) RPNARATE\,
                       \48) ABCRATE\,\480) ROAACNG\,\481) ROAAADH\,\482) ROAARATE\,
                       \483) ROORCNG\,\484) ROORADH\,\485) ROORRATE\,
                       \486) SALVCNG\,\487) SALVADH\,\488) SALVRATE\,\489) SCHWCNG\,
                       \49) ACROCNG\,\490) SCHWADH\,\491) SCHWRATE\,
                       \492) SERBCNG\,\493) SERBADH\,\494) SERBRATE\,\495) SDBCNG\,
                       \496) SDBADH\,\497) SDBRATE\,\498) SDACCNG\,\499) SDACADH\,
                       \5) EVANADH\,\50) ACROADH\,\500) SDACRATE\,
                       \501) SHNTCNG\,\502) SIKHCNG\,\503) SBCCNG\,\504) SBCADH\,
                       \505) SBCRATE\,\506) SMCCNG\,\507) SWEDCNG\,\508) SOCACNG\,
                       \509) SOCAADH\,\51) ACRORATE\,\510) SOCARATE\,
                       \511) TAMCNG\,\512) TAMADH\,\513) TAMRATE\,\514) TAOCNG\,
                       \515) USMBCNG\,\516) USMBADH\,\517) USMBRATE\,
                       \518) UOCCNG\,\519) UOCADH\,\52) APCCNG\,\520) UOCRATE\,
                       \521) UCAMCNG\,\522) UCAMADH\,\523) UCAMRATE\,\524) UFMCNG\,
                       \525) UMJCCNG\,\526) UUACNG\,\527) UUAADH\,
                       \528) UUARATE\,\529) UCTHCNG\,\53) AMSHCNG\,\530) UCTHADH\,
                       \531) UCTHRATE\,\532) UCCCNG\,\533) UCCADH\,\534) UCCRATE\,
                       \535) UHCACNG\,\536) UMCCNG\,\537) UMCADH\,
                       \538) UMCRATE\,\539) UPCICNG\,\54) AMSHADH\,\540) UPCCNG\,
                       \541) URCCNG\,\542) UZCCNG\,\543) UZCADH\,\544) UZCRATE\,
                       \545) UNTYCNG\,\546) UNBRCNG\,\547) PJOCCNG\,
                       \548) PJOCADH\,\549) PJOCRATE\,\55) AMSHRATE\,\550) VINECNG\,
                       \551) VINEADH\,\552) VINERATE\,\553) WESCNG\,
                       \554) WESADH\,\555) WESRATE\,\556) WELSCNG\,\557) WELSADH\,
                       \558) WELSRATE\,\559) ZOROCNG\,\56) ACNACNG\,\560) ZOROADH\,
                       \561) ZORORATE\,\562) FIPS\,\563) STCODE\,
                       \564) STABBR\,\565) STNAME\,\566) CNTYCODE\,\567) CNTYNAME\,
                       \568) POP2010\,\57) AOCACNG\,\58) AOCAADH\,\59) AOCARATE\,
                       \6) EVANRATE\,\60) ACCACNG\,\61) ACCAADH\,
                       \62) ACCARATE\,\63) AFMCNG\,\64) AFMADH\,\65) AFMRATE\,
                       \66) ALCACNG\,\67) AACACNG\,\68) AACAADH\,\69) AACARATE\,
                       \7) BPRTCNG\,\70) ARMCNG\,\71) ARMADH\,\72) ARMRATE\,
                       \73) AECCNG\,\74) AGCNG\,\75) AGADH\,\76) AGRATE\,
                       \77) AGIFCNG\,\78) ARPCCNG\,\79) ARPCADH\,\8) BPRTADH\,
                       \80) ARPCRATE\,\81) AFLCCNG\,\82) AMCCNG\,\83) ARBCCNG\,
                       \84) BAHCNG\,\85) BAHADH\,\86) BAHRATE\,\87) BAMCCNG\,
                       \88) BAMCADH\,\89) BAMCRATE\,\9) BPRTRATE\,\90) BAMCNG\,
                       \91) BAMADH\,\92) BAMRATE\,\93) BFCCNG\,\94) BFCADH\,
                       \95) BFCRATE\,\96) BPCCNG\,\97) BCACNG\,\98) BCAADH\,
                       \99) BCARATE\),
       description = c(\All denominations/groups--Total number of congregations (2010)\,
                       \Mainline Protestant--Total number of congregations (2010)\,
                       \Brethren in Christ Church--Total number of congregations (2010)\,
                       \Bruderhof Communities
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

## Climate Change


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG55YWxlX2RmIDwtIGRhdGEuZnJhbWUoXG4gICAgICBzdHJpbmdzQXNGYWN0b3JzID0gRkFMU0UsXG4gICAgbmFtZSA9IGMoXFxHZW9UeXBlXFwsXFxHRU9JRFxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxHZW9OYW1lXFwsXFxUb3RhbFBvcFxcLFxcaGFwcGVuaW5nXFwsXFxoYXBwZW5pbmdPcHBvc2VcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcaHVtYW5cXCxcXGh1bWFuT3Bwb3NlXFwsXFxjb25zZW5zdXNcXCxcXGNvbnNlbnN1c09wcG9zZVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxhZmZlY3R3ZWF0aGVyXFwsXFxhZmZlY3R3ZWF0aGVyT3Bwb3NlXFwsXFx3b3JyaWVkXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXHdvcnJpZWRPcHBvc2VcXCxcXGhhcm1wbGFudHNcXCxcXGhhcm1wbGFudHNPcHBvc2VcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcZnV0dXJlZ2VuXFwsXFxmdXR1cmVnZW5PcHBvc2VcXCxcXGRldmhhcm1cXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcZGV2aGFybU9wcG9zZVxcLFxcaGFybVVTXFwsXFxoYXJtVVNPcHBvc2VcXCxcXHBlcnNvbmFsXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXHBlcnNvbmFsT3Bwb3NlXFwsXFx0aW1pbmdcXCxcXHRpbWluZ09wcG9zZVxcLFxcZnVuZHJlbmV3YWJsZXNcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcZnVuZHJlbmV3YWJsZXNPcHBvc2VcXCxcXHJlZ3VsYXRlXFwsXFxyZWd1bGF0ZU9wcG9zZVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxDTzJsaW1pdHNcXCxcXENPMmxpbWl0c09wcG9zZVxcLFxccmVkdWNldGF4XFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXHJlZHVjZXRheE9wcG9zZVxcLFxcc3VwcG9ydFJQU1xcLFxcc3VwcG9ydFJQU09wcG9zZVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxyZWJhdGVzXFwsXFxyZWJhdGVzT3Bwb3NlXFwsXFxkcmlsbEFOV1JcXCxcXGRyaWxsQU5XUk9wcG9zZVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxkcmlsbG9mZnNob3JlXFwsXFxkcmlsbG9mZnNob3JlT3Bwb3NlXFwsXFx0ZWFjaEdXXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXHRlYWNoR1dPcHBvc2VcXCxcXGNvcnBvcmF0aW9uc1xcLFxcY29ycG9yYXRpb25zT3Bwb3NlXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXHByZXNpZGVudFxcLFxccHJlc2lkZW50T3Bwb3NlXFwsXFxjb25ncmVzc1xcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxjb25ncmVzc09wcG9zZVxcLFxcZ292ZXJub3JcXCxcXGdvdmVybm9yT3Bwb3NlXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXGxvY2Fsb2ZmaWNpYWxzXFwsXFxsb2NhbG9mZmljaWFsc09wcG9zZVxcLFxcY2l0aXplbnNcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcY2l0aXplbnNPcHBvc2VcXCxcXHByaWVudlxcLFxccHJpZW52T3Bwb3NlXFwsXFxkaXNjdXNzXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXGRpc2N1c3NPcHBvc2VcXCxcXG1lZGlhd2Vla2x5XFwsXFxtZWRpYXdlZWtseU9wcG9zZVxcLFxcZ3d2b3RlaW1wXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXGd3dm90ZWltcE9wcG9zZVxcLFxccHJpb3JpdHlcXCxcXHByaW9yaXR5T3Bwb3NlXFwpLFxuICBkZXNjcmlwdGlvbiA9IGMoXFxHZW9ncmFwaGljIGxldmVsXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXEdlb2dyYXBoaWMgYWJicmV2aWF0aW9uXFwsXFxHZW9ncmFwaGljIG5hbWVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcVG90YWwgcG9wdWxhdGlvblxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxFc3RpbWF0ZWQgcGVyY2VudGFnZSB3aG8gdGhpbmsgdGhhdCBnbG9iYWwgd2FybWluZyBpcyBoYXBwZW5pbmdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcRXN0aW1hdGVkIHBlcmNlbnRhZ2Ugd2hvIGRvIG5vdCB0aGluayB0aGF0IGdsb2JhbCB3YXJtaW5nIGlzIGhhcHBlbmluZ1xcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxFc3RpbWF0ZWQgcGVyY2VudGFnZSB3aG8gdGhpbmsgdGhhdCBnbG9iYWwgd2FybWluZyBpcyBjYXVzZWQgbW9zdGx5IGJ5IGh1bWFuIGFjdGl2aXRpZXNcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcRXN0aW1hdGVkIHBlcmNlbnRhZ2Ugd2hvIHRoaW5rIHRoYXQgZ2xvYmFsIHdhcm1pbmcgaXMgY2F1c2VkIG1vc3RseSBieSBuYXR1cmFsIGNoYW5nZXMgaW4gdGhlIGVudmlyb25tZW50XFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXEVzdGltYXRlZCBwZXJjZW50YWdlIHdobyBiZWxpZXZlIHRoYXQgbW9zdCBzY2llbnRpc3RzIHRoaW5rIGdsb2JhbCB3YXJtaW5nIGlzIGhhcHBlbmluZ1xcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxFc3RpbWF0ZWQgcGVyY2VudGFnZSB3aG8gYmVsaWV2ZSB0aGVyZSBpcyBhIGxvdCBvZiBkaXNhZ3JlZW1lbnQgYW1vbmcgc2NpZW50aXN0cyBhYm91dCB3aGV0aGVyIG9yIG5vdCBnbG9iYWwgd2FybWluZyBpcyBoYXBwZW5pbmdcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcRXN0aW1hdGVkIHBlcmNlbnRhZ2Ugd2hvIHNvbWV3aGF0L3N0cm9uZ2x5IGFncmVlIHRoYXQgZ2xvYmFsIHdhcm1pbmcgaXMgYWZmZWN0aW5nIHRoZSB3ZWF0aGVyIGluIHRoZSBVbml0ZWQgU3RhdGVzXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXEVzdGltYXRlZCBwZXJjZW50YWdlIHdobyBzb21ld2hhdC9zdHJvbmdseSBkaXNhZ3JlZSB0aGF0IGdsb2JhbCB3YXJtaW5nIGlzIGFmZmVjdGluZyB0aGUgd2VhdGhlciBpbiB0aGUgVW5pdGVkIFN0YXRlc1xcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxFc3RpbWF0ZWQgcGVyY2VudGFnZSB3aG8gYXJlIHNvbWV3aGF0L3Zlcnkgd29ycmllZCBhYm91dCBnbG9iYWwgd2FybWluZ1xcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxFc3RpbWF0ZWQgcGVyY2VudGFnZSB3aG8gYXJlIG5vdCB2ZXJ5L25vdCBhdCBhbGwgd29ycmllZCBhYm91dCBnbG9iYWwgd2FybWluZ1xcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxFc3RpbWF0ZWQgcGVyY2VudGFnZSB3aG8gdGhpbmsgZ2xvYmFsIHdhcm1pbmcgd2lsbCBoYXJtIHBsYW50cyBhbmQgYW5pbWFsIHNwZWNpZXMgYSBtb2RlcmF0ZSBhbW91bnQvYSBncmVhdCBkZWFsXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXEVzdGltYXRlZCBwZXJjZW50YWdlIHdobyB0aGluayBnbG9iYWwgd2FybWluZyB3aWxsIGhhcm0gcGxhbnRzIGFuZCBhbmltYWwgc3BlY2llcyBub3QgYXQgYWxsL29ubHkgYSBsaXR0bGVcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcRXN0aW1hdGVkIHBlcmNlbnRhZ2Ugd2hvIHRoaW5rIGdsb2JhbCB3YXJtaW5nIHdpbGwgaGFybSBmdXR1cmUgZ2VuZXJhdGlvbnMgYSBtb2RlcmF0ZSBhbW91bnQvYSBncmVhdCBkZWFsXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXEVzdGltYXRlZCBwZXJjZW50YWdlIHdobyB0aGluayBnbG9iYWwgd2FybWluZyB3aWxsIGhhcm0gZnV0dXJlIGdlbmVyYXRpb25zIG5vdCBhdCBhbGwvb25seSBhIGxpdHRsZVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxFc3RpbWF0ZWQgcGVyY2VudGFnZSB3aG8gdGhpbmsgZ2xvYmFsIHdhcm1pbmcgd2lsbCBoYXJtIHBlb3BsZSBpbiBkZXZlbG9waW5nIGNvdW50cmllcyBhIG1vZGVyYXRlIGFtb3VudC9hIGdyZWF0IGRlYWxcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcRXN0aW1hdGVkIHBlcmNlbnRhZ2Ugd2hvIHRoaW5rIGdsb2JhbCB3YXJtaW5nIHdpbGwgaGFybSBwZW9wbGUgaW4gZGV2ZWxvcGluZyBjb3VudHJpZXMgbm90IGF0IGFsbC9vbmx5IGEgbGl0dGxlXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXEVzdGltYXRlZCBwZXJjZW50YWdlIHdobyB0aGluayBnbG9iYWwgd2FybWluZyB3aWxsIGhhcm0gcGVvcGxlIGluIHRoZSBVUyBhIG1vZGVyYXRlIGFtb3VudC9hIGdyZWF0IGRlYWxcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcRXN0aW1hdGVkIHBlcmNlbnRhZ2Ugd2hvIHRoaW5rIGdsb2JhbCB3YXJtaW5nIHdpbGwgaGFybSBwZW9wbGUgaW4gdGhlIFVTIG5vdCBhdCBhbGwvb25seSBhIGxpdHRsZVxcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxFc3RpbWF0ZWQgcGVyY2VudGFnZSB3aG8gdGhpbmsgZ2xvYmFsIHdhcm1pbmcgd2lsbCBoYXJtIHRoZW0gcGVyc29uYWxseSBhIG1vZGVyYXRlIGFtb3VudC9hIGdyZWF0IGRlYWxcXCxcbiAgICAgICAgICAgICAgICAgICAgICAgICAgIFxcRXN0aW1hdGVkIHBlcmNlbnRhZ2Ugd2hvIHRoaW5rIGdsb2JhbCB3YXJtaW5nIHdpbGwgaGFybSB0aGVtIHBlcnNvbmFsbHkgbm90IGF0IGFsbC9vbmx5IGEgbGl0dGxlXFwsXG4gICAgICAgICAgICAgICAgICAgICAgICAgICBcXEVzdGltYXRlZCBwZXJjZW50YWdlIHdobyB0aGluayBnbG9iYWwgd2FybWluZyB3aWxsIHN0YXJ0IHRvIGhhcm0gcGVvcGxlIGluIHRoZSBVbml0ZWQgbm93L3dpdGhpbiAxMCB5ZWFyc1xcLFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxFc3RpbWF0ZWQgcGVyY2VudGFnZSB3aG8gdGhpbmsgZ2xvYmFsIHdhcm1pbmcgd2lsbCBzdGFydCB0byBoYXJtIHBlb3BsZSBpbiB0aGUgVW5pdGVkIGluIDI1IHllYXJzIG9yIGxvbmdlclxuYGBgIn0= -->

```r
```r

yale_df <- data.frame(
      stringsAsFactors = FALSE,
    name = c(\GeoType\,\GEOID\,
                           \GeoName\,\TotalPop\,\happening\,\happeningOppose\,
                           \human\,\humanOppose\,\consensus\,\consensusOppose\,
                           \affectweather\,\affectweatherOppose\,\worried\,
                           \worriedOppose\,\harmplants\,\harmplantsOppose\,
                           \futuregen\,\futuregenOppose\,\devharm\,
                           \devharmOppose\,\harmUS\,\harmUSOppose\,\personal\,
                           \personalOppose\,\timing\,\timingOppose\,\fundrenewables\,
                           \fundrenewablesOppose\,\regulate\,\regulateOppose\,
                           \CO2limits\,\CO2limitsOppose\,\reducetax\,
                           \reducetaxOppose\,\supportRPS\,\supportRPSOppose\,
                           \rebates\,\rebatesOppose\,\drillANWR\,\drillANWROppose\,
                           \drilloffshore\,\drilloffshoreOppose\,\teachGW\,
                           \teachGWOppose\,\corporations\,\corporationsOppose\,
                           \president\,\presidentOppose\,\congress\,
                           \congressOppose\,\governor\,\governorOppose\,
                           \localofficials\,\localofficialsOppose\,\citizens\,
                           \citizensOppose\,\prienv\,\prienvOppose\,\discuss\,
                           \discussOppose\,\mediaweekly\,\mediaweeklyOppose\,\gwvoteimp\,
                           \gwvoteimpOppose\,\priority\,\priorityOppose\),
  description = c(\Geographic level\,
                           \Geographic abbreviation\,\Geographic name\,
                           \Total population\,
                           \Estimated percentage who think that global warming is happening\,
                           \Estimated percentage who do not think that global warming is happening\,
                           \Estimated percentage who think that global warming is caused mostly by human activities\,
                           \Estimated percentage who think that global warming is caused mostly by natural changes in the environment\,
                           \Estimated percentage who believe that most scientists think global warming is happening\,
                           \Estimated percentage who believe there is a lot of disagreement among scientists about whether or not global warming is happening\,
                           \Estimated percentage who somewhat/strongly agree that global warming is affecting the weather in the United States\,
                           \Estimated percentage who somewhat/strongly disagree that global warming is affecting the weather in the United States\,
                           \Estimated percentage who are somewhat/very worried about global warming\,
                           \Estimated percentage who are not very/not at all worried about global warming\,
                           \Estimated percentage who think global warming will harm plants and animal species a moderate amount/a great deal\,
                           \Estimated percentage who think global warming will harm plants and animal species not at all/only a little\,
                           \Estimated percentage who think global warming will harm future generations a moderate amount/a great deal\,
                           \Estimated percentage who think global warming will harm future generations not at all/only a little\,
                           \Estimated percentage who think global warming will harm people in developing countries a moderate amount/a great deal\,
                           \Estimated percentage who think global warming will harm people in developing countries not at all/only a little\,
                           \Estimated percentage who think global warming will harm people in the US a moderate amount/a great deal\,
                           \Estimated percentage who think global warming will harm people in the US not at all/only a little\,
                           \Estimated percentage who think global warming will harm them personally a moderate amount/a great deal\,
                           \Estimated percentage who think global warming will harm them personally not at all/only a little\,
                           \Estimated percentage who think global warming will start to harm people in the United now/within 10 years\,
                           \Estimated percentage who think global warming will start to harm people in the United in 25 years or longer
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



# Appendix 2: County Level Vaccine Uptake

### CDC


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG4jSWYgaXQncyBub3QgdG9kYXkgdGhlbiBkb24ndCBydW4gXG5cbmlmKGZyb21zY3JhdGNoKXtcbiAgZGwgPC0gZnJlYWQoXFxodHRwczovL2RhdGEuY2RjLmdvdi9hcGkvdmlld3MvOHhreC1hbXFoL3Jvd3MuY3N2P2FjY2Vzc1R5cGU9RE9XTkxPQURcXCkgXG4gIGxoc19jZGMgPC0gIGRsICU+JSBcbiAgICAgICBjbGVhbl9uYW1lcygpICU+JVxuICAgICAgIG11dGF0ZShkYXRlPWRhdGUgJT4lIGFzLmNoYXJhY3RlcigpICU+JSBsdWJyaWRhdGU6Om1keSgpKSAlPiUgXG4gICAgICAgZmlsdGVyKGRhdGU9PW1heChkYXRlKSkgJT4lICNVcGRhdGUgdG8gd2hpY2hldmVyIGRhdGUgd2UgcHVsbCB0aGUgRGVtb2NyYXRhbmRjaHJvbmljbGUgZGF0YSAjdGhpcyBmYWlscyBiZWNhdXNlIHRoZXkgbWF5IG5vdCBoYXZlIHVwZGF0ZWQgaXQgdG8gZGF5IHdoZW4geW8gdXJ1biB0aGlzXG4gICAgICAgbXV0YXRlKGZpcHM9ZmlwcyAlPiUgYXMubnVtZXJpYygpKSAlPiVcbiAgICAgICBtdXRhdGUoc2VyaWVzX2NvbXBsZXRlXzE4cGx1c19wb3BfcGN0PXNlcmllc19jb21wbGV0ZV8xOHBsdXNfcG9wX3BjdC8xMDApICU+JVxuICAgICAgIG11dGF0ZShzZXJpZXNfY29tcGxldGVfcG9wX3BjdD1zZXJpZXNfY29tcGxldGVfcG9wX3BjdC8xMDApICU+JVxuICAgICAgIG11dGF0ZShzZXJpZXNfY29tcGxldGVfMThwbHVzX3BvcF9wY3Q9aWZlbHNlKHNlcmllc19jb21wbGV0ZV8xOHBsdXNfcG9wX3BjdCAlaW4lIGMoMCwxKSwgTkEsIHNlcmllc19jb21wbGV0ZV8xOHBsdXNfcG9wX3BjdCApKSAlPiVcbiAgICAgICBtdXRhdGUoc2VyaWVzX2NvbXBsZXRlX3BvcF9wY3Q9aWZlbHNlKHNlcmllc19jb21wbGV0ZV9wb3BfcGN0ICVpbiUgYygwLDEpLCBOQSwgc2VyaWVzX2NvbXBsZXRlX3BvcF9wY3QgKSkgIyU+JVxuICAgIFxuICAgICAgICNmaWx0ZXIoc2VyaWVzX2NvbXBsZXRlXzE4cGx1c19wb3BfcGN0IT0wICYgc2VyaWVzX2NvbXBsZXRlXzE4cGx1c19wb3BfcGN0IT0xKSAlPiVcbiAgICAgICAjZHBseXI6OnNlbGVjdChyZWNpcF9zdGF0ZSwgcmVjaXBfY291bnR5LCBmaXBzLHNlcmllc19jb21wbGV0ZV8xOHBsdXNfcG9wX3BjdCwgc2VyaWVzX2NvbXBsZXRlX3BvcF9wY3QpICU+JVxuICAgICAgICNtdXRhdGUocmV0cmlldmVkPVN5cy5EYXRlKCkpXG4gIGRpbShsaHNfY2RjKVxuICBzYXZlUkRTKGxoc19jZGMsIFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhL2NkY192YWNjaW5lX3JhdGVzLlJkc1xcIClcbn1cblxubGhzX2NkYyA8LSByZWFkUkRTKFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhL2NkY192YWNjaW5lX3JhdGVzLlJkc1xcICkgJT4lXG4gIGRwbHlyOjpzZWxlY3QocmVjaXBfc3RhdGUsIHJlY2lwX2NvdW50eSwgZmlwcywgcGVvcGxlX3BhcnRpYWxfY2RjPWFkbWluaXN0ZXJlZF9kb3NlMV9yZWNpcCwgcGVvcGxlX2NvbXBsZXRlX2NkYz1zZXJpZXNfY29tcGxldGVfeWVzICApIFxuXG5gYGBcbmBgYCJ9 -->

```r
```r

#If it's not today then don't run 

if(fromscratch){
  dl <- fread(\https://data.cdc.gov/api/views/8xkx-amqh/rows.csv?accessType=DOWNLOAD\) 
  lhs_cdc <-  dl %>% 
       clean_names() %>%
       mutate(date=date %>% as.character() %>% lubridate::mdy()) %>% 
       filter(date==max(date)) %>% #Update to whichever date we pull the Democratandchronicle data #this fails because they may not have updated it to day when yo urun this
       mutate(fips=fips %>% as.numeric()) %>%
       mutate(series_complete_18plus_pop_pct=series_complete_18plus_pop_pct/100) %>%
       mutate(series_complete_pop_pct=series_complete_pop_pct/100) %>%
       mutate(series_complete_18plus_pop_pct=ifelse(series_complete_18plus_pop_pct %in% c(0,1), NA, series_complete_18plus_pop_pct )) %>%
       mutate(series_complete_pop_pct=ifelse(series_complete_pop_pct %in% c(0,1), NA, series_complete_pop_pct )) #%>%
    
       #filter(series_complete_18plus_pop_pct!=0 & series_complete_18plus_pop_pct!=1) %>%
       #dplyr::select(recip_state, recip_county, fips,series_complete_18plus_pop_pct, series_complete_pop_pct) %>%
       #mutate(retrieved=Sys.Date())
  dim(lhs_cdc)
  saveRDS(lhs_cdc, \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/cdc_vaccine_rates.Rds\ )
}

lhs_cdc <- readRDS(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/cdc_vaccine_rates.Rds\ ) %>%
  dplyr::select(recip_state, recip_county, fips, people_partial_cdc=administered_dose1_recip, people_complete_cdc=series_complete_yes  ) 

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


The distribution of up Uptake in the country is still abysmal, with the
median county at only 41%, and the 3rd quartile barely at 50%.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoibGhzX2NkYyAlPiUgcHVsbChwZW9wbGVfcGFydGlhbF9jZGMpICU+JSBzdW1tYXJ5KCkifQ== -->

```r
lhs_cdc %>% pull(people_partial_cdc) %>% summary()
```



<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


90% of counties land between 12% and 63%. The measurement task therefore
isn't so much to explain high vaccine uptake from low, but rather to
identify stragglers with low uptake form the central mass.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoibGhzX2NkYyAlPiUgcHVsbChwZW9wbGVfcGFydGlhbF9jZGMpICU+JSBxdWFudGlsZShwcm9iPXNlcSgwLDEsLjAxKSwgbmEucm09VCkifQ== -->

```r
lhs_cdc %>% pull(people_partial_cdc) %>% quantile(prob=seq(0,1,.01), na.rm=T)
```



<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoibGhzX2NkYyAlPiUgZ2dwbG90KGFlcyh4PXBlb3BsZV9wYXJ0aWFsX2NkYykpICsgZ2VvbV9oaXN0b2dyYW0oYmlucz0xMDApIn0= -->

```r
lhs_cdc %>% ggplot(aes(x=people_partial_cdc)) + geom_histogram(bins=100)
```



<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


So who are the stragglers? Here's a map showing the rates in the data.
Texas is missing entirely for reporting issues. A few very rural
counties are missing as well. The stragglers appear to be concentrated
in three states, George, Virginia, and West Virginia and more
sporadically across the midwest. Bounding effects that show state are
evidence of geogrpahic and administrative auto-correlation, from
administration, reporting, or both.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjpbIiNkZXZ0b29sczo6aW5zdGFsbF9naXRodWIoXCJVcmJhbkluc3RpdHV0ZS91cmJubWFwclwiKSIsImxpYnJhcnkodGlkeXZlcnNlKSIsImxpYnJhcnkodXJibm1hcHIpIiwiIiwibWFwX2RhdGEgPC0gbGVmdF9qb2luKGxoc19jZGMsIHVyYm5tYXByOjpjb3VudGllcyAlPiUgbXV0YXRlKGNvdW50eV9maXBzPWNvdW50eV9maXBzICU+JSBhcy5udW1lcmljKCkgKSwgYnkgPSBjKFwiZmlwc1wiPVwiY291bnR5X2ZpcHNcIikgKSIsInAgPC0gbWFwX2RhdGEgJT4lIiwiICBtdXRhdGUocGVvcGxlX3BhcnRpYWxfY2RjPWlmZWxzZShwZW9wbGVfcGFydGlhbF9jZGM9PTAsIE5BLCBwZW9wbGVfcGFydGlhbF9jZGMpKSAlPiUgI2lnbm9yZSAwIGFzIG1pc3NpbmciLCIgIGdncGxvdChhZXMobG9uZywgbGF0LCBncm91cCA9IGdyb3VwLCBmaWxsID0gcGVvcGxlX3BhcnRpYWxfY2RjKSkgKyIsIiAgZ2VvbV9wb2x5Z29uKGNvbG9yID0gTkEpICsiLCIgIGNvb3JkX21hcChwcm9qZWN0aW9uID0gXCJhbGJlcnNcIiwgbGF0MCA9IDM5LCBsYXQxID0gNDUpICsiLCIgIGxhYnMoZmlsbCA9IFwiUGFydGlhbHkgVmFjY2luYXRlZFwiKSJdfQ== -->

```r
#devtools::install_github("UrbanInstitute/urbnmapr")
library(tidyverse)
library(urbnmapr)

map_data <- left_join(lhs_cdc, urbnmapr::counties %>% mutate(county_fips=county_fips %>% as.numeric() ), by = c("fips"="county_fips") )
p <- map_data %>%
  mutate(people_partial_cdc=ifelse(people_partial_cdc==0, NA, people_partial_cdc)) %>% #ignore 0 as missing
  ggplot(aes(long, lat, group = group, fill = people_partial_cdc)) +
  geom_polygon(color = NA) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  labs(fill = "Partialy Vaccinated")
```



<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoicCJ9 -->

```r
p
```



<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


Here is Uptake in tabular format that you can browse in its entirety.
Sorted by least Uptake, the top 100 offenders are all VA, WV, GA and one
county from MA. The values aren't just low but near 0, which should set
off alarm bells that there might still be measurement processes we
haven't accounted for. In fact, if we look at the [New York Times
Vaccine
tracker](https://www.nytimes.com/interactive/2020/us/covid-19-vaccine-doses.html),
we find that they leave out precisely those three states as
"insufficient data." The [Washington Post's vaccine
tracker](https://www.washingtonpost.com/graphics/2020/health/covid-vaccine-states-distribution-doses/)
excludes another three states, New Mexico, Colorado, and South Dakota
because less than 85% of vaccination records include a person's county
of residence.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5wX2xvYWQoRFQpOyAjaW5zdGFsbC5wYWNrYWdlcygnRFQnKVxuRFQ6OmRhdGF0YWJsZShsaHNfY2RjICU+JSBhcnJhbmdlKHBlb3BsZV9wYXJ0aWFsX2NkYyksIHJvd25hbWVzID0gRkFMU0UpXG5cbmBgYFxuYGBgIn0= -->

```r
```r

p_load(DT); #install.packages('DT')
DT::datatable(lhs_cdc %>% arrange(people_partial_cdc), rownames = FALSE)

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### USA Today Network

The USA Today Network produces databases and visualizations for
affiliate, including the [COVID-19 Vaccine
Tracker](https://data.democratandchronicle.com/covid-19-vaccine-tracker/).
The details of the database are obscure but it pulls CDC data and fills
in missing or broken states with data directly from state health
agencies. We can pull their numbers for each county and compare them to
the CDC counts. Their data cover 3,222 counties.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5wX2xvYWQocnZlc3QpXG5pZihmcm9tc2NyYXRjaCl7XG4gIFxuICBsaW5rIDwtIFxcaHR0cHM6Ly9kYXRhLmRlbW9jcmF0YW5kY2hyb25pY2xlLmNvbS9jb3ZpZC0xOS12YWNjaW5lLXRyYWNrZXIvXFxcbiAgZHJpdmVyIDwtIHJlYWRfaHRtbChsaW5rKSAgXG4gIHN0YXRlX2xpbmtzIDwtIGRyaXZlciAlPiVcbiAgaHRtbF9ub2RlcyhcXHRhYmxlXFwpICU+JVxuICBodG1sX25vZGVzKFxcdGRcXCkgJT4lIFxuICBodG1sX25vZGVzKFxcYVxcKSAlPiUgXG4gIGh0bWxfYXR0cihcXGhyZWZcXClcblxuICBkZl9saXN0IDwtIGxpc3QoKVxuICBmb3Ioc3RhdGUgaW4gc3RhdGVfbGlua3NbMjpsZW5ndGgoc3RhdGVfbGlua3MpXSl7XG4gICAgcHJpbnQoc3RhdGUpXG4gICAgY291bnR5X3RhYmxlIDwtIE5VTExcbiAgICBsaW5rPXBhc3RlMChcXGh0dHBzOi8vZGF0YS5kZW1vY3JhdGFuZGNocm9uaWNsZS5jb20vXFwsc3RhdGUpXG4gICAgZHJpdmVyIDwtIHJlYWRfaHRtbChsaW5rKVxuICAgIGNvdW50eV9saW5rcyA8LSAgIGRyaXZlciAlPiVcbiAgICAgICAgICAgIGh0bWxfbm9kZXMoXFx0YWJsZVxcKSAlPiVcbiAgICAgICAgICAgIGh0bWxfbm9kZXMoXFx0ZFxcKSAlPiUgXG4gICAgICAgICAgICBodG1sX25vZGVzKFxcYVxcKSAlPiUgXG4gICAgICAgICAgICBodG1sX2F0dHIoXFxocmVmXFwpXG4gICAgYWxsVGFibGVzIDwtIGh0bWxfbm9kZXMoZHJpdmVyLCBjc3MgPSBcXHRhYmxlXFwpXG4gICAgY291bnR5X3RhYmxlIDwtIGh0bWxfdGFibGUoYWxsVGFibGVzKVtbM11dICU+JSBqYW5pdG9yOjpjbGVhbl9uYW1lcygpXG4gICAgY291bnR5X3RhYmxlJHVybHMgPC0gY291bnR5X2xpbmtzXG4gICAgY291bnR5X3RhYmxlJHN0YXRlIDwtIHN0YXRlXG4gICAgZGZfbGlzdFtbc3RhdGVdXSA8LSBjb3VudHlfdGFibGVcbiAgICBkZl9saXN0W1tzdGF0ZV1dJHJldHJpZXZlZCA8LSBTeXMuRGF0ZSgpXG4gIH0gICBcblxuICBzYXZlUkRTKGRmX2xpc3QsIFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhL2RlbW9jcmF0YW5kY2hyb25pY2xlX3ZhY2NpbmVfcmF0ZXMuUmRzXFwpXG59XG5cbmRmX2xpc3QgPC0gIHJlYWRSRFMoIFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhL2RlbW9jcmF0YW5kY2hyb25pY2xlX3ZhY2NpbmVfcmF0ZXMuUmRzXFwpXG5cbml0ZW1zIDwtIG5hbWVzKGRmX2xpc3QpXG5mb3IoaXRlbSBpbiBpdGVtcyl7XG4gIFxuICBNIDwtIGRmX2xpc3RbW2l0ZW1dXVxuICBNJHBvcHVsYXRpb25fbnVtZXJpYyA8LSBNJHBvcHVsYXRpb24gJT4lIHN0cl9yZXBsYWNlKFxcXG5gYGAifQ== -->

```r
```r

p_load(rvest)
if(fromscratch){
  
  link <- \https://data.democratandchronicle.com/covid-19-vaccine-tracker/\
  driver <- read_html(link)  
  state_links <- driver %>%
  html_nodes(\table\) %>%
  html_nodes(\td\) %>% 
  html_nodes(\a\) %>% 
  html_attr(\href\)

  df_list <- list()
  for(state in state_links[2:length(state_links)]){
    print(state)
    county_table <- NULL
    link=paste0(\https://data.democratandchronicle.com/\,state)
    driver <- read_html(link)
    county_links <-   driver %>%
            html_nodes(\table\) %>%
            html_nodes(\td\) %>% 
            html_nodes(\a\) %>% 
            html_attr(\href\)
    allTables <- html_nodes(driver, css = \table\)
    county_table <- html_table(allTables)[[3]] %>% janitor::clean_names()
    county_table$urls <- county_links
    county_table$state <- state
    df_list[[state]] <- county_table
    df_list[[state]]$retrieved <- Sys.Date()
  }   

  saveRDS(df_list, \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/democratandchronicle_vaccine_rates.Rds\)
}

df_list <-  readRDS( \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/democratandchronicle_vaccine_rates.Rds\)

items <- names(df_list)
for(item in items){
  
  M <- df_list[[item]]
  M$population_numeric <- M$population %>% str_replace(\
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### CHHS

California's numbers


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuI3VoZyBkb2Vzbid0IGhhdmUgZmlwc1xuY2hocyA8LSBmcmVhZChcXGh0dHBzOi8vZGF0YS5jaGhzLmNhLmdvdi9kYXRhc2V0L2UyODNlZTVhLWNmMTgtNGYyMC1hOTJjLWVlOTRhMjg2NmNjZC9yZXNvdXJjZS8xMzBkN2JhMi1iNmViLTQzOGQtYTQxMi03NDFiZGUyMDdlMWMvZG93bmxvYWQvY292aWQxOXZhY2NpbmVzYnljb3VudHkuY3N2XFwpXG5kaW0oY2hocylcblxuI2FkbWluaXN0ZXJlZF9kYXRlXG4jdG90YWxfcGFydGlhbGx5X3ZhY2NpbmF0ZWRcbiNjdW11bGF0aXZlX2F0X2xlYXN0X29uZV9kb3NlXG5cbmNhX3RvZGF5IDwtIGNoaHMgJT4lIGRwbHlyOjpmaWx0ZXIoYWRtaW5pc3RlcmVkX2RhdGU9PVxcMjAyMS0wNi0yNFxcKVxuXG5gYGBcbmBgYCJ9 -->

```r
```r
#uhg doesn't have fips
chhs <- fread(\https://data.chhs.ca.gov/dataset/e283ee5a-cf18-4f20-a92c-ee94a2866ccd/resource/130d7ba2-b6eb-438d-a412-741bde207e1c/download/covid19vaccinesbycounty.csv\)
dim(chhs)

#administered_date
#total_partially_vaccinated
#cumulative_at_least_one_dose

ca_today <- chhs %>% dplyr::filter(administered_date==\2021-06-24\)

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### vaccinetracking.us

<http://www.vaccinetracking.us/>
<https://raw.githubusercontent.com/bansallab/vaccinetracking/main/vacc_data/data_master_county.csv>

"What are some limitations of the data?
1) The data collation process described above is a process in flux caused by the unpredictable changes in data access, data definitions and data formats provided by the CDC and states. 2) Many states report vaccinated doses administered which have no county residence information (due to missing information about residents or because the vaccinated individual does not live in that state). These vaccinations are not counted in our county-level vaccination counts. We find that these vaccinations do not make up more than 10% of any state’s total vaccination counts. 3) The county-level vaccination counts reported by the CDC do not include county residents vaccinated by Veterans Affairs, the Department of Defense, the Indian Health Service, and the Bureau of Prisons. Some states do include these vaccinations in their provided data, others do not. We are working to better disentangle and integrate these data."



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5pZihmcm9tc2NyYXRjaCl7XG52YWNjaW5ldHJhY2tpbmcgPC0gZnJlYWQoXFxodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vYmFuc2FsbGFiL3ZhY2NpbmV0cmFja2luZy9tYWluL3ZhY2NfZGF0YS9kYXRhX21hc3Rlcl9jb3VudHkuY3N2XFwpXG5kaW0odmFjY2luZXRyYWNraW5nKVxuXG50YWJsZSh2YWNjaW5ldHJhY2tpbmckQ0FTRV9UWVBFKVxuXG52YWNjaW5ldHJhY2tpbmcxIDwtIHZhY2NpbmV0cmFja2luZyAlPiUgXG4gIGNsZWFuX25hbWVzKCkgJT4lXG4gICNtdXRhdGUoZGF0ZT1kYXRlICU+JSBhcy5EYXRlKCkpICU+JVxuICAjZmlsdGVyKGRhdGU9PW1heChkYXRlKSkgJT4lIFxuICBmaWx0ZXIoY2FzZV90eXBlPT1cXENvbXBsZXRlXFwpICU+JVxuICBtdXRhdGUocGVvcGxlX2NvbXBsZXRlX3ZhY2NpbmV0cmFja2luZz1jYXNlcylcblxudmFjY2luZXRyYWNraW5nMiA8LSB2YWNjaW5ldHJhY2tpbmcgJT4lIFxuICAgICAgICAgICAgICAgICAgICBjbGVhbl9uYW1lcygpICU+JVxuICAgICAgICAgICAgICAgICAgICAjbXV0YXRlKGRhdGU9ZGF0ZSAlPiUgYXMuRGF0ZSgpKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgI2ZpbHRlcihkYXRlPT1tYXgoZGF0ZSkpICU+JSBcbiAgICAgICAgICAgICAgICAgICAgZmlsdGVyKGNhc2VfdHlwZSAlaW4lIFxcUGFydGlhbFxcKSAlPiVcbiAgICAgICAgICAgICAgICAgICAgbXV0YXRlKHBlb3BsZV9wYXJ0aWFsX3ZhY2NpbmV0cmFja2luZz1jYXNlcylcblxuXG52YWNjaW5ldHJhY2tpbmcxICU+JSBkcGx5cjo6c2VsZWN0KGZpcHM9Y291bnR5LCBwZW9wbGVfY29tcGxldGVfdmFjY2luZXRyYWNraW5nKSAlPiVcbiAgZnVsbF9qb2luKHZhY2NpbmV0cmFja2luZzIgJT4lIGRwbHlyOjpzZWxlY3QoZmlwcz1jb3VudHksIHBlb3BsZV9wYXJ0aWFsX3ZhY2NpbmV0cmFja2luZykpICAlPiUgXG4gICAgICAgICAgICAgIHNhdmVSRFMoIFxcL21udC84dGJfYS9yd2RfZ2l0aHViX3ByaXZhdGUvVHJ1bXBTdXBwb3J0VmFjY2luYXRpb25SYXRlcy9kYXRhL3ZhY2NpbmV0cmFja2luZy5SZHNcXCApXG5cbn1cbmxoc192YWNjaW5ldHJhY2tpbmcgPC0gcmVhZFJEUyggXFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzL2RhdGEvdmFjY2luZXRyYWNraW5nLlJkc1xcIClcblxuXG5gYGBcbmBgYCJ9 -->

```r
```r

if(fromscratch){
vaccinetracking <- fread(\https://raw.githubusercontent.com/bansallab/vaccinetracking/main/vacc_data/data_master_county.csv\)
dim(vaccinetracking)

table(vaccinetracking$CASE_TYPE)

vaccinetracking1 <- vaccinetracking %>% 
  clean_names() %>%
  #mutate(date=date %>% as.Date()) %>%
  #filter(date==max(date)) %>% 
  filter(case_type==\Complete\) %>%
  mutate(people_complete_vaccinetracking=cases)

vaccinetracking2 <- vaccinetracking %>% 
                    clean_names() %>%
                    #mutate(date=date %>% as.Date()) %>%
                    #filter(date==max(date)) %>% 
                    filter(case_type %in% \Partial\) %>%
                    mutate(people_partial_vaccinetracking=cases)


vaccinetracking1 %>% dplyr::select(fips=county, people_complete_vaccinetracking) %>%
  full_join(vaccinetracking2 %>% dplyr::select(fips=county, people_partial_vaccinetracking))  %>% 
              saveRDS( \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/vaccinetracking.Rds\ )

}
lhs_vaccinetracking <- readRDS( \/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data/vaccinetracking.Rds\ )

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### CovidActNow

Some states don't release county level information leading to under
reporting. Being next to a large county might also further distort
because the vaccinations are attributed to that bigger county.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5pZihmcm9tc2NyYXRjaCl7XG4gIGNvdmlkYWN0bm93IDwtIGZyZWFkKFxcaHR0cHM6Ly9hcGkuY292aWRhY3Rub3cub3JnL3YyL2NvdW50aWVzLnRpbWVzZXJpZXMuY3N2P2FwaUtleT1kYWM4Y2Y0MzMwMjg0YTNiYWE4MGNmZjVjOTcyMDE3NlxcKVxuICBzYXZlUkRTKGNvdmlkYWN0bm93LCBcXC9tbnQvOHRiX2EvcndkX2dpdGh1Yl9wcml2YXRlL05FU1NyZGYvZGF0YV90ZW1wL2NvdmlkYWN0bm93LlJkc1xcKVxufVxuY292aWRhY3Rub3cgPC0gcmVhZFJEUyggXFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9ORVNTcmRmL2RhdGFfdGVtcC9jb3ZpZGFjdG5vdy5SZHNcXClcblxubGhzX2NvdmlkYWN0bm93IDwtIGNvdmlkYWN0bm93ICU+JSBkcGx5cjo6c2VsZWN0KGRhdGUsIGZpcHMsIHBlb3BsZV9wYXJ0aWFsX2NvdmlkYWN0bm93PWFjdHVhbHMudmFjY2luYXRpb25zSW5pdGlhdGVkLCBwZW9wbGVfY29tcGxldGVfY292aWRhY3Rub3c9YWN0dWFscy52YWNjaW5hdGlvbnNDb21wbGV0ZWQpXG5cbmBgYFxuYGBgIn0= -->

```r
```r

if(fromscratch){
  covidactnow <- fread(\https://api.covidactnow.org/v2/counties.timeseries.csv?apiKey=dac8cf4330284a3baa80cff5c9720176\)
  saveRDS(covidactnow, \/mnt/8tb_a/rwd_github_private/NESSrdf/data_temp/covidactnow.Rds\)
}
covidactnow <- readRDS( \/mnt/8tb_a/rwd_github_private/NESSrdf/data_temp/covidactnow.Rds\)

lhs_covidactnow <- covidactnow %>% dplyr::select(date, fips, people_partial_covidactnow=actuals.vaccinationsInitiated, people_complete_covidactnow=actuals.vaccinationsCompleted)

```
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



### Compare and Synthesize

Compared to the Democrat and Chronicle data, the CDC systematically
under reports vaccinations in VA, GA, NC, etc. The CDC data have higher
numbers for PR as well as a few other counties. The Democrat and
Chronicle data also have all of Texas.



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuYGBgclxuXG5yaHNfY2Vuc3VzMjAyMCA8LSBhcnJvdzo6cmVhZF9wYXJxdWV0KGdsdWU6OmdsdWUoXFwvbW50Lzh0Yl9hL3J3ZF9naXRodWJfcHJpdmF0ZS9UcnVtcFN1cHBvcnRWYWNjaW5hdGlvblJhdGVzL2RhdGFfb3V0L3Jocy9yaHNfY2Vuc3VzMjAyMC5wYXJxdWV0XFwpKVxuXG5wb3B1bGF0aW9uXzE0cGx1cyA8LSByaHNfY2Vuc3VzMjAyMCAgJT4lIGZpbHRlcih2YXJpYWJsZT09XFxjZW5zdXMyMDIwX3BvcHVsYXRpb25fYWJvdmVfMTQgeWVhcnMgb2xkXG5gYGAifQ== -->

```r
```r

rhs_census2020 <- arrow::read_parquet(glue::glue(\/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs/rhs_census2020.parquet\))

population_14plus <- rhs_census2020  %>% filter(variable==\census2020_population_above_14 years old
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



# Combine RHS



<!-- rnb-text-end -->



















