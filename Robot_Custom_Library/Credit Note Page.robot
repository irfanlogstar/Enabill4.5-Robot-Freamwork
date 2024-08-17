*** Settings ***
Library    SeleniumLibrary
Documentation    Credit&Debit Note
Resource    Common_Keyword.robot

*** Variables ***
${Credit&DebitNote}    xpath://a[@href='/manualcdnoteindex']
${AddButton}    //button[@routerlink='/manualcdnoteitem/0']
${SelectVoucherTypeDRD}    xpath://kendo-dropdownlist[@formcontrolname='VoucherTypeID']//button[@unselectable='on']
${VoucherTemplate}    xpath://kendo-dropdownlist[@formcontrolname='VoucherTemplateID']//button[@unselectable='on']
${ClickCustomerField}        //div[@role='combobox']/input
${CustomerOptionXpath}       //div[@role='option']
${AddCharge}     //span[text()=' Add Charge ']
${Description}        //kendo-textbox[@formcontrolname='Description']//input[contains(@id, 'k-') and @class='k-input-inner']
${SelectChargeDRP}    //kendo-dropdownlist[@formcontrolname='ChargeID']//button[@unselectable='on']
${AddUnit}    //kendo-numerictextbox[@formcontrolname='Multiplier1']//input[@role='spinbutton']
${AddRate}    //kendo-numerictextbox[@formcontrolname='Rate']//input[@role='spinbutton']
${Submit}    //*[contains(text(),'Submit') and ./i[contains(@class, 'fa-floppy-o')]]

*** Keywords ***
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

Wait For Loader To Disappear
    Wait Until Element Is Not Visible    xpath://div[@class='loader-div ng-star-inserted']
    



Click On Credit/Debit Note
    Wait Until Element Is Visible    ${Credit&DebitNote}
    Click Link   ${Credit&DebitNote}
    Click Element    ${AddButton}

Add The Mandatory Fields
    Wait For Loader To Disappear
    [Arguments]   ${CustName}
    Click Element    ${SelectVoucherTypeDRD}
    Sleep    2
    Click Element    //*[text()='']
    
    Wait Until Element Is Visible    ${VoucherTemplate}
    Click Element    ${VoucherTemplate}
    Wait Until Element Is Visible    //*[text()='Credit Note']
    Click Element    //*[text()='Credit Note']
    Sleep    5s    

    Wait Until Element Is Visible    ${ClickCustomerField}   5s 
    Input Text    ${ClickCustomerField}     ${CustName}
    
    Wait Until Element Is Visible     ${CustomerOptionXpath}   5s
    Click Element    ${CustomerOptionXpath}
       
    Sleep    5s   
    
Add Charge 
    [Arguments]    ${AddDrescrption}    ${Unit}    ${Rate}
    Wait Until Element Is Visible    ${AddCharge}   5s
    Click Element    ${AddCharge}

    Scroll Element Into View    ${SelectChargeDRP}
    Wait Until Element Is Visible    ${SelectChargeDRP}    5s
    Click Element    ${SelectChargeDRP}
    Sleep    2
    Wait Until Element Is Visible    //span[text()='Back To Town Ground Rent']   5s
    Click Element        //span[text()='Back To Town Ground Rent']    
   
     
     Execute JavaScript    window.scrollBy(0, 500) 
     Scroll Element Into View    ${Description}
     Wait Until Element Is Visible       ${Description}     5s
     Input Text    ${Description}     ${AddDrescrption}
     
     Wait Until Element Is Visible       ${AddUnit}     5s
     Input Text    ${AddUnit}     ${Unit}
     
     Wait Until Element Is Visible        ${AddRate}     
     Input Text    ${AddRate}         ${Rate}
     

Submit Debit Note   
     Wait Until Element Is Visible    ${Submit}    
     Click Element       ${Submit}    

      
     
    
          
     

     
   

