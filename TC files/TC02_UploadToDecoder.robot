*** Settings ***
Library  SeleniumLibrary
Library  String
Library  Process
Library  OperatingSystem

*** Variables *** 
${qrImgPath}    C:/Calon D/qerja/2023/Technical Test/INCIT git assignment/incitassignment_2023-03/Downloads/qr_img_1.png
${qrTxtPath}    C:/Calon D/qerja/2023/Technical Test/INCIT git assignment/incitassignment_2023-03/Downloads/qr_text.txt
${loadingmsg}    Now Loading...
${txt_contents}
${decodedText}

# This is path for saving the file created in this automation scripts
# It is used for saving QR text (txt) and QR image (png)
${download_folder}  C:/Calon D/qerja/2023/Technical Test/INCIT git assignment/incitassignment_2023-03/Downloads


*** Test Cases ***
TC02.01_ValidatingFile
    File Should Exist    ${qrImgPath}
    File Should Exist    ${qrTxtPath}
    File Should Not Be Empty    ${qrImgPath}
    File Should Not Be Empty    ${qrTxtPath}

TC02.02_SettingUpBrowser
    Open Browser  https://m28dev.github.io/qrdecoder/  Chrome
    Maximize Browser Window
    Sleep    4
    Title Should Be    QR Decoder demo site

TC02.03_UploadFile
    Choose File    id:qrcode    ${qrImgPath}
    Sleep    3

TC02.04_SubmitButtonClick
    Click Button    xpath://button[text()="Submit"]
    Wait Until Keyword Succeeds    10s    200ms    value should not be    ${loadingmsg}
    Sleep    1

TC02.05_ValidatingBothText
    # Read file from given path, save as variable
    ${txt_contents}=    Get File    ${qrTxtPath}

    # Read textarea decoded, save as variable
    ${decodedText}=    get value    id:decoded

    ${length_contents}=    Get Length    ${txt_contents}
    ${length_decoded}=    Get Length    ${decodedText}
    Log To Console    \n${txt_contents}
    Log To Console    \n${decodedText}

    Log To Console    \n${length_contents}
    Log To Console    \n${length_decoded}

    # Validating both equal
    Should Be Equal As Strings    ${txt_contents}    ${decodedText}

*** Keywords ***
value should not be
    [Arguments]    ${expected}
    ${actual value}=    Get Element Attribute    id:decoded    value
    Should Not Be Equal As Strings    ${actual value}    ${expected}