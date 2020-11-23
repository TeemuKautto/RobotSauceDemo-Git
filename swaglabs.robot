*** Settings ***
Library           SeleniumLibrary   run_on_failure=Nothing

*** Variables ***
${URL}	           https://www.saucedemo.com/
${BROWSER}        Chrome
${DRIVER}         rg-env/WebDriverManager/chrome/87.0.4280.20/chromedriver_linux64/chromedriver
${DELAY}          0

*** Test Cases ***
Test Checkout
    Prepare Browser
    Login	standard_user	secret_sauce
    Add Item To Cart	Jacket
    
    Wait Until Page Contains Element	xpath=//*[@id="shopping_cart_container"]/a/svg/path
    Click Button	xpath=//*[@id="shopping_cart_container"]/a/svg/path
    
    Click Button	CHECKOUT
    
    #Close Browser
    
*** Keywords ***
Prepare Browser
    Open Browser    ${URL}    ${BROWSER}   executable_path=${DRIVER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    
Login
	[Arguments]	${user}	${password}
	Input Text	id=user-name	${user}
	Input Text	id=password	${password}
	Click Button	LOGIN

Add Item To Cart
	[Arguments]	${item}
	Click Button	xpath=//div[@class='inventory_item' and contains(.,'${item}')]//button[contains(.,'ADD')]