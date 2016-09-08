# ING

Example iOS Swift Application to work with the ING API wrapper I created.

# The API

I made this app to work with my homemade, cool [ING PHP API Wrapper](https://github.com/tomgekeerd/ING-PHP-API) so it can fetch info from ING's API. I'll post this API soon here as well as I understand you don't want to send your username + password to my server and you can see how it works (trust me, it isn't that much of a breakthrough).

# The App

The app is a simple Swift Application I made in about two hours to work with that API, currently using Swift 2.0 & Alamofire to fetch the data

# Examples

Using this wrapper is pretty straightforward, you create your instance and assign your username + password onto this via the init and call a method of your choice. Data will be given in NSDictionary


    let ing = INGAPI(username: "my_username", andPassword: "my_password")
    
    ing.getDebitDetails { (response, error) in
      print(response)
    }

