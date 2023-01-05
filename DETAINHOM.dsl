workspace {

    model {
       admin = person "Admin" "A manager who manages the project's operations." "Manager"
       customer = person "Customer" "A person users website of booking schedule  medical examine ." 
       doctor = person "Doctor" "A person with a medical degree whose job is to treat." 
       emailSystem = softwareSystem "E-mail System" "The internet Microsoft Exchange e-mail system.""Existing System"
        System = softwareSystem "Manager Page System "  {
        webManagerApplication = container "Web Manager Application" "Manager all the static content and the Internet booking to schedules to single page application." "NodeJS"{
            admin -> webManagerApplication "Mangaer all content"
            doctor -> webManagerApplication "Manager schedules"
        }
        singlePageApp = container "Single-Page Application" "Provides all of Booking to Schedule medical examine functionality to customer via their web browser." "ReactJS" {
            admin -> singlePageApp "Manager all content"
            doctor -> singlePageApp "Manager schedules"
            webManagerApplication -> singlePageApp "Delivers"
        }
        
        apiApp = container "API Application" "Provides Booking to Schedule medical examine functionality via a JSON/HTTP API ." "NodeJS express" {
            singlePageApp -> apiApp "Uses [JSON/HTTPS]"
           
        }
        data = container "Database" "Store user registration information, hashed authentication credentials access logs,..." "MySQL" "Database"{
            apiApp -> data "Protocol/SSL"
        }
       }
       
       softwareSystem = softwareSystem "SYSTEM BOOKING TO SCHEDULES INTERNET" {
        webApplication = container "Web Application" "Delivers the static content and the Internet booking to schedules single page application." "ReactJS" {
            
            introductionController = component "Introduction Controller" "Allows customer to view referra infomation"
            signIn = component "SignIn Control" "SignIn when had account"
            signUp = component "SignUp Control" "Customer signup when not has account"
            resetPassword = component "Reset Password" "Customer can reset their password "
            
            security = component "Security Control" " account security and allow up to 3 incorrect entries"
            infomationDoctor = component "Information Doctor" "Customer can view information doctor"
            BookingSchedules = component "Booking Schedules"  "View schedules and booking schedules"
            RatingComment = component "Rate and Comment" "Customer can rate and comment "
            CentralControl = component "Central Controller" "  Connected to services"
            
        }
        singlePageApplication = container "Single-Page Application" "Provides all of Booking to Schedule medical examine functionality to customer via their web browser." "ReactJS" {
            customer -> singlePageApplication "Uses"
            webApplication -> singlePageApplication "Delivers"
        }
        
        apiApplication = container "API Application" "Provides Booking to Schedule medical examine functionality via a JSON/HTTP API ." "NodeJS express" {
            singlePageApplication -> apiApplication "Uses [JSON/HTTPS]"
            
            signinController = component "Sign In Controller" "Allows users to sign in ."
            signupController = component "Sign Up Controller" "Allows users to sign up .
            resetPasswordController = component "Reset Password Controller" "Allows users to reset their passwords with a single use URL." 
            securityComponent = component "Security Component" "Provides functionality related to signing in, changing passwords, etc." 
            RateComment = component " Rate and Comment" "Allows users to rate and comment"
            bookingSchedule = component "Booking Schedules" "Allows users to booking Schedule"
            InformationDoctor = component "Information Doctor" "Display information doctor "
            Email = component "Email" "Sends email confirm"
           
        }
        
        database = container "Database" "Store user registration information, hashed authentication credentials access logs,..." "MySQL" "Database"{
            apiApplication -> database "Protocol/SSL"
        }

       }
       admin -> webManagerApplication "Mangaer all content"
        doctor -> webManagerApplication "Manager schedules"
        customer -> webApplication "Uses"
       admin -> webApplication "Uses"
       doctor -> webApplication "Uses"
       doctor -> singlePageApp "Uses"
       apiApp -> emailSystem "Sends e-mail "
       apiApplication -> emailSystem "Sends e-mail using "
       emailSystem -> admin "Sends e-mail to"
       emailSystem -> doctor "Sends e-mail to"
       emailSystem -> customer "Sends e-mail to"
     
        customer -> introductionController "visits web"
        introductionController -> signIn "signIn"
        introductionController -> signUp "signUp"
        introductionController -> infomationDoctor 
        BookingSchedules -> RatingComment
        signIn -> security "Uses"
        signUp -> security "Uses"
        signIn -> resetPassword
        signIn -> BookingSchedules
        resetPassword -> security "Uses"
        RatingComment -> CentralControl 
        infomationDoctor -> CentralControl 
        security -> CentralControl 
        CentralControl -> singlePageApplication
        
        singlePageApplication -> signinController "Make api call to [JSON/HTTPS]"
        singlePageApplication -> signupController "Make api call to [JSON/HTTPS]"
        singlePageApplication -> resetPasswordController "Make api call to [JSON/HTTPS]"
        singlePageApplication -> RateComment "Make api call to [JSON/HTTPS]"
        RateComment -> database "Reads from and writes to" "JDBC"
        singlePageApplication -> bookingSchedule "Make api call to [JSON/HTTPS]"
        bookingSchedule -> database "Reads from and writes to" "JDBC"
        singlePageApplication ->  InformationDoctor "Make api call to [JSON/HTTPS]"
        InformationDoctor -> database "Reads from and writes to" "JDBC"
        signinController -> securityComponent "Uses"
        signupController -> securityComponent "Uses"
        resetPasswordController -> securityComponent "Uses"
        resetPasswordController -> email "Uses"
        email -> emailSystem "send email to uses"
        securityComponent -> database
    }
    views {
        systemcontext softwareSystem {
            include *
            autoLayout 
        }

        container softwareSystem {            
        include *
            autoLayout lr

        }
        container System {
            include *
            autoLayout lr
        }
        component webApplication {
            include *
            autoLayout 

        }
        component apiApplication {
            include *
            autoLayout 

        }
        styles {
            element "Person" {
                shape Person
                background #08427b
                color #ffffff
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Container" {
                background #1168bd
                color #ffffff
            }
            element "Component" {
                background #1168bd
                color #ffffff
            }
            element "Existing System"{
                 background #999999
                color #ffffff
            }
            element "Database"{
                shape Cylinder
            }
            
          
        }
    }
}