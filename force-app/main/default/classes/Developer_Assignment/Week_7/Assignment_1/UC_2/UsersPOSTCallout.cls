public with sharing class UsersPOSTCallout {
    
    /*
    public with sharing class UsersPostCallout {
    
        public class UsersPOSTWrapper{
            public Integer id;
            public String name;
            public String email;
            public String gender;
            public String status;
        }
    
        public static Integer createUsersPost(List<Id> conIds) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            HttpResponse response = new HttpResponse();
    
            request.setEndpoint('https://gorest.co.in/public/v2/users');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Accept', 'application/json');
            String token = '810ce423e72ea9311f874c44d7e4a16ca24b3ba9689449048f03e522f5120fa7';
            request.setHeader('Authorization', 'Bearer ' + token);
    
            List<Contact> listCon = [SELECT ID, FirstName, LastName, Email, Gender__c, Statuss__c FROM Contact WHERE ID IN :conIds];
            UsersPOSTWrapper wrap = new  UsersPOSTWrapper();
            wrap.name = listCon[0].Lastname;
            wrap.email = listCon[0].Email;
            wrap.gender = listCon[0].Gender__c;
            wrap.status = listCon[0].Statuss__c;
    
            String jsonString = JSON.serialize(wrap);
            request.setBody(jsonString);
            system.debug('Request string: ' + jsonString);
            response = http.send(request);
            system.debug('Response Code: ' + response.getStatusCode());
    
            return response.getStatusCode();
            
        }
    
    }



    public with sharing class CallOutInvocable {
        @InvocableMethod(label='Send Id'
        description = 'METHOD for Callout'
        category = 'Contact')
        public static List<Integer> calloutMethod (List<Id> newIds){
             Integer val = UsersPostCallout.createUsersPost(newIds);
             List<Integer> vals = new List<Integer>();
             vals.add(val);
             return vals;
        }
     }


     */



    // remote site setting 
    @future(callout=true)
    public static void createUsersPOST(List<Id> conIds){
        //UsersPOSTCallout.createUsersPOST('003Do000002UgwoIAC');
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        //Request
        request.setEndpoint('https://gorest.co.in/public/v2/users');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        String token = '60a2079f89a129654e042821ce89fc1cd47fbcedd8bb5087ff4436ce94e04986';
        request.setHeader('Authorization', 'Bearer '+token);

        // Example - Sample Data
        // UsersPOSTWrapper wrapper1 = new UsersPOSTWrapper();
        // wrapper1.id = 3344; //Just hardcoding eg, some code to indicate it is from salesforce environment
        // wrapper1.name = 'Ahmet';
        // wrapper1.status = 'active';
        // wrapper1.email = 'testahmet@gmail.com';
        // wrapper1.gender = 'Male'; 
        // String jsonString = JSON.serialize(wrapper1);
        // system.debug('request JSON: '+jsonString);
        /*
        Debug Logs : {
                        "status": "active",
                        "name":   "Ahmet",
                        "id":    3344,
                        "gender": "Male",
                        "email": testahmet@gmail.com"
                    }
        */
        
        /*Retrieve the Data from the Contact Object to Pass it to request*/
        List<Contact> conReq = [Select Id,Status__c,LastName,Gender__c,Email from Contact where ID IN :conIds];
            UsersPOSTWrapper wrapper2 = new UsersPOSTWrapper();
            wrapper2.id = 3344; //Just hardcoding eg, some code to indicate it is from salesforce environment
            wrapper2.name = 'Ahmet'; //conReq[0].LastName;
            wrapper2.status = 'active'; //conReq[0].Status__c;
            wrapper2.email = 'testahmet@gmail.com'; //conReq[0].Email;
            wrapper2.gender =  'male'; //conReq[0].Gender__c;

            String jsonString = System.JSON.serialize(wrapper2);

            request.setBody(jsonString);

            response = http.send(request);
            system.debug('Response Code : '+response.getStatusCode());


        }

        
    

    // public class UsersPOSTWrapper{
    //     public integer id;
    //     public string name;
    //     public string status;
    //     public string email;
    //     public string gender;
    // }

    // public class UsersPOSTWrapper2{
    //     public integer id;
    //     public string name;
    //     public string status;
    //     public string email;
    //     public string gender;
    // }




    /*

    public with sharing class GoRestCallout {

        private static String URL = Endpoint__mdt.getInstance('GET_USERS').URL__c;
        private static final String HTTP_POST = 'POST';
    
        public static Integer postUser(String userData){
    
            //prepare request
            HttpRequest request = new HttpRequest();
            request.setMethod(HTTP_POST);
            request.setEndpoint(URL);
            request.setHeader('Accept', 'application/json');
            request.setHeader('Content-Type', 'application/json');
            request.setBody(userData);
            request.setHeader('Authorization', 'Bearer *****YOUR-API-CODE************');
    
            //send the request over the internet
            Http http = new Http();
            HttpResponse response = http.send(request);
    
            //process the response
            if(response.getStatusCode() == 201){
                System.debug(response.getStatus());
                System.debug(response.getBody());
                return response.getStatusCode();
            }else{
                System.debug(response.getStatusCode());
                System.debug(response.getBody());
                return null;
            }
    
        }
    
        @InvocableMethod(label='Get Flow Data' description='Get data from flow' category='Contact')
        public static List<Integer> flowData(List<Id> idList){
            List<Integer> myList = new List<Integer>();
            Contact con = [SELECT Name, Email, Status__c, Gender__c FROM Contact WHERE Id IN :idList LIMIT 1];
    
            UsersPOSTWrapper user = new UsersPOSTWrapper();
            user.name = con.Name;
            user.email = con.Email;
            user.gender = con.Gender__c;
            user.status = con.Status__c;
    
            String userInfo = JSON.serialize(user);
            myList.add(postUser(userInfo));
            return myList;
        }
    
        public class UsersPOSTWrapper{
            public string name;
            public string status;
            public string email;
            public string gender;
        }
    }

    */
}