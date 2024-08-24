*** Setting ***
Library    SeleniumLibrary
Library    ExcelLibrary 
Resource    Common_Keyword.robot
Resource    Manual Invoice Requests Page.robot



*** Variables ***
${Receipt Page}        xpath://a[@href='/receiptindex']
${ReceiptAddButton}           xpath://button[@routerlink='/receiptitem/0']

${ClickCustomerField}       xpath://ng-select[@formcontrolname='PayeeCustomerID']//div[@role='combobox']//input
${CustomerOptionXpath}      xpath://div[@role='option']

${DayBookDRP}               xpath://kendo-dropdownlist[@formcontrolname='DayBookID']//span[text()='Select']

${TypeofReceipt}          xpath://kendo-dropdownlist[@formcontrolname='VoucherCatID']//span[text()='Select']
${ModeOfReceipt}          xpath://kendo-dropdownlist[@formcontrolname='VoucherModeID']//span[text()='Select']
${SlipNo}        xpath://kendo-textbox[@formcontrolname='SlipNo']//input[@class='k-input-inner']
${ReceiptAMT}        xpath://kendo-numerictextbox[@formcontrolname='NetAmount']//input[@class='k-input-inner']
${Submit}           xpath://span[text()=' Submit']

# Receipt Grid Table data
${Receiptdata}         xpath://table[@role='presentation']//tbody/tr[1]     #Collect All Receipt data
${ReceiptNumber}       //table[@role='presentation']//tbody/tr[1]/td[2]    #ReceiptNumner
${ReferenceNumber}     xpath://table[@role='presentation']//tbody/tr[1]/td[3]
${ReceiptCustometName}     xpath://table[@role='presentation']//tbody/tr[1]/td[4]
${ReceiptCreationDate}     xpath://table[@role='presentation']//tbody/tr[1]/td[5]
${Category}                xpath://table[@role='presentation']//tbody/tr[1]/td[6]
${DebitVoucherNumber}       xpath://table[@role='presentation']//tbody/tr[1]/td[7]
${ReceiptAmount}               xpath://table[@role='presentation']//tbody/tr[1]/td[8]    
${ReceiptShipNumber}        xpath://table[@role='presentation']//tbody/tr[1]/td[9] 
${ReceiptStatus}       xpath://table[@role='presentation']//tbody/tr[1]/td[10]  
${Remark}         xpath://kendo-textbox[@formcontrolname='Remark']//input[@class='k-input-inner']

${OpneReceipt}        xpath://table[@role='presentation']/tbody/tr[1]/td[1]//kendo-button[@role='button'] 
${RemainingDebitAmount}    xpath://div[@id='Debit']

${SettlementAmount}        xpath://table[@role='presentation']/tbody/tr[1]/td[7]



*** Keywords ***
Wait For Loader To Disappear
    Wait Until Element Is Not Visible    xpath://div[@class='loader-div ng-star-inserted']
    
Navigate to Receipt screen 
    Wait Until Element Is Visible    ${Receipt Page}    10s
    Click Link   ${Receipt Page}    
    # Scroll Until Element Is Visible        ${AddButton}   
    Wait Until Element Is Visible    ${ReceiptAddButton}    10s
    Click Element    ${ReceiptAddButton}   
    Sleep    5s        
    
Enter Receipt Details
    [Arguments]    ${CustomerName}    
    # Select Customer Details at Receipt
    Wait Until Element Is Visible    ${ClickCustomerField}    10S  
    Input Text     ${ClickCustomerField}     ${CustomerName}
    Wait Until Element Is Visible    ${CustomerOptionXpath}     10s    
    Sleep    5s      
    Click Element        ${CustomerOptionXpath} 
    # Retry Click Element        ${CustomerOptionXpath}     
    
    # Select Day Book  
    Wait Until Element Is Visible        ${DayBookDRP}     10s
    Click Element        ${DayBookDRP}
    Sleep    3s    
    Wait Until Element Is Visible        //*[text()='Purchase Daybook']     10s
    Click Element    //*[text()='Purchase Daybook']  
    Sleep    5s   
    
Type Of Receipt Advance
    Wait Until Element Is Visible        ${TypeofReceipt}   
    Click Element    ${TypeofReceipt}  
    Wait Until Element Is Visible        //*[text()='Advance']     10s
    Click Element    //*[text()='Advance']
    Sleep    5s
    
Type Of Receipt Normal
    Wait Until Element Is Visible        ${TypeofReceipt}   
    Click Element    ${TypeofReceipt}  
    Sleep    5s    
    Wait Until Element Is Visible        //*[text()='Normal']     10s
    Click Element    //*[text()='Normal']
    # Sleep    5s
     
    
Enter Receipt Bank Details
    [Arguments]    ${EnterSlipNo}
    Wait Until Element Is Visible        ${ModeOfReceipt}    
    Click Element        ${ModeOfReceipt}  
    Wait Until Element Is Visible        //*[text()='Cash']     10s
    Click Element         //*[text()='Cash']  
    Sleep    5s  
 
    Wait Until Element Is Visible        ${SlipNo}  
    Input Text    ${SlipNo}    ${EnterSlipNo} 
    
Enter Receipt Amount
    [Arguments]   ${EnterREAMT} 
    Wait Until Element Is Visible        ${ReceiptAMT}    10s 
    Input Text        ${ReceiptAMT}    ${EnterREAMT}
    
Remark
    [Arguments]    ${EnterRemark} 
    Wait Until Element Is Visible    ${Remark}    5s
    Input Text        ${Remark}    ${EnterRemark} 
    Sleep    5s       

Enter Settlement Amount  
    [Arguments]    ${EnterSettlementAmount}
    
    Execute JavaScript    window.scrollBy(0, 300)
    # # Scroll Element Into View    ${SettlementAmount}
    Sleep    5s    
    # Wait Until Element Is Visible    ${SettlementAmount}    20s
    
    Click Element    ${SettlementAmount}    
    Input Text    ${SettlementAmount}    ${EnterSettlementAmount}
    
    Sleep    5s

Submit Receipt
    Wait Until Element Is Visible        ${Submit}     
    Click Element          ${Submit} 
    

Get Receipt Data
    Wait Until Element Is Visible        ${Receiptdata}     
    ${GetReceiptData}    Get Text    ${Receiptdata} 
    Wait Until Element Is Visible        ${ReceiptNumber} 
    ${GetReceiptNumber}    Get Text       ${ReceiptNumber}
    ${GetReferenceNumber}   Get Text    ${ReferenceNumber}
    ${GetReceiptCustomerName}     Get Text    ${ReceiptCustometName}  
    ${GetReceiptCreationDate}     Get Text    ${ReceiptCreationDate} 
    ${GetCategory}     Get Text    ${Category} 
    ${getDebitVoucherNumber}     Get Text    ${DebitVoucherNumber} 
    Common_Keyword.Scroll Until Element Is Visible    ${ReceiptAmount}    
    ${GetReceiptAmount}     Get Text    ${ReceiptAmount}
    Common_Keyword.Scroll Until Element Is Visible    ${ReceiptShipNumber} 
    ${GetReceiptShipNumber}     Get Text    ${ReceiptShipNumber} 
    Common_Keyword.Scroll Until Element Is Visible    ${ReceiptStatus} 
    ${GetReceiptStatus}     Get Text    ${ReceiptStatus}
             
Open Receipt 
    Wait Until Element Is Visible        ${OpneReceipt}   
    Click Element        ${OpneReceipt}  
    Wait Until Element Is Visible         ${RemainingDebitAmount}     10s   
    ${GetDebitAmount}     Get Text    ${RemainingDebitAmount}
      
    

# Partila Settlement
    # [Arguments]    ${CustomerName}     ${EnterSlipNo}    ${EnterREAMT}    ${EnterRemark}    ${Enter Settlement Amount}
    # Enter Receipt Details    ${CustomerName}
    # Type Of Receipt Normal
    # Enter Receipt Amount    ${EnterSlipNo}     ${EnterREAMT}    ${EnterRemark}
    # Enter Settlement Amount    ${Enter Settlement Amount}
    # Submit Receipt
    # Get Receipt Data
    # Open Receipt
    
    
    

    
    
 
     



     
    
       
        
      
    
     
   
    
    
 
      
        
    
    

        
   

