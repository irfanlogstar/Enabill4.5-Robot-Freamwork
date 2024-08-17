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
${searchbox}    //input[@id='Search']


${SiteURL}     http://172.16.23.54:9009/login
${Browser}    chrome
${FilePath}   ${CURDIR}${/}..\\Robot_Data_Library\\Data.xlsx
${SheetName}     Login
    
*** Keywords ***
Scroll Until Element Is Visible
    [Arguments]    ${locator}    ${timeout}=10s
    ${status} =    Run Keyword And Return Status    Element Should Be Visible    ${locator}    ${timeout}
    FOR    ${counter}    IN RANGE    1    2
        Exit For Loop If    ${status}
        Log    Scrolling attempt ${counter} to find element ${locator}
        Execute JavaScript    window.scrollBy(0, 500)
        Sleep    0.5s
        ${status} =    Run Keyword And Return Status    Element Should Be Visible    ${locator}    ${timeout}
    END
    Should Be True    ${status}    Element '${locator}' not visible after scrolling
    
 
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
    
TC001K_Login_In_Enabill_4.5 with valid Credentials
    [Documentation]   TO want to verify if the system allows a user to log into the Enabill system using a valid username and password.
    Open My Browser    ${SiteURL}    ${Browser}
    ${UserName}=    Read Excel    ${FilePath}    ${SheetName}    2    1
    ${Password}=    Read Excel    ${FilePath}    ${SheetName}    2    2
    Login With Credentials      ${UserName}    ${Password}
    # Disaply The Enabill Logo


    
# SerachFunctionality
Serach
    [Arguments]    ${Serach}
    Wait Until Element Is Visible    ${searchbox}
    Input Text    ${searchbox}     ${Serach}   
     
    


    

     



