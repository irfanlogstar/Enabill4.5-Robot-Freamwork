*** Settings ***
Library    ExcelLibrary
Library    SeleniumLibrary
Resource    ../Robot_Custom_Library/Common_Keyword.robot
Resource    ../Robot_Custom_Library/Manual Invoice Requests Page.robot

*** Variables ***
${Description2}    Test 
${BLNumber}    9111022
${TABLELOCATOR}        //table[@class='k-grid-table k-table k-table-md']



*** Test Cases ***
Tc001
      [Documentation]    Check if the user can create an invoice for the provided booking.
    ...    - User searches for "Manual Invoice Requests" and navigates to the page.   
         
    TC001K_Login_In_Enabill_4.5 with valid Credentials   
    Serach    Manual Invoice
    Click On Manual Invoice Requests   

TC002
    Filter    ${BLNumber}
TC003
          [Documentation]    Check if the user can create an invoice for the provided booking.
    ...    - User clicks on the add button and searches for the booking number in the "Ref No" field.
    ...    - User selects the pending event for the same booking number.
    ...    - User clicks on the next button.

    Select Event With Booking Number    ${Description2} 
    
TC004
            [Documentation]    To Chexk If User can able to create invouce for the perticuler provided booking
     ...    user click on next button on invoice details screen
   
    Invoice Details Screen
    
TC005
    Retrieve and Log Invoice Number
    


    


