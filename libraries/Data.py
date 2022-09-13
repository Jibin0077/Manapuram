from cmath import nan
from msilib.schema import Directory
import pandas as pd
import os


def get_init_details():
    relpath = os.getcwd()
    # print(os.getcwd())
    df_from_excel = pd.read_excel(relpath+"\input\Automation Test Case.xlsx", sheet_name='Sheet3').to_dict(orient='records')
    return(df_from_excel)
#print(get_init_details())
    #print(dict_from_csv)
def get_details(Branch):
    client=None
    details=get_init_details()
    v=Branch.strip().lower()
    #print(v)
    for i in details:
        print(i.get('TestName'))
        if v in str(i.get('TestName').strip().lower()):
            return str(i.get('UserName')).strip(),str(i.get('Password')).strip()
    # else:
    #     return 'Kent','1043276819','19625 62nd Ave. South'
            #print(get_init_details())
#print(get_init_details())
#print(get_details('Portal Login'))


def get_delay_details():
    relpath = os.getcwd()
    # print(os.getcwd())
    df_from_excel = pd.read_excel(relpath+"\input\Automation Test Case.xlsx", sheet_name='Sheet2').to_dict(orient='records')
    return(df_from_excel)
    #print(get_delay_details())
    #print(dict_from_csv)
def get_delay(Branch):
    client=None
    details=get_delay_details()
    v=Branch.strip().lower()
    #print(v)
    for i in details:
        print(i.get('TEST CASE NAME'))
        if v in str(i.get('TEST CASE NAME').strip().lower()):
            #return str(i.get('Scheduler')).strip()
            delay = str(i.get('Scheduler')).strip()
            #print(delay)
            if delay == 'nan':
                return  0
            else:
                return delay

    # else:
    #     return 'Kent','1043276819','19625 62nd Ave. South'
            #print(get_init_details())
#print(get_init_details())
#print(get_delay('Portal login with menus validation'))

def current_diectory():
    relpath = os.getcwd()
    # print(os.getcwd())
    curr_dict = relpath+"\input\Automation Test Case.xlsx"
    return curr_dict
print(current_diectory())

