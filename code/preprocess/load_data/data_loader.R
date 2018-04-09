load_hotel_reserve <- function(){
  customer_tb <<- read.csv('data/customer.csv', fileEncoding='UTF-8', header=T, stringsAsFactors=F)
  hotel_tb <<- read.csv('data/hotel.csv', fileEncoding='UTF-8', header=T, stringsAsFactors=F)
  reserve_tb <<- read.csv('data/reserve.csv', fileEncoding='UTF-8', header=T, stringsAsFactors=F)
  
  hotel_tb$is_business <<- hotel_tb$is_business == 'True'
}

load_holiday_mst <- function(){
  holiday_mst <<- read.csv('data/holiday_mst.csv', fileEncoding='UTF-8', header=T, stringsAsFactors=F)
}

load_production <- function(){
  production_tb <<- read.csv('data/production.csv', fileEncoding='UTF-8', header=T, stringsAsFactors=F)
}

load_production_missing_num <- function(){
  production_tb <- read.csv('data/production_missing_num.csv', fileEncoding='UTF-8', header=T, stringsAsFactors=F)
  production_tb$thickness[which(production_tb$thickness=='None')] <- NA
  production_tb$thickness <- as.numeric(production_tb$thickness)
  production_missn_tb <<- production_tb
}

load_production_missing_category <- function(){
  production_tb <- read.csv('data/production_missing_category.csv', fileEncoding='UTF-8', header=T, stringsAsFactors=F)
  production_tb$fault_flg[which(production_tb$fault_flg=='None')] <- NA
  production_tb$fault_flg <- as.logical(production_tb$fault_flg)
  production_missc_tb <<- production_tb
}

load_monthly_index <- function(){
  monthly_index_tb <<- read.csv('data/monthly_index.csv', fileEncoding='UTF-8', header=T, stringsAsFactors=F)
}

load_meros_txt <- function(){
  meros <<- gsub('\t|\n','', paste(readLines('data/txt/meros.txt'), collapse='\n'))
}

load_txt_df <- function(){
  meros <- gsub('\t|\n','', paste(readLines('data/txt/meros.txt'), collapse='\n'))
  aguni <- gsub('\t|\n','', paste(readLines('data/txt/aguni.txt'), collapse='\n'))
  torokko <- gsub('\t|\n','', paste(readLines('data/txt/torokko.txt'), collapse='\n'))
  txt_df <<- data.frame(
    title=c('走れメロス','アグ二の国','トロッコ'),
    text=c(meros,aguni,torokko)
  )
}