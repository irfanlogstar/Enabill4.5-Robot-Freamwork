*** Settings ***
Library    ExcelLibrary
Library    SeleniumLibrary
Resource    ../Robot_Custom_Library/Common_Keyword.robot
Resource    ../Robot_Custom_Library/Manual Invoice Requests Page.robot
Resource    ../Robot_Custom_Library/Receipt Page.robot

*** Variables ***
${Description2}    Test 
${BLNumber}        62332853BN08222024023EMP	
${CustomerName}    MAERSK INDIA PVT LTD
${EnterSlipNo}        1234  
${EnterRemark}    Test



*** Test Cases ***
Tc001-Login and Navigate to Manual Invoice Requests
     [Documentation]    Check if the user can log in to the Enabill system with valid credentials
    ...                and navigate to the "Manual Invoice Requests" page
         
    TC001K_Login_In_Enabill_4.5 with valid Credentials   
    Serach    Manual Invoice
    Click On Manual Invoice Requests 
    Sleep    5s      


TC002 - Filter Invoice by BL Number
    [Documentation]    Check if the user can filter invoices by entering the BL number.
    Filter    ${BLNumber}

TC003 - Add New Event/Trigger for the Booking
     [Documentation]    Check if the user can create an invoice for the provided booking.
    ...                - User clicks on the add button and searches for the booking number in the "Ref No" field.
    ...                - User selects the pending event for the same booking number.
    ...                - User clicks on the next button..

    Select Event With Booking Number    ${Description2} 
    
TC004 - Verify Invoice Details Screen
   [Documentation]    Check if the system can display all charges for the booking/cycle.
   
   ${ActualInvAmt}     Invoice Details Screen
   Set Global Variable    ${InvoiceAMount}    ${${ActualInvAmt}}
    
TC005 - Retrieve Invoice Number and Request ID
     [Documentation]    Check if the user can successfully create an invoice and retrieve
    ...                the invoice number and request ID from which the invoice is generated
       Retrieve and Log Invoice Number
        
TC006 - Logout and Close Browser
     [Documentation]    After successfully creating an invoice, the user should be able to log out
    ...                and close the browser.
    Logout
    Close Browser
    
TC007 - Re-login to Enabill System
    [Documentation]    Check if the user can log in again to the Enabill system after logging out.
    TC001K_Login_In_Enabill_4.5 with valid Credentials
        
TC008 - Full Settlement for Created Invoice
    [Documentation]    Check if the user can perform full settlement for the created invoice, from receipt screen
    Serach    Receipt
    Navigate to Receipt screen    
    Enter Receipt Details    ${CustomerName}
    Type Of Receipt Normal
    Enter Receipt Bank Details    ${EnterSlipNo}
    Enter Receipt Amount     ${InvoiceAMount}
    Remark    ${EnterRemark}
    Submit Receipt
    Open Receipt
    Get Receipt Data
    Close All Browsers
    

    

    
   
    


    


