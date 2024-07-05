*** Setting ***
Library    SeleniumLibrary
Documentation    login page
Library    ExcelLibrary  


Resource    ../Custom_Variables/All_Locators.robot

*** Keywords ***
Open My Browser
    [Arguments]    ${SiteURL}   ${Browser}
    Open Browser   ${SiteURL}   ${Browser}
    Maximize Browser Window

Enter UserName
    [Arguments]    ${Username} 
    Input Text    ${Text_UserName}    ${Username}

Enter Password
    [Arguments]    ${Password}
    Input Text    ${Text_Password}    ${Password}

Click On Login Button
    Click Button    ${Button_Login}

Read Excel
    [Arguments]    ${filepath}    ${Sheetname}    ${Rowno}    ${Columnno}
    Open Excel Document    ${filepath}    1
    Get Sheet    ${Sheetname}
    ${data}    Read Excel Cell    ${Rowno}     ${Columnno}
    [Return]    ${data}
    Close All Excel Documents

Login Into Enabill System
    [Arguments]    ${SiteURL}   ${Browser}   ${filepath}   ${Sheetname}   ${UsernameRowno}   ${UsernameColumnno}   ${PasswordRowno}   ${PasswordColumnno}
    Open My Browser    ${SiteURL}   ${Browser}
    ${username}    Read Excel    ${filepath}   ${Sheetname}   ${UsernameRowno}   ${UsernameColumnno}
    ${password}    Read Excel    ${filepath}   ${Sheetname}   ${PasswordRowno}   ${PasswordColumnno}
    Enter UserName    ${username}
    Enter Password    ${password}
    Click On Login Button