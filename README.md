# places_api
Places API is an open-source a service that provides places in Zambia for use for both developers and the general public

# 1. Creating a Province.
     Using postman, navigate to http://localhost:8888/api/provinces using post method and add below body:
     {
        "name": "Lusaka Province",
        "longitude": "28.3228° E",
        "latitude": "15.3875° S",
        "population": 1000747
     }
     
     # Response:
     
      {
          "id": 1,
          "name": "Lusaka Province",
          "longitude": "28.3228° E",
          "latitude": "15.3875° S",
          "population": 1000747
       }
       
 # 2. Creating Town
