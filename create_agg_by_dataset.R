
# Crops

aggregate_groups_faostat_sws <- ReadDatatable('aggregate_groups_faostat_sws',
                                              where = "domain_name = 'Crops' ")

dataset <- unique(aggregate_groups_faostat_sws$domain_name)
area <- unique(c(aggregate_groups_faostat_sws[var_type == 'area', var_code_sws], 
               aggregate_groups_faostat_sws[var_type == 'area', var_group_code_sws2]))

geographicAreaM49 <- area[!is.na(area)]

measuredElement <- c(5510, 5312)

measuredItemCPC <- unique(c(aggregate_groups_faostat_sws[var_type == 'item', var_code_sws], 
                 aggregate_groups_faostat_sws[var_type == 'item', var_group_code_sws]))

qualityIndicators <- GetCodeList('quality_indicators', 'crops_production_qi', 'qualityIndicators')[, list(code)]
setnames(qualityIndicators, 'code', 'qualityIndicators')


crops <- data.table(dataset = dataset,
                    geographicAreaM49 = geographicAreaM49,
                    measuredElement = measuredElement,
                    measuredItemCPC = measuredItemCPC,
                    qualityIndicators)
crops
crops <- nameData('quality_indicators', 'crops_production_qi', crops)
crops[, item_code_name := paste0(measuredItemCPC, ' - ', measuredItemCPC_description)]

setnames(crops, 
         old = c("geographicAreaM49", "geographicAreaM49_description", 
                 "measuredElement", "measuredElement_description", "measuredItemCPC", 
                 "measuredItemCPC_description", "qualityIndicators", "qualityIndicators_description"),
         new = c("area", "area_name", "element", "element_name", "item", "item_name", 
                 "quality_indicators", "quality_indicators_name"))

## Livestock Production

aggregate_groups_faostat_sws <- ReadDatatable('aggregate_groups_faostat_sws',
                                              where = "domain_name = 'Livestock Primary' ")

dataset <- unique(aggregate_groups_faostat_sws$domain_name)
area <- unique(c(aggregate_groups_faostat_sws[var_type == 'area', var_code_sws], 
                 aggregate_groups_faostat_sws[var_type == 'area', var_group_code_sws2]))

geographicAreaM49 <- area[!is.na(area)]

measuredElement <- c(5313, 5314, 5318, 5319, 5320, 5321, 5417, 5422, 5424, 5510)

measuredItemCPC <- unique(c(aggregate_groups_faostat_sws[var_type == 'item', var_code_sws], 
                            aggregate_groups_faostat_sws[var_type == 'item', var_group_code_sws]))

qualityIndicators <- GetCodeList('quality_indicators', 'crops_production_qi', 'qualityIndicators')[, list(code)]
setnames(qualityIndicators, 'code', 'qualityIndicators')


livestock_prod <- data.table(dataset = dataset,
                    geographicAreaM49 = geographicAreaM49,
                    measuredElement = measuredElement,
                    measuredItemCPC = measuredItemCPC,
                    qualityIndicators)
livestock_prod
livestock_prod <- nameData('quality_indicators', 'crops_production_qi', livestock_prod)
livestock_prod[, item_code_name := paste0(measuredItemCPC, ' - ', measuredItemCPC_description)]

setnames(livestock_prod, 
         old = c("geographicAreaM49", "geographicAreaM49_description", 
                 "measuredElement", "measuredElement_description", "measuredItemCPC", 
                 "measuredItemCPC_description", "qualityIndicators", "qualityIndicators_description"),
         new = c("area", "area_name", "element", "element_name", "item", "item_name", 
                 "quality_indicators", "quality_indicators_name"))


# Trade Live Animals

aggregate_groups_faostat_sws <- ReadDatatable('aggregate_groups_faostat_sws',
                                              where = "domain_name = 'Live animals' ")

dataset <- 'Trade Live Animals'
area <- unique(c(aggregate_groups_faostat_sws[var_type == 'area', var_code_sws], 
                 aggregate_groups_faostat_sws[var_type == 'area', var_group_code_sws2]))

