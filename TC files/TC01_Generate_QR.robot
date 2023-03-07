*** Settings ***
Library  SeleniumLibrary
Library  String
Library  Process
Library  OperatingSystem

*** Variables *** 
${generator_text}

# This is path for saving the file created in this automation scripts
# It is used for saving QR text (txt) and QR image (png)
${download_folder}  C:/Calon D/qerja/2023/Technical Test/INCIT git assignment/incitassignment_2023-03/Downloads


*** Test Cases ***
TC01.01_ClearingExistingFile
    Empty Directory    ${download_folder}

TC01.02_SettingUpBrowser
    Open Browser  http://zxing.appspot.com/generator/  Chrome
    Maximize Browser Window
    Sleep    4
    Title Should Be    QR Code Generator from the ZXing Project

TC01.03_InputRandomText
    ${random_string_1}    Generate Random String    10-15    [LETTERS]
    Input Text    xpath://tr[td/text()="Name"]/td/input   ${random_string_1}

    ${random_string_1}    Generate Random String    10-15    [LETTERS]
    Input Text    xpath://tr[td/text()="Company"]/td/input   ${random_string_1}

    ${random_string_1}    Generate Random String    10-15    [LETTERS]
    Input Text    xpath://tr[td/text()="Title"]/td/input   ${random_string_1}

    ${random_string_1}    Generate Random String    10-15    [NUMBERS]
    Input Text    xpath://tr[td/text()="Phone number"]/td/input   ${random_string_1}

    ${random_string_1}    Generate Random String    10-15    [LOWER]
    Input Text    xpath://tr[td/text()="Email"]/td/input   ${random_string_1}@email.com

    ${random_string_1}    Generate Random String    10-15    [LETTERS][NUMBERS]
    Input Text    xpath://tr[td/text()="Address"]/td/input   ${random_string_1}

    ${random_string_1}    Generate Random String    10-15    [LETTERS][NUMBERS]
    Input Text    xpath://tr[td/text()="Address 2"]/td/input   ${random_string_1}

    ${random_string_1}    Generate Random String    10-15    [LOWER]
    Input Text    xpath://tr[td/text()="Website"]/td/input   ${random_string_1}.net
    
    ${random_string_1}    Generate Random String    10-15    [LETTERS][NUMBERS]
    Input Text    xpath://tr[td/text()="Memo"]/td/input   ${random_string_1}

TC01.04_GenerateButtonClick
    Click Button    xpath://button[text()="Generate →"]
    Sleep    2

TC01.05_Write_QR_Text
    ${generator_text}=    get value    id:rawtextresult
    #log to console        ${generator_text}
    write_var_to_txt      ${generator_text}
    

TC01.05_DownloadClick
    Click Element    xpath://div[@id="downloadText"]/a
    Sleep    2

TC01.06_SaveImage
    Title Should Be    chart (350×350)
    ${image_url}=  Get Element Attribute  xpath://body/img  src
    #log to console  ${image_url}
    Run Process  curl  -o  ${download_folder}/qr_img_1.png  ${image_url}
    close all browsers

TC01.07_ValidatingFile  
    File Should Exist    ${download_folder}/qr_img_1.png
    File Should Exist    ${download_folder}/qr_text.txt
    File Should Not Be Empty    ${download_folder}/qr_img_1.png
    File Should Not Be Empty    ${download_folder}/qr_text.txt

*** Keywords ***
write_var_to_txt
    [Arguments]  ${variable}
    Create File  ${download_folder}/qr_text.txt  ${variable}