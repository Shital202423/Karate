Feature: Get API feature

Scenario: get all bookings
Given url 'https://restful-booker.herokuapp.com/booking' 
When method GET
Then status 200