geographicAreaM49 <- area[!is.na(area)]

measuredElement <- c(5607, 5608, 5609, 5622, 5907, 5908, 5909, 5922)

measuredItemCPC <- unique(c(aggregate_groups_faostat_sws[var_type == 'item', var_code_sws], 
                            aggregate_groups_faostat_sws[var_type == 'item', var_group_code_sws]))

qualityIndicators <- GetCodeList('quality_indicators', 'crops_production_qi', 'qualityIndicators')[, list(code)]
setnames(qualityIndicators, 'code', 'qualityIndicators')


live_animals <- data.table(dataset = dataset,
                             geographicAreaM49 = geographicAreaM49,
                             measuredElement = measuredElement,
                             measuredItemCPC = measuredItemCPC,
                             qualityIndicators)
live_animals
live_animals <- nameData('quality_indicators', 'crops_production_qi', live_animals)
live_animals[, item_code_name := paste0(measuredItemCPC, ' - ', measuredItemCPC_description)]

setnames(live_animals, 
         old = c("geographicAreaM49", "geographicAreaM49_description", 
                 "measuredElement", "measuredElement_description", "measuredItemCPC", 
                 "measuredItemCPC_description", "qualityIndicators", "qualityIndicators_description"),
         new = c("area", "area_name", "element", "element_name", "item", "item_name", 
                 "quality_indicators", "quality_indicators_name"))

# Trade Crops Livestock

aggregate_groups_faostat_sws <- ReadDatatable('aggregate_groups_faostat_sws',
                                              where = "domain_name = 'Crops and livestock products' ")

dataset <- 'Trade Crops and Livestock products'
area <- unique(c(aggregate_groups_faostat_sws[var_type == 'area', var_code_sws], 
                 aggregate_groups_faostat_sws[var_type == 'area', var_group_code_sws2]))

geographicAreaM49 <- area[!is.na(area)]

measuredElement <- c(5610, 5622, 5910, 5922)

measuredItemCPC <- unique(c(aggregate_groups_faostat_sws[var_type == 'item', var_code_sws], 
                            aggregate_groups_faostat_sws[var_type == 'item', var_group_code_sws]))

qualityIndicators <- GetCodeList('quality_indicators', 'crops_production_qi', 'qualityIndicators')[, list(code)]
setnames(qualityIndicators, 'code', 'qualityIndicators')


trade_crops_livestock <- data.table(dataset = dataset,
                           geographicAreaM49 = geographicAreaM49,
                           measuredElement = measuredElement,
                           measuredItemCPC = measuredItemCPC,
                           qualityIndicators)
trade_crops_livestock
trade_crops_livestock <- nameData('quality_indicators', 'crops_production_qi', trade_crops_livestock)
trade_crops_livestock[, item_code_name := paste0(measuredItemCPC, ' - ', measuredItemCPC_description)]

setnames(trade_crops_livestock, 
         old = c("geographicAreaM49", "geographicAreaM49_description", 
                 "measuredElement", "measuredElement_description", "measuredItemCPC", 
                 "measuredItemCPC_description", "qualityIndicators", "qualityIndicators_description"),
         new = c("area", "area_name", "element", "element_name", "item", "item_name", 
                 "quality_indicators", "quality_indicators_name"))


data_binded <- rbind(crops, livestock_prod, live_animals, trade_crops_livestock)
data_binded[, .N, dataset]
## Read the old table from SWS

old_data <- ReadDatatable('dataset_code_list_qi')
old_data[, .N, dataset]

filter_old_data <- old_data[dataset %in% c('Pesticides Use', 'Forestry Production and Trade',
                                           'Fertilizers by Nutrient', 'Fertilizers by Product',
                                           'Pesticides Trade', 'Land Use')]

new_data <- rbind(data_binded, filter_old_data)
new_data

table <- 'dataset_code_list_qi'
changeset <- Changeset(table)
AddInsertions(changeset, new_data)
Finalise(changeset)
