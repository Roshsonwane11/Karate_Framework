Feature: Test POST API to create an author

  Background: 
    * url 'https://fakerestapi.azurewebsites.net'
    * path '/api/v1/Authors'

  Scenario: Verify new user should be able to create
    And request
      """{
       "id": 101,
       "idBook": 90,
       "firstName": "Selenium",
       "lastName": "Grid"
       }"""
    When method POST
    Then status 200

  Scenario: Verify after creating new user status code should be 200
    And request
      """{
       "id": 101,
       "idBook": 90,
       "firstName": "Selenium",
       "lastName": "Grid"
      }"""
    When method POST
    Then status 200
    * print 'Response Body:', response
    * print 'Response Status:', responseStatus
    * print 'Response Headers:', responseHeaders
    * print 'Response Cookies:', responseCookies
    Then match responseStatus == 200

  Scenario: Successfully create an author with valid data
    And request { "firstName": "John", "lastName": "Doe" }
    When method POST
    Then status 200
    And match response.firstName == 'John'
    And match response.lastName == 'Doe'

  Scenario: Successfully create a new author data
    And request
      """{
        "id": 101,
        "idBook": 90,
        "firstName": "Selenium",
        "lastName": "Grid"
      }"""
    When method POST
    Then status 200
    And match response ==
      """{
        "id": '#notnull',
        "idBook": 90,
        "firstName": "Selenium",
        "lastName": "Grid"
      }"""
    * print responseHeaders
    And match responseHeaders['Content-Type'][0] == 'application/json; charset=utf-8; v=1.0'
@todays
  Scenario: verify Fail to create author with missing firstName
    Given request
      """{
       "id": 0, 
       "idBook": 123, 
       "lastName": "Doe"
      }"""
    When method post
    Then status 400 
    #this test case going to fail because we expecting 400 and getting 200

  Scenario: verify Fail to create author with missing lastName
    Given request
      """{
        "id": 0, 
        "idBook": 123, 
        "firstName": "John"
      }"""
    When method post
    Then status 400  
    #this test case going to fail because we expecting 400 and getting 200

  Scenario: Fail to create author with empty request body
    Given request {}
    When method post
    Then status 400  
    #this test case going to fail because we expecting 400 and getting 200

  Scenario: Delete the created author with ID 100
    # ✅ Step 1: Create an author
    Given request
      """{
      "id":100,
      "idBook": 90,
      "firstName": "Mind",
      "lastName": "Games"
      }"""
    When method POST
    Then status 200
    And match response.id == 100
    # ✅ Step 2: Delete the created author by appending '/100' to the path
    Given path '/api/v1/Authors/100'
    When method DELETE
    Then status 200
