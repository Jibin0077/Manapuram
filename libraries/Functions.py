import pandas as pd
import openpyxl




def File_Status_update(Portal,Status):
    df = pd.read_excel("D:\\Testing\\Automation Test Case.xlsx", sheet_name='Sheet3')

    i = df[(df['TestName'] == Portal)]
   #& (df['Execute_Flag'] == Flag)]
    if not i.empty:
        dd = df.loc[i.index[0], 'Status'] = Status
    else:
        l = [Portal,Status]
        print(l)
        df.loc[len(df)] = l

    #df.to_excel("D:\\Testing\\Automation Test Case.xlsx",sheet_name='Sheet3',index=False)

    #print(i)
#print(File_Status_update('Portal Launching','pass'))

# import os
# print(os.getcwd()+'\input')
