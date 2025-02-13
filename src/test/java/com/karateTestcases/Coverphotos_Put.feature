
Feature: API testing for CoverPhotos

  Background: 
    * url 'https://fakerestapi.azurewebsites.net'
    * path '/api/v1/CoverPhotos'
    * def requestPayload = read('classpath:requestPayload/updateCoverphotosRequest.json')
    
    Scenario: verify update coverphotos with valid data
    Given path '/18'
    And request 
   			 """{
   			 
         		 "id": 18,
         		 "idBook": 7879,
          		"url": "https://placeholdjkjkjhkjhkh"
          }"""
    When method PUT
    Then status 200
    * print response
    And match response.id == 18
    And match response.idBook == 7879
    And match response.url == "https://placeholdjkjkjhkjhkh"
    
    @todays
    Scenario: verify response code when update coverphotos with valid data
    Given path '/144'
    And request requestPayload
    When method PUT
    Then status 200
    * print response
    
    Scenario: verify new user should not be able to update coverphotos when missing required filed
    Given path '/184'
    And request 
   			 """{
   			 
         		 "id": ,
         		 "idBook": ,
          		"url": "null"
          }"""
    When method PUT
    Then status 400
    * print response
    And match response.title == 'One or more validation errors occurred.'
    
    Scenario:  verify new user should not be able to update coverphotos when missing  id required filed
    Given path '/14'
    And request 
   			 """{
   			 
         		 "id": ,
         		 "idBook": 7879,
          		"url": "https://placeholdjkjkjhkjhkh"
          }"""
    When method PUT
    Then status 400
    * print response
     And match response.title == 'One or more validation errors occurred.'
     
    Scenario:  verify new user should not be able to update coverphotos when missing idBook required filed
    Given path '/15'
    And request 
   			 """{
   			 
         		 "id":15 ,
         		 "idBook": ,
          		"url": "https://placehddoldjkjkjhkjhkh"
          }"""
    When method PUT
    Then status 400
    * print response
     And match response.title == 'One or more validation errors occurred.'
     

    Scenario:  verify new user should be able to update coverphotos when missing Url required filed
    Given path '/15'
    And request 
   			 """{
   			 
         		 "id":15 ,
         		 "idBook": 56778,
          		"url": "null"
          }"""
    When method PUT
    Then status 200
    * print response
    
    Scenario: verify update coverphotos with invalid id format
     Given path '/fj755779dfgt'
    	And request 
   			 """{
   			 
         		 "id": fj755779dfgt,
         		 "idBook": 7879,
         		 "url": "https://placehddoldjkjkjhkjhkh"
          		
          }"""
    When method PUT
    Then status 400
    * print response
     And match response.title == 'One or more validation errors occurred.'
     
     
    Scenario: verify update coverphotos  with invalid(String) id format
      Given path '/"7879"'
    	And request 
   			 """{
   			 
         		 "id": "7879",
         		 "idBook": 7879,
          		"url": "https://placehddoldjkjkjhkjhkh"
          }"""
    When method PUT
    Then status 400
    * print response
     And match response.title == 'One or more validation errors occurred.'
     
     
    Scenario: verify update coverphotos  with invalid idBook format
    Given path '/78769'
    And request 
   			 """{
   			 
         		 "id": 78769,
         		 "idBook": "78769",
          		"url": "https://placehddoldjkjkjhkjhkh"
          }"""
    When method PUT
    Then status 200
    * print response
   
    Scenario: verify update coverphotos with duplicate data
    Given path '/7879'
    And request 
   			 """{
   			 
         		 "id": 7879,
         		 "idBook": 7879,
          		"url": "https://placeholdit.imgix.net/~text?txtsize=33&txt=Book 7879&w=250&h=350"
          }"""
    When method PUT
    Then status 200
    * print response
    
    Scenario: verify update coverphotos with invalid HTTP method 
    Given path '/789'
    And request 
   			 """{
   			 
         		 "id": 789,
         		 "idBook": 789,
          		"url": "https://placeholdit.imgix.net/~text?txtsize=33&txt=Book 7879&w=250&h=350"
          }"""
    When method PUT
    Then status 200
    * print response
     
    
    
  
    