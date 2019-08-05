# Attach Packages
library(caret)
library(groupdata2)
library(cvms)
set.seed(1)
# Load Sacramento dataset
data(Sacramento)
# Assign data to variable name
full_data <- Sacramento 
# Summarize the dataset
summary(full_data)
##              city          zip           beds           baths      
##  SACRAMENTO    :438   z95823 : 61   Min.   :1.000   Min.   :1.000  
##  ELK_GROVE     :114   z95828 : 45   1st Qu.:3.000   1st Qu.:2.000  
##  ROSEVILLE     : 48   z95758 : 44   Median :3.000   Median :2.000  
##  CITRUS_HEIGHTS: 35   z95835 : 37   Mean   :3.276   Mean   :2.053  
##  ANTELOPE      : 33   z95838 : 37   3rd Qu.:4.000   3rd Qu.:2.000  
##  RANCHO_CORDOVA: 28   z95757 : 36   Max.   :8.000   Max.   :5.000  
##  (Other)       :236   (Other):672                                  
##       sqft                type         price           latitude    
##  Min.   : 484   Condo       : 53   Min.   : 30000   Min.   :38.24  
##  1st Qu.:1167   Multi_Family: 13   1st Qu.:156000   1st Qu.:38.48  
##  Median :1470   Residential :866   Median :220000   Median :38.62  
##  Mean   :1680                      Mean   :246662   Mean   :38.59  
##  3rd Qu.:1954                      3rd Qu.:305000   3rd Qu.:38.69  
##  Max.   :4878                      Max.   :884790   Max.   :39.02  
##                                                                    
##    longitude     
##  Min.   :-121.6  
##  1st Qu.:-121.4  
##  Median :-121.4  
##  Mean   :-121.4  
##  3rd Qu.:-121.3  
##  Max.   :-120.6  
# Count observations per city
sort( table(full_data$city) )
## 
##            COOL DIAMOND_SPRINGS      FORESTHILL   GARDEN_VALLEY 
##               1               1               1               1 
##       GREENWOOD          MATHER    MEADOW_VISTA          PENRYN 
##               1               1               1               1 
##    WALNUT_GROVE       EL_DORADO          LOOMIS     GRANITE_BAY 
##               1               2               2               3 
##   POLLOCK_PINES  RANCHO_MURIETA WEST_SACRAMENTO         ELVERTA 
##               3               3               3               4 
##      GOLD_RIVER          AUBURN          WILTON    CAMERON_PARK 
##               4               5               5               9 
##       FAIR_OAKS     PLACERVILLE      ORANGEVALE       RIO_LINDA 
##               9              10              11              13 
##          FOLSOM         ROCKLIN      CARMICHAEL            GALT 
##              17              17              20              21 
## NORTH_HIGHLANDS         LINCOLN EL_DORADO_HILLS  RANCHO_CORDOVA 
##              21              22              23              28 
##        ANTELOPE  CITRUS_HEIGHTS       ROSEVILLE       ELK_GROVE 
##              33              35              48             114 
##      SACRAMENTO 
##             438
# Create one-hot encoded factor column describing 
# if the city is Sacramento or not
full_data$in_sacramento <- factor(
  ifelse(full_data$city == "SACRAMENTO", 1, 0)
)
# Count observations per city condition
table(full_data$in_sacramento)
## 
##   0   1 
## 494 438
partitions <- partition(full_data, p = 0.8, 
                        cat_col = "in_sacramento")
train_set <- partitions[[1]]
valid_set <- partitions[[2]]
# Fit model where price is predicted by in_sacramento
lin_model <- lm(price ~ in_sacramento, data = train_set)
# Inspect the model summary
summary(lin_model)
## 
## Call:
## lm(formula = price ~ in_sacramento, data = train_set)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -261719  -82372  -25719   54491  593071
## 
## Coefficients:
##                Estimate Std. Error t value Pr(>|t|)    
## (Intercept)      291719       6214   46.94   <2e-16 ***
## in_sacramento1   -91427       9067  -10.08   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 123500 on 743 degrees of freedom
## Multiple R-squared:  0.1204, Adjusted R-squared:  0.1192 
## F-statistic: 101.7 on 1 and 743 DF,  p-value: < 2.2e-16
