
library(MARSS)

# 导入数据，行是时间（季度频率），列是影响gdp增速的协变量指标和gdp增速
data = read.csv('C:/Users/velly/Desktop/yc/201803.csv', header=FALSE)################
features1 = data

features1

features1 = features1[1,2:35] ################

rows = nrow(features1);rows

cols1 = ncol(features1);cols1

line = rep(NA,rows)

features1 = cbind(features1, line)

features1 = as.matrix(features1)

features1

modd = MARSS(features1)

modd1 = MARSS(y=features1,inits = modd$par)

outt = augment.marssMLE(x=modd1,type.predict = c("observations", "states"), interval = "confidence", conf.level = 0.95)

outt

subdata = subset(outt, t==27);subdata #################

## write.csv(subdata, 'C:/Users/velly/Desktop/yuce201803/18/ZBYCZ201803x.csv')##############

