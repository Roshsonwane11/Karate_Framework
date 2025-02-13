Feature: API testing for CoverPhotos

  Background: 
    * url 'https://fakerestapi.azurewebsites.net'
    * path '/api/v1/CoverPhotos'
    * def expectedEntireResponse = read('classpath:responsePayload/getCoverphotosEntirerResponse.json')
    * def expectedResponseSingleObject = read('classpath:responsePayload/getCoverphotosSingleObjectFromResponse.json')
  

@todays
  Scenario: verify get all list of coverphoto when request is valid
    Given method GET
    Then status 200
    * def actualResponse = response
    And match actualResponse == expectedEntireResponse
    * print response

  Scenario: verify when request is valid then status code is 200
    Given method GET
    Then status 200

  Scenario: Verify specific user fields from coverphoto list is getting properly
    Given method GET
    Then status 200
    And match response[0].id == 1
    And match response[0].idBook == 1
    And match response[0].url == "https://placeholdit.imgix.net/~text?txtsize=33&txt=Book 1&w=250&h=350"
    * print response

@todays
  Scenario: Verify valid coverphoto details are getting for valid user id
    Given path '45'
    When method GET
    Then status 200
    * def actualResponse = response
    And match actualResponse == expectedResponseSingleObject
    * print actualResponse

  Scenario: verify get all list of coverphoto when url is invalid
    Given path '/fefefogghkhkjiijejfoi'
    When method GET
    Then status 400
    * print response

  Scenario: Verify behaviour with invalid user id
    Given path '567'
    When method GET
    Then status 404
    And match response.title == "Not Found"

  Scenario: Verify coverphoto details with empty user id
    Given path ''
    When method GET
    And status 200
    Then print response

  Scenario: Verify coverphoto details with valid userid but invalid format
    And path '<1>'
    When method GET
    And status 400
    Then print response

  Scenario: Verify the Data Format of Each coverphots
    When method GET
    Then status 200
    * def coverphotos = response[1]
    * assert 'id' in coverphotos
    * assert 'idBook' in coverphotos
    * assert 'url' in coverphotos

  Scenario: Verify the response lenght of coverphotos
    Given method GET
    Then status 200
    * def dataSize = response.length
    * print 'Number of coverphotos: ', dataSize

  Scenario: Verify Response for Invalid HTTP Method
    When method POST
    Then status 415
     * print response

  Scenario: verify get coverphoto for  specific idBook
  Given path '/books/covers/1'
    When method GET
    And match response[0].id == 1
    And match response[0].idBook == 1
    And match response[0].url == "https://placeholdit.imgix.net/~text?txtsize=33&txt=Book 1&w=250&h=350"
    * print response
   
  	
    Scenario: verify get coverphoto for  invalid idBook
  	Given path '/books/covers/-4778768665'
   	When method GET
    Then status 400
    * print response
    
    Scenario: verify get coverphoto for Non-existing idBook
  	Given path '/books/covers/9877677970666'
   	When method GET
    Then status 400
    * print response
    
    Scenario: verify get coverphoto for empty idBook
  	Given path '/books/covers/ '
   	When method GET
    Then status 400
    * print response
    
   