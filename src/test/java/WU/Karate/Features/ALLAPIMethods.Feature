Feature: HTTP methods API feature

Background:
 * url 'https://restful-booker.herokuapp.com'
 
Scenario: Post call to create booking


Given path '/booking'
And request {
    "firstname" : "Jim",
    "lastname" : "Brown",
    "totalprice" : 111,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2019-01-01"
    },
    "additionalneeds" : "Breakfast"
}
And header Content-Type = 'application/json'
When method POST
Then status 200
And match $data.bookingid = '#present'

#fetch userid
* def userId= $.data.bookingid
*print userId

#put call on created user
Given path '/booking/' + userId
And request {
    "firstname" : "Jihaah",
    "lastname" : "Brown",
    "totalprice" : 112,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2019-01-01"
    },
    "additionalneeds" : "Breakfast"
}
And header Content-Type = 'application/json'
And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
When method put
Then status 200

#Try to check the updated user with get call 
Given path '/booking/' + userId
When method GET
Then status 200

#patch call on created user
Given path '/booking/' + userId
And request {
    "firstname" : "Jihaah",
    "lastname" : "Brown",
    }
And header Content-Type = 'application/json'
And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
When method patch
Then status 200

#Try to check the updated user with get call 
Given path '/booking/' + userId
When method GET
Then status 200

#delete above user
Given path '/booking/' + userId
And header Content-Type = 'application/json'
And header Authorization = 'Basic YWRtaW46cGFzc3dvcmQxMjM='
When method delete
Then status 200
 
#Try to check the deleted user from 
Given path '/booking/' + userId
When method GET
Then status 404