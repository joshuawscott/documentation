### To create an API test

api_key=<YOUR_API_KEY>
app_key=<YOUR_APP_KEY>

curl -X POST \
  "https://api.datadoghq.com/api/v1/synthetics/tests?api_key=${api_key}&application_key=${app_key}" \
  -H 'Content-Type: application/json' \
  -d '{
   "config":{
      "assertions":[
         {
            "operator":"is",
            "type":"statusCode",
            "target":403
         },
         {
            "operator":"is",
            "property":"content-type",
            "type":"header",
            "target":"text/html"
         },
         {
            "operator":"lessThan",
            "type":"responseTime",
            "target":2000
         }
      ],
      "request":{
         "method":"GET",
         "url":"https://datadoghq.com",
         "timeout":30,
         "headers":{
            "header1":"value1",
            "header2":"value2"
         },
         "body":"body to send with the request"
      }
   },
   "locations":[
      "aws:us-east-2",
      "aws:eu-central-1",
      "aws:ca-central-1",
      "aws:eu-west-2",
      "aws:ap-northeast-1",
      "aws:us-west-2",
      "aws:ap-southeast-2"
   ],
   "message":"test",
   "name":"Test",
   "options":{
      "tick_every":60,
      "min_failure_duration":0,
      "min_location_failed":1,
      "follow_redirects":true
   },
   "tags":[
      "foo:bar"
   ],
   "type":"api"
}'

### To create a browser test

api_key=<YOUR_API_KEY>
app_key=<YOUR_APP_KEY>

curl  -X POST -H "Content-type: application/json" \
-d '{
   "locations":[
      "aws:ca-central-1",
      "aws:us-east-2"
   ],
   "options":{
      "device_ids":[
         "laptop_large"
      ],
      "tick_every":3600,
      "min_failure_duration":0,
      "min_location_failed":1
   },
   "name":"Test Doc",
   "config":{
      "assertions":[

      ],
      "request":{
         "method":"GET",
         "url":"https://example.com/"
      }
   },
   "message":"Test message",
   "tags":[

   ],
   "type":"browser"
}' \
"https://api.datadoghq.com/api/v1/synthetics/tests?api_key=${api_key}&application_key=${app_key}"