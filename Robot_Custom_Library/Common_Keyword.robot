*** Setting ***
Library    SeleniumLibrary
Documentation    login page
Library    ExcelLibrary 

*** Variables ***
#Login Page Locators
${Text_UserName}  xpath://input[@id='email']
${Text_Password}  id=password
${Button_Login}   id=Login
${EnabillLogo}    xpath://img[@id='logo']
${EnvalidUserName}    xpath://div[@class='alert alert-danger']

    
*** Keywords ***
Open My Browser
     [Arguments]    ${SiteURL}   ${Browser}
     Open Browser   ${SiteURL}   ${Browser}
     Maximize Browser Window
     
EnterUserName
    [Arguments]    ${Username} 
    Input Text    ${Text_UserName}    ${Username}     
EnterPassword
      [Arguments]    ${Password}
      Input Text    ${Text_Password}    ${Password}    
      
Click On Login Button
    Click Button    ${Button_Login} 
     
Login With Credentials
    [Arguments]     ${username}    ${password}
    EnterUserName    ${Username}  
    EnterPassword    ${Password}  
    Click On Login Button
    
Disaply The Enabill Logo
    Wait Until Element Is Visible   ${EnabillLogo}
    
Display Invalid User
     Wait Until Element Is Visible   ${EnvalidUserName}  

Read Excel
    [Arguments]    ${filepath}  ${Sheet}   ${Rowno}    ${Columnno}
    Open Excel Document    ${filepath}    ${Sheet}
    ${data}         Read Excel Cell    ${Rowno}     ${Columnno}   
    [Return]    ${data}
    Close All Excel Documents
    


    

     



