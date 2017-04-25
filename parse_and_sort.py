# load pandas package for data analysis
import pandas as pd

# import regular expression search package
import re

# retrieve CSV file from github 
url = 'https://raw.githubusercontent.com/dkhots/interview/master/sample_user_file.csv'

# create a data frame from URL and associate a field name to the string
df = pd.read_csv(url, names = ["Userstring"])

# display the contents 
print df.head(20)

# using the Squeeze function to turn the one column dataframe df into a series s
# this is done so string operations can be performed easily 
s=df.T.squeeze()

# replace all numbers with a blank using regular expression search + replace command
schar=s.str.replace(r'\d+','', case=False)

# replace all non numerals with a blank using regular expression search + replace command
snum=s.str.replace(r'\D+','', case=False)

# convert the series to numeric for later sorting purposes
snum2 = pd.to_numeric(snum, errors='coerce')

# concatenate original, numeric and character series into a new data frame
df2 = pd.concat([s, snum2, schar], axis=1).reset_index()

# name the headers
df2.columns = ['index', 'userstring','num_string', 'char_string']

# delete the unnecessary index column
del df2['index']

df2

# sorting data according to problem instructions
df3 = df2.sort_values(by = ['num_string', 'char_string'], ascending=True)

df3 

# keeping a copy for debugging purposes 
df4 = df3

# delete aux fields 
del df4['num_string']
del df4['char_string']

df4

#export CSV (tab delimited) file locally, supress header record
df4.to_csv('C:\Users\dkhots\Documents\GitHub\interview\userfile_parsed_sorted_py.csv',header=False, index=False, sep='\t')

# then just like with SAS, need to synch the github repo 