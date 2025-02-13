Feature: Get all Users List

  Background: 
    * url 'https://fakerestapi.azurewebsites.net'
    * path '/api/v1/Users/'
    * def expectedResponse = read('classpath:responsePayload/userEntireResponse.json')
    * def expectedResponseSingleObject = read('classpath:responsePayload/userSingleObjectFromResponse.json')
    

  Scenario: Verify all list of users is getting if request is valid
    Given method GET
    Then status 200
    * def actualResponse = response
    And match actualResponse == expectedResponse
    * print actualResponse

  Scenario: Verify specific user fields from users list is getting properly
    Given method GET
    Then status 200
    And match response[0].id == 1
    And match response[0].userName == "User 1"
    And match response[0].password == "Password1"
    * print response

  Scenario: Verify valid user details are getting for valid user id
    Given path '1'
    When method GET
    Then status 200
    * def actualresponse = response
    And match actualresponse == expectedResponseSingleObject
    * print actualresponse

  Scenario: Verify behaviour with invalid user id
    Given path '1000'
    When method GET
    Then status 404
    And match response.title == "Not Found"

  Scenario: Verify user details with empty user id
    Given path ''
    When method GET
    Then status 200
    Then print response

  Scenario: Verify user details with valid userid but invalid format
    Given path '<1>'
    When method GET
    Then status 400
    Then print response
