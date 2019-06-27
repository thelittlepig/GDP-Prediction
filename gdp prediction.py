#!/usr/bin/env python
# coding: utf-8

# In[2689]:


import pandas as pd
import numpy as np
from sklearn.feature_selection import SelectKBest
from sklearn.feature_selection import f_regression
from sklearn.linear_model import LinearRegression, Lasso


# ### 导入影响gdp增速的协变量数据

# In[2690]:


df_all = pd.read_csv('C:/Users/velly/Desktop/yuce201803/15/201803.csv', encoding='gbk', header=None)


# In[2691]:


df_all


# In[2692]:


df_all = df_all.T


# In[2693]:


df_all.columns = df_all.iloc[0,:]


# In[2694]:


df_all = df_all.drop([0])


# In[2695]:


df_all = df_all.fillna(df_all.mean())


# In[ ]:





# In[2696]:


df_all


# ### 导入预测出的下一期数据

# In[2697]:


data_fit = pd.read_csv('C:/Users/velly/Desktop/yuce201803/15/ZBYCZ201803.csv', encoding='gbk')


# In[2698]:


data_fit['.rownames'] = df_all.columns[:-1]


# In[2699]:


data_fit


# ### 方案一：先做特征选择再做回归预测

# In[2770]:


nn =11


# In[2771]:


out = SelectKBest(f_regression, k=nn).fit(df_all.iloc[:,:-1],df_all.iloc[:,-1])


# In[2772]:


df_all.columns[np.argsort(-out.scores_)[:nn]]


# In[2773]:


X_new = SelectKBest(f_regression, k=nn).fit_transform(df_all.iloc[:,:-1],df_all.iloc[:,-1]);X_new


# In[2762]:


# 列名需要对照数据输入
col = np.array(['社会消费品零售总额', '规模以上工业增加值增速', '建筑业现价增长速度', '公路运输总周转量增速', '金融机构人民币存贷款余额增速',
       '财政支出' ,'邮政业务总量增速'])


# In[2763]:


Y = np.array(df_all.iloc[:,-1])


# In[ ]:





# In[2764]:


model = LinearRegression()
model.fit(X_new, Y)
model.score(X_new, Y)


# In[2765]:


x_new = np.array([data_fit.loc[[True if x in col else False for x in data_fit['.rownames']],'.fitted']]);x_new


# In[2766]:


model.predict(x_new)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




