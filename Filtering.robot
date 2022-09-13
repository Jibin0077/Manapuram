*** Settings ***
Documentation       Template robot main suite.
# Library             RPA.Browser.Selenium
Library             RPA.core.notebook
# Library             Collections
# Library             MyLibrary.py
# Resource            keywords.robot
# Variables           MyVariables.py
#Library             Functions.py
Library             Data.py
Library            RPA.Excel.Files
Library            RPA.Tables
Library        Collections


*** variable ***
${URL}               https://online.manappuram.com/
# ${File}              D:\\Automation Test Case.xlsx


*** Keywords ***
Filtering Data
    ${File}     current_diectory
    Open Workbook       ${File}
    ${data}=  Read Worksheet As Table  Sheet2  header=${True}
    Close Workbook
    Filter Table By Column  ${data}    Execute_Flag  ==  YES
    # Log To Console    ${data}
    @{Menu_list}    Create List        

    FOR    ${element}    IN    @{data}
        Notebook Print         ${element}
        Append To List        ${Menu_list}   ${element}[TEST CASE ID]     
    END 
    # Log To Console        ${Menu_list}    
    Notebook Print        ${Menu_list}

    Open Workbook       ${File}
    ${data2}=  Read Worksheet As Table  Sheet3  header=${True}
    Close Workbook  
    Filter Table By Column  ${data2}    TestCase_Id  in  ${Menu_list}
    Log To Console    ${data2}
    Return From Keyword        ${data2}



Create Dict
    ${File}     current_diectory
    Open Workbook       ${File}
    ${data}=  Read Worksheet As Table  Sheet2  header=${True}
    Close Workbook
    Filter Table By Column  ${data}    Execute_Flag  ==  YES
    # Log To Console    ${data}

    &{alldata}=  Create Dictionary
    

    FOR    ${row}    IN    @{data}
        # Log To Console   ${row}[TEST CASE NAME]
        # Log To Console   ${row['TEST CASE ID']}
   
        &{valuedata}=  Create Dictionary 
        ...  TEST CASE NAME  ${row}[TEST CASE NAME]
        ...  Execute_Flag  ${row}[Execute_Flag]
        ...  Scheduler  ${row}[Scheduler]

        Set To Dictionary    ${alldata}    ${row['TEST CASE ID']}   ${valuedata}
    END

    # Log To Console    ${alldata}

    Open Workbook       ${File}
    ${data2}=  Read Worksheet As Table  Sheet3  header=${True}
    Close Workbook  
    Filter Table By Column  ${data2}    TestCase_Id  in  ${alldata.keys()}
    # Log To Console    ${data2}


    FOR    ${row}    IN    @{data2}
        # Log To Console   ${alldata}[${row}[TestCase_Id]]

        Set To Dictionary    ${alldata}[${row['TestCase_Id']}]
        ...  username  ${row}[UserName]
        ...  password  ${row}[Password]
        
    END

    Log To Console    ${alldata}[TC_02][username]
    Return From Keyword    ${alldata}


