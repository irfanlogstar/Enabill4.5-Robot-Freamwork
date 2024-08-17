
*** Settings ***
Library    SeleniumLibrary
Documentation    Manual Invoice Requests 
Library           ExcelLibrary
Library           String
Library    Collections


Resource    Common_Keyword.robot

*** Variables ***
${Manual Invoice Requests}        xpath://a[@href='/voucherrequestindex']
${AddButton}        xpath://button[@routerlink='/voucherrequestitem/0']
${ShowPendingEvents}        xpath://div[@class='card-header']//button[@class='btn btn-Enabill']
${SelectEvenets}        xpath://td[@role='gridcell' and contains(@class, 'k-table-td') and contains(@class, 'text-center')]//input[@type='checkbox']
${Ref No}           xpath://ng-select[@bindvalue='Code']//div[@class='ng-input']//input[@aria-autocomplete='list']
${Select Booking Number}        xpath://div[@role='option']//span[@class='ng-option-label ng-star-inserted']
${AddChargesButton}        xpath://button[@title='Add']
${NextButton}           //span[text()=' Next ']
${Description_Locator}        xpath://kendo-textbox[@formcontrolname='Description']//input[@class='k-input-inner']

${NextButtonDetail}    xpath://kendo-button[@role='button']//span[text()='Next ']
${SubmitButton}        xpath:(//i[@class='fa fa-floppy-o'])[1]   

${VoucherGroupFilter1}    xpath://a[@title='Voucher Group Column Menu']//kendo-svg-icon[contains(@class, 'k-svg-i-more-vertical')]
${Filter}    xpath://div[@role='button'and contains(text(), 'Filter')]
# //div[@role='button' and contains(@class, 'k-columnmenu-item') and contains(text(), 'Filter')]
${SearchinputTextField}    xpath://kendo-grid-string-filter-menu-input[1]//kendo-grid-filter-menu-input-wrapper[1]//input[@aria-label='Voucher Group Filter']
${Filter2}    xpath://button[@type='submit']

${BASE_URL}    http://172.16.23.54:9009/requestvoucher/
${ClickOnInvNumber}    //td[contains(@class, 'k-table-td')]/a

${InvStatus}        //span[contains(text(),'Pending')]
${ApprovedInv}      //*[text()='Approved']

${Update}        //kendo-button[contains(@class, 'btn btn-Enabill')]


${FilePath1}       ${CURDIR}${/}..\\Robot_Data_Library\\Charge Data.xlsx
${SheetName1}         Charges

${TABLELOCATOR}        //table[@class='k-grid-table k-table k-table-md']




*** Keywords ***
    

Wait For Loader To Disappear
    Wait Until Element Is Not Visible    xpath://div[@class='loader-div ng-star-inserted']

# Scroll Until Element Is Visible
    # [Arguments]    ${locator}    ${timeout}=10s
    # ${status} =    Run Keyword And Return Status    Element Should Be Visible    ${locator}    ${timeout}
    # FOR    ${counter}    IN RANGE    1    100
        # Exit For Loop If    ${status}
        # Log    Scrolling attempt ${counter} to find element ${locator}
        # Execute JavaScript    window.scrollBy(0, 500)
        # Sleep    0.5s
        # ${status} =    Run Keyword And Return Status    Element Should Be Visible    ${locator}    ${timeout}
    # END
    # Should Be True    ${status}    Element '${locator}' not visible after scrolling
    
Retry Click Element
    [Arguments]    ${locator}    ${attempts}=2    ${delay}=1s
    ${attempts} =    Convert To Integer    ${attempts}
    FOR    ${counter}    IN RANGE    1    ${attempts + 1}
        Log    Attempt ${counter} to click element ${locator}
        ${result} =    Run Keyword And Ignore Error    Click Element    ${locator}
        ${status} =    Run Keyword And Return Status    Element Should Be Visible    ${locator}
        ${stale} =    Run Keyword And Return Status    Is Element Stale   ${locator}
        Exit For Loop If    ${status} or not ${stale}
        Sleep    ${delay}
    END
    Should Be True    ${status}    Element '${locator}' not visible after ${attempts} attempts
    
Is Element Stale
    [Arguments]    ${locator}
    [Documentation]    Check if the element is stale and return status.
    ${result} =    Run Keyword And Ignore Error    SeleniumLibrary.Element Should Be Visible    ${locator}
    ${stale} =    Evaluate    ${result}[0] == 'FAIL'
    [Return]    ${stale}

Click On Manual Invoice Requests 
    Wait Until Element Is Visible    ${Manual Invoice Requests} 
    Click Link   ${Manual Invoice Requests}
    Click Element    ${AddButton}   

# Select Invoice through Ref number filed
# [Arguments]    ${BookingNo}
# Wait Until Keyword Succeeds    1 min    5 sec    Select Event With Booking Number     ${BookingNo}
    

Filter
    [Arguments]    ${BlNumber}
    Wait For Loader To Disappear
    Wait Until Element Is Visible    ${VoucherGroupFilter1}    
    Click Element    ${VoucherGroupFilter1}
    Sleep    5s    
       
    Wait Until Element Is Visible    ${Filter}
    Click Element    ${Filter}
    
    Wait Until Element Is Visible    ${SearchinputTextField}
    Log    Inputting text in ${SearchinputTextField}
    Capture Page Screenshot
    Input Text    ${SearchinputTextField}    ${BlNumber}
    
    Wait Until Element Is Visible    ${Filter2}
    Click Element    ${Filter2}      
   
        
Select Event With Booking Number  
    [Arguments]    ${Description}
    Wait For Loader To Disappear
    
    Wait Until Element Is Visible    ${ShowPendingEvents}  
    Click Element    ${ShowPendingEvents} 
    
    Wait Until Element Is Visible     ${SelectEvenets}       
    Select Checkbox    ${SelectEvenets}
    Sleep    5s    
    
    # Execute JavaScript  window.scrollBy(0, 55000)
     Scroll Element Into View    ${AddChargesButton}   
    # Wait for element visible    ${AddChargesButton}    5s 
    Click Element    ${AddChargesButton} 
    Retry Click Element    ${AddChargesButton}    
        

    Wait Until Element Is Visible    ${Description_Locator}    
    Input Text    ${Description_Locator}    ${Description} 
    Sleep    3s     
    
    # Execute JavaScript  window.scrollTo(0, 5000)
    Scroll Element Into View    ${NextButton} 
    # Wait for element visible    ${NextButton}    5s
    # Retry Click Element    ${NextButton}  
    Click Element    ${NextButton}
    
Invoice Details Screen
    
    Wait Until Element Is Visible      ${NextButtonDetail}   timeout=10s
    Click Element    ${NextButtonDetail}
    # Retry Click Element   ${NextButtonDetail}
    Sleep    5s        
  
     
    Wait Until Element Is Visible      ${SubmitButton}   timeout=10s
    Click Element    ${SubmitButton} 
    Sleep    5s  
    

Retrieve and Log Invoice Number
    Wait Until Element Is Visible    xpath=//td[contains(@class, 'k-table-td')]/a    timeout=30s
    ${invoice_number}=    Get Text    xpath=//td[contains(@class, 'k-table-td')]/a
    ${current_url}=    Get Location
    ${request_id}=    Evaluate    '''${current_url}'''.split('/')[-1]
    Log    Invoice Number: ${invoice_number}, Request ID: ${request_id}
    
    Wait Until Element Is Visible        ${ClickOnInvNumber}  
    Click Element        ${ClickOnInvNumber}
    
    # Wait Until Element Is Visible       ${InvStatus}  
    # Click Element        ${InvStatus}
    
    # Wait Until Element Is Visible        ${ApprovedInv}
    # Click Element        ${ApprovedInv}   
    
    # Wait Until Element Is Visible        ${Update}  
    # Click Element        ${Update}    
    # Sleep    5s  
    


        
    # Read Excel For charge 
        # [Arguments]    ${filepath}  ${Sheet}   ${Rowno}    ${Columnno}
        # Open Excel Document    ${filepath}    ${Sheet}
        # ${data}         Read Excel Cell    ${Rowno}     ${Columnno}   
        # [Return]    ${data}
        # Close All Excel Documents
    
    
# Invoice Expected Charges Data
    # [Documentation]   TO want to verify if the system allows a user to log into the Enabill system using a valid username and password.
    # ${Charge}=    Read Excel For charge    ${FilePath1}    ${SheetName1}    2    1
    # ${Unit}=    Read Excel For charge    ${FilePath1}    ${SheetName1}    2    2
    # ${Rate}=    Read Excel For charge    ${FilePath1}    ${SheetName1}    2    3
    # ${Waiver}=    Read Excel For charge    ${FilePath1}    ${SheetName1}    2    4
    # ${Amount}=    Read Excel For charge    ${FilePath1}    ${SheetName1}    2    5
    # # Disaply The Enabill Logo
    


# table data
    # ${AllData}    Get Text    ${TABLELOCATOR} 
    # ${Rows}    Get Element Count    //table[@class='k-grid-table k-table k-table-md']/tbody/tr
    # ${Columns}     Get Element Count  //table[@class='k-grid-header-table k-table k-table-md']//tr/th
    
    # # ${rows_str}=    Convert To String    ${Rows}
    # # Log To Console    Number of Rows is: ${rows_str}
    # # ${column_str}=    Convert To String    ${Columns}
    # # Log To Console    Number of coulmn  is: ${column_str}
     
    # Sleep    5s    
    # ${datarows}    Get Text     //table[@class='k-grid-table k-table k-table-md']/tbody/tr[1]
    # Log To Console     ${datarows}    
    # ${datarows}    Get Text     //table[@class='k-grid-table k-table k-table-md']/tbody/tr[2]
    
    # ${datacolumn}    Get Text     //table[@class='k-grid-table k-table k-table-md']/tbody/tr[2]/td[5]
    # Log To Console     ${datacolumn}
    
    # Sleep    5s    
    # ${datarows}    Get Text     //table[@class='k-grid-table k-table k-table-md']/tbody/tr[2]
    # Log To Console     ${datarows}    
    # ${datacolumn}    Get Text     //table[@class='k-grid-table k-table k-table-md']/tbody/tr/td[2]
    # Log To Console     ${datacolumn}
    
