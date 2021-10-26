class_name MAIL extends HTTPRequest

var http_req = HTTPRequest.new()

func sent_mail(subject: String, message: String):
	var msg = {
	  "Messages":[
		{
		  "From": {
			"Email": "abhinav.kuruvila.joseph@gmail.com",
			"Name": "Abhinav Kuruvila"
		  },
		  "To": [
			{
			  "Email": "abhinav.kuruvila.joseph@gmail.com",
			  "Name": "Abhinav Kuruvila"
			}
		  ],
		  "Subject": subject,
		  "TextPart": message,
		  "CustomID": "GodotMsg"
		}
	  ]}
	var api_key = '6698664339563735098bc88bccae1373'
	var password = '88db5e11da462956bfdcdd40252620ee'
	var auth = str("Basic ", Marshalls.utf8_to_base64(str(api_key,':', password)))
	var a = http_req.request("https://api.mailjet.com/v3.1/send", ["Authorization: " + auth], true, HTTPClient.METHOD_POST, to_json(msg))

