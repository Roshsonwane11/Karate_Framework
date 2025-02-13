Feature: API testing for CoverPhotos

  Background: 
    * url 'https://fakerestapi.azurewebsites.net'
    * path '/api/v1/CoverPhotos'
    * def requestPayload = read('classpath:requestPayload/createCoverphotosRequestvalid.json')
    * def responsePayloadForNewUser = read('classpath:responsePayload/createCoverphotosResponseForNewUser.json')
    
    
    @todays
    Scenario: verify create coverphotos
    Given request requestPayload
    When method post
    Then status 200
      And match response == responsePayloadForNewUser
    * print response
  
   
    Scenario: verify new user should not be able to create coverphotos when missing required filed
    Given request 
   			 """{
   			 
         		 "id": ,
         		 "idBook": ,
          		"url": null
          }"""
    When method post
    Then status 400
    * print response
    And match response.title == 'One or more validation errors occurred.'
    
    
    Scenario: verify new user should be able to create coverphotos when required filed Url is missing 
    Given request 
   			 """{
   			 
         		 "id": 4545,
         		 "idBook": 4545 ,
          		"url": null
          }"""
    When method post
    Then status 200
    * print response
  
    
    Scenario: verify new user should not be able to create coverphotos when required filed id is missing 
    Given request 
   			 """{
   			 
         		 "id": ,
         		 "idBook": 4545 ,
          		"url":  "https://placeholdit.imgix.net/~text?txtsize=33&txt=Book 7879&w=250&h=350"
          }"""
    When method post
    Then status 400
    * print response
    And match response.title == 'One or more validation errors occurred.'
    
  
  	Scenario: verify new user should not be able to create coverphotos when required filed idBook is missing 
    Given request 
   			 """{
   			 
         		 "id":336 ,
         		 "idBook":  ,
          		"url":  "https://placeholdit.imgix.net/~text?txtsize=33&txt=Book 7879&w=250&h=350"
          }"""
    When method post
    Then status 400
    * print response
    And match response.title == 'One or more validation errors occurred.'
    
    
    Scenario: verify Create coverphotos  with invalid url format
    Given request 
   			 """{
   			 
         		 "id": 7879,
         		 "idBook": 7879,
          		"url":1
          }"""
    When method post
    Then status 400
    * print response
     And match response.title == 'One or more validation errors occurred.'
     
     
    Scenario: verify Create coverphotos  with invalid id format
    Given request 
   			 """{
   			 
         		 "id": fj755779dfgt,
         		 "idBook": 7879,
          		"url": "https://plhddoldjkjkjhkjhkh"
          }"""
    When method post
    Then status 400
    * print response
     And match response.title == 'One or more validation errors occurred.'
     
     
    Scenario: verify Create coverphotos  with invalid(String) id format
    Given request 
   			 """{
   			 
         		 "id": "7879",
         		 "idBook": 7879,
          		"url": "https://placehtttddoldjkjkjhkjhkh"
          }"""
    When method post
    Then status 400
    * print response
     And match response.title == 'One or more validation errors occurred.'
     
     
    Scenario: verify Create coverphotos  with invalid idBook format
    Given request 
   			 """{
   			 
         		 "id": 7879,
         		 "idBook": "7879",
          		"url": "https://plgcccacehddoldjkjkjhkjhkh"
          }"""
    When method post
    Then status 400
    * print response
     And match response.title == 'One or more validation errors occurred.'
     
     
    Scenario: verify create coverphotos with duplicate data
    Given request 
   			 """{
   			 
         		 "id": 7879,
         		 "idBook": 7879,
          		"url": "https://placeholdit.imgix.net/~text?txtsize=33&txt=Book 7879&w=250&h=350"
          }"""
    When method post
    Then status 200
    * print response
    
    Scenario: verify  create coverphotos with invalid HTTP method
    Given request 
   			 """{
   			 
         		 "id": 789,
         		 "idBook": 789,
          		"url": "https://placeholdit.imgix.net/~text?txtsize=33&txt=Book 7879&w=250&h=350"
          }"""
    When method GET
    Then status 200
    * print response
     
    
    
  