*** Settings ***
Documentation       Template robot main suite.
Library             RPA.Browser.Selenium
Library             RPA.core.notebook
Library             Collections
Library             MyLibrary.py
Resource            keywords.robot
Variables           MyVariables.py
#Library             Functions.py
Library            RPA.Excel.Files
Resource            Filtering.robot
Library            Data.py


     
*** Keywords ***
Data Collection
    ${data}     Create Dict
    # Log To Console    ${data}
    Set Global Variable    ${details}   ${data} 
    # Return From Keyword        ${details}


    &{out_config}=  Create Dictionary
    Open Workbook  ${CONFIG_FILE}
    Log To Console   Reading worksheet: ${CONFIG_SHEET}
    ${table}=  Read Worksheet As Table    ${CONFIG_SHEET}  header=${True}
    FOR    ${row}    IN    @{table}
        IF    "${row['Name']}" != "${null}"
            Set To Dictionary    ${out_config}  ${row['Name']}  ${row['Value']}
        END
    END
    Set Global Variable    ${CONFIG}    ${out_config}
    Close Workbook


*** Keywords *** 
#------------- launching URL successfully in the Edge browser with a label as "Welcome To Manappuram Finance Limited Customer eService Portal"---------#
Portal Launching
    [Arguments]        ${TestCase_Id}
    
    ${Browser}  Set Variable    ${CONFIG}[Browser]
    IF     '${Browser}' == 'Chrome'
        ${path}    Chromedriver_diectory
        Open Browser         ${CONFIG}[URL]       browser=${Browser}      executable_path=${path}   
    ELSE
        ${path}    Edgedriver_diectory
        Open Browser         ${CONFIG}[URL]       browser=${Browser}      executable_path=${path}   
    END
    # Open Browser         ${CONFIG}[URL]       browser=${Browser}      executable_path=C:\\Users\\Q0041\\Documents\\Robots\\Manapuram\\chromedriver.exe   
    Maximize Browser Window
    Sleep  2s
    ${Text_Vis}        Is Element Visible    //div[contains(text(),"Welcome To Manappuram Finance Limited Customer eService Portal")]
    IF    ${Text_Vis}
        Return From Keyword        pass
    ELSE 
        Return From Keyword        fail
    END

Portal Login
#-------------logging in with the provided user id and  password-----------------#
    [Arguments]        ${TestCase_Id}
    ${UserName}=  Set Variable    ${details}[${TestCase_Id}][username]
    ${Password}=  Set Variable    ${details}[${TestCase_Id}][password]
    # ${Delay}=     Set Variable    ${details}[TC_03][Scheduler]
    Wait Until Keyword Succeeds    8x   7     Wait Until Element Is Visible    //*[@id="username"]
    Input Text    //*[@id="username"]        ${UserName}
    Wait Until Keyword Succeeds    8x   7     Wait Until Element Is Visible    //*[@id="password"]
    Input Password    //*[@id="password"]    ${Password}
    Click Element If Visible    //*[@id="txt_login"]
    Sleep    2s
    ${Login_err}     Is Element Visible     //*[contains(text(),"Sorry! you have tried to enter invalid credentials")]
    IF  ${Login_err}
        Return From Keyword        fail
    ELSE
        Return From Keyword        pass
    END

Quick Pay in Portal
#----------- launched successfully in the Edge browser with a button as "QUICK PAY"--------------#
    [Arguments]        ${TestCase_Id}
    # ${Delay}=     Set Variable    ${details}[TC_02][Scheduler]
    ${Bttn_Vis}     Is Element Visible     //*[@id="expresspay"]
    IF  ${Bttn_Vis}
        Return From Keyword        pass
    END

Portal Login with Email Notification
#---------Email notification is prompted-----------#
    [Arguments]        ${TestCase_Id}
    # ${Delay}=     Set Variable    ${details}[TC_04][Scheduler]
    ${Email_Vis}     Is Element Visible      //*[@id="modal"]//*[@id="Img1"]
    IF  ${Email_Vis}
        # Sleep  ${Delay}
        Click Element When Visible        //*[@id="modal"]//*[@id="Img1"]
        Return From Keyword        pass
    ELSE
        Return From Keyword        fail
    END

Portal login with menus validation
#------------Checking for the main menus as 'Make Payment','Online Gold Disbursal','Support','Customer Profile','Download Pawn Ticket','FAQ'--------------#
   [Arguments]        ${TestCase_Id}
    # ${Delay}=     Set Variable    ${details}[TC_05][Scheduler]
    @{Menu_list}    Create List    Make Payment    Customer Profile    Online Gold Loan Disbursal    Support    Download Pawn Ticket
    FOR    ${element}    IN    @{Menu_list}
        ${Menu_Vis}     Is Element Visible     //*[contains(text(),"${element}")]
        IF  ${Menu_Vis}
            ${status}    Set Variable    pass
        ELSE 
            Return From Keyword          fail
        END
    END
    Return From Keyword        ${status}

Portal Login with the user verification
    [Arguments]        ${TestCase_Id}
#----------------Verifying the user name------------------#
    # ${User}     ${Nan}     get_details    Portal Login with the user verification
    ${User}=      Set Variable    ${details}[${TestCase_Id}][username]
    # ${Delay}=     Set Variable    ${details}[TC_06][Scheduler]
    Wait Until Element Is Visible    //*[@id="lbl_user_id"]
    ${User_name}     Get Text        //*[@id="lbl_user_id"]
    IF    '${User_name}' == '${User}'
        Return From Keyword        pass
    ELSE 
        Return From Keyword        fail
    END
    
Portal sign out
#-----------------Signing out of the portal---------------#
    [Arguments]        ${TestCase_Id}
    # ${Delay}=     Set Variable    ${details}[TC_07][Scheduler]
    Wait Until Page Contains Element    //*[@class="top-links"]//*[contains(text(),"Sign Out")]
    Click Element            //*[@class="top-links"]//*[contains(text(),"Sign Out")]
    Return From Keyword        pass

PayTM Login
#------------------launching Paytm on click the Paytm button on the portal---------------#
    [Arguments]        ${TestCase_Id}
    # ${Delay}=     Set Variable    ${details}[TC_08][Scheduler]
    Wait Until Keyword Succeeds    3x   5     Wait Until Page contains Element     //*[@class="form-block-3 w-clearfix w-form"]//*[@class="image-2 paytmbtn "] 
    Click Element    //*[@class="form-block-3 w-clearfix w-form"]//*[@class="image-2 paytmbtn "]  
    Return From Keyword        pass
    
