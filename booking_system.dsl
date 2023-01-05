workspace "Booking Care"  "This is an example workspace to illustrate the key features of Structurizr, via the DSL, based around a fictional online banking system." {
  model {
    customer = person "Personnal Booking Care" "A customer of the booking care with personal booking accounts." "User"
    admin = person "Admin Booking Care" "Admin within booking" "User"
    doctor = person "Doctor Booking Care" "Doctor within booking" "User"

    enterprise "Booking Care" {

      email = softwareSystem "Email System" "Manager system" "Existing System"
      paymentMethod = softwaresystem "Payment Method" "Allows customers to withdraw cash." "Existing System"

      bookingCareSystem = softwareSystem "Booking System" "Allow all customer to view information about their booking accounts, and booking" {
        singlePageApplication = container "Single-Page Application" "Provides all of the Booking care functionality to customers via their web browser." "Node JS and React JS" "Web Browser" {
          articleComponent = component "Article Component" "Viewing health related news, promotions..."
          bookingCareSearchComponent = component "Booking Care Search Component" "Allows users search with mutiple type (Clinic, Doctor, Specialty) at a time"
          doctorSearchComponent = component "Doctor Search Component" "Allows user search doctor who fits the requirement of user"  
          clinicSearchComponent = component "Clinic Search Component" "Allows user search clinic that fits the requirement of user" 
          specialtySearchComponent = component "Specialty Search Component" "Allows user search specialty that fits the requirement of user"
          outStandingDoctorComponent = component "Doctor Outstanding Component" "Showing top 10 outstanding doctor in last month"
          outStandingClinicComponent = component "Clinic Outstanding Component" "Showing top 10 outstanding clinic in last month"
          outStandingSpecialtyComponent = component "Specialty Outstanding Component" "Showing top 10 outstanding specialty in last month"
          bookingDoctorComponent = component "Booking Doctor Component" "Allows user booking an appointment with doctor by available time period"
          bookingClinicComponent = component "Booking Clinic Component" "Allows user booking an appointment by examination price in the available time period"
          doctorViewComponent = component "Doctor View Component" "Showing doctor's information, examination price, doctor's clinic"
          clinicViewComponent = component "Clinic View Component" "Showing clinic's information, list examination price"
          homepageComponent = component "Home Page Component" "Showing booking care search, categories, outstanding components"
          specialtyPageComponent = component "Specialty Page Component" "Showing list of specialty"
          clinicPageComponent = component "Clinic Page Component" "Showing list of clinic"
          doctorPageComponent = component "Doctor Page Component" "Showing list of doctor"
        }
        webApplication = container "Web Application" "Delivers the static content and the Booking care single page application." "Node JS Express MVC"
        apiApplication = container "API Application" "Provides Booking care functionality via a JSON/HTTPS API." "Node JS Express MVC"{
          signinController = component "Sign In Controller" "Allows users to sign in to the Booking Schedule System." "ReactJS Controller"
          securityComponent = component "Security Component" "Provides functionality related to signing in, changing passwords, etc." "ReactJS"
          resetPasswordController = component "Reset Password Controller" "Allows users to reset their passwords with a single use URL." "ReactJS Controller"
          emailComponents = component "E-mail Component" "Sends e-mails to users." "ReactJS"
          addInfoDoctor = component "Add Doctor's Infomation" "The doctor can add doctor's information" "ReactJS Controller"
          updateInfoDoctor = component "Update Doctor's Infomation" "The doctor can update doctor's information" "ReactJS Controller"

          addAccount = component "Add Account" "The manager can add account doctor"
          deleteAccount = component "Delete Account" "The manager can delete account doctor"
          updateAccount = component "Update Account" "The manager can update account doctor"
        }
        database = container "Database" "Stores user registration information, hashed authentication credentials, access logs, etc." "MySQL" "Database"{
          user = component "User using booking care" "Allow save information all user in database"
          booking = component "List of customer's booking schedule" "Allows to save all booking information of customers using the system"
          clinic = component "List of clinics" "allows to save clinic information"
          history = component "List of schedule histories" "Allow to save all history schedule information of customer and doctor"
          schedule = component "List of schedule of all customer and doctor" "Allow to save all schedule of all customer and doctor"
          specialty = component "List of specialty of doctor" "allows to save all information about the professional profession of the doctor"
          allCode = component "List of code" "Allows to save all promotional codes for loyal customers"
          doctorClinic = component "List of relationship" "The link between doctors and clinics"
          markdown = component "List of markdown" "Save information about discount services"
        }
      }
    }

    customer -> bookingCareSystem "View information, booking schedules and book appointments"
    bookingCareSystem -> email "Send email using"
    email -> customer "Send email to"
    customer -> paymentMethod "Customer confirms appointment and pays advances"
    email -> doctor "The schedule information of registered customers has been confirmed"

    customer -> webApplication "Visit web" "HTTPS"
    customer -> singlePageApplication "Views account balances, and makes booking using"
    webApplication -> singlePageApplication "Delivers to the customer's web browser"
    webApplication -> database "Reads from and writes to" "JDBC"

    #relationship component
    singlePageApplication -> resetPasswordController
    singlePageApplication -> securityComponent

    doctor -> singlePageApplication
    admin -> singlePageApplication
    singlePageApplication -> addInfoDoctor
    singlePageApplication -> updateInfoDoctor
    singlePageApplication -> addAccount
    singlePageApplication -> updateAccount
    singlePageApplication -> deleteAccount
    singlePageApplication -> emailComponents
    singlePageApplication -> signinController

    homepageComponent -> outStandingDoctorComponent "Uses"
    homepageComponent -> outStandingClinicComponent "Uses"
    homepageComponent -> outStandingSpecialtyComponent "Uses"
    homepageComponent -> bookingCareSearchComponent "Uses"
    homepageComponent -> articleComponent "Uses"
    doctorPageComponent -> doctorSearchComponent "Uses"
    clinicPageComponent -> clinicSearchComponent "Uses"
    specialtyPageComponent -> specialtySearchComponent "Uses"
    doctorViewComponent -> bookingDoctorComponent "Uses"
    clinicViewComponent -> bookingClinicComponent "Uses"

    bookingCareSearchComponent -> apiApplication "Request search top 5 doctors, clinics, specialty those match the query"
    doctorSearchComponent -> apiApplication "Request search doctors those match the query"
    clinicSearchComponent -> apiApplication "Request search clinics those match the query"
    specialtySearchComponent -> apiApplication "Request search specialty those match the query"
    doctorViewComponent -> apiApplication "Get doctor's information"
    clinicViewComponent -> apiApplication "Get clinic's information"
    doctorPageComponent -> apiApplication "Get list of doctor order by outstanding point"
    clinicPageComponent -> apiApplication "Get list of clinic order by outstanding point"
    specialtyPageComponent -> apiApplication "Get list of specialty"
    outStandingDoctorComponent -> apiApplication "Get top 10 doctor order by outstanding point"
    outStandingClinicComponent -> apiApplication "Get top 10 clinic order by outstanding point"
    outStandingSpecialtyComponent -> apiApplication "Get top 10 specialty order by outstanding point"
    articleComponent -> apiApplication "Get article's information"
    bookingDoctorComponent -> apiApplication "Request booking an appointment with doctor"
    bookingClinicComponent -> apiApplication "Request booking an appointment in clinic"

    signinController -> securityComponent
    resetPasswordController -> securityComponent
    resetPasswordController -> emailComponents
    emailComponents -> email
    addInfoDoctor -> database "Add doctor's information to database"
    database -> updateInfoDoctor "Get doctor's information to client manage"
    updateInfoDoctor -> database "After update, information be saved to database"
    addAccount -> database "Add account to database"
    database -> updateAccount "Doctor's information return to client"
    updateAccount -> database "After update, information be saved to database"
    securityComponent -> database
    deleteAccount -> database


//
    singlePageApplication -> user
    singlePageApplication -> booking
    singlePageApplication -> clinic
    singlePageApplication -> schedule
    singlePageApplication -> specialty
    singlePageApplication -> allCode

    signinController -> user
    resetPasswordController -> user
    addInfoDoctor -> user
    addAccount -> user
    deleteAccount -> user
    updateAccount -> user

    user -> history
    user -> schedule
    user -> booking
    user -> doctorClinic
    clinic -> doctorClinic
    user -> markdown
    clinic -> markdown
    specialty -> markdown
  }

  views {
    systemlandscape "SystemLandscape" {
      include *
      autoLayout
    }

    systemcontext bookingCareSystem "SystemContext" {
      include *
      animation {
        bookingCareSystem
      }
      autoLayout
    }

    container bookingCareSystem "Containers" {
        include *
        animation {
            customer
            webApplication
            singlePageApplication
            database
        }
        autoLayout
    }
    component apiApplication "DoctorAndAdmin" {
      include *
      animation {
        singlePageApplication email database
        signinController resetPasswordController
        securityComponent email
        addInfoDoctor addAccount
        deleteAccount updateAccount
      }
    }
    component singlePageApplication "Single-Page_Application_Components" {
      include *
      animation {
        articleComponent bookingCareSearchComponent doctorSearchComponent clinicSearchComponent
        specialtySearchComponent outStandingDoctorComponent outStandingClinicComponent outStandingSpecialtyComponent
        bookingDoctorComponent bookingClinicComponent doctorViewComponent clinicViewComponent homepageComponent
        specialtyPageComponent clinicPageComponent doctorPageComponent
      }
    }
    component apiApplication "Customer" {

    }
    component database "DatabaseComponent" {
      include *
      animation {
        singlePageApplication signinController resetPasswordController addInfoDoctor addAccount deleteAccount updateAccount
        user booking clinic history schedule specialty allCode doctorClinic markdown
      }
      autoLayout
    }
    dynamic apiApplication "SignIn" "Summarises how the sign in feature works in the single-page application." {
      doctor -> singlePageApplication "Uses"
      customer -> singlePageApplication "Uses"
      singlePageApplication -> signinController "Submits credentials to"
      signinController -> singlePageApplication "Sends back an authentication token to"
      singlePageApplication -> resetPasswordController "Request new password"
      signinController -> securityComponent "Validates credentials using"
      resetPasswordController -> securityComponent "Validates infomation for request"
      securityComponent -> database "select * from users where username = ?"
      database -> securityComponent "Returns user data to"
      securityComponent -> signinController "Returns true if the hashed password matches"
      // securityComponent -> emailComponents "send a request for information verification"
      emailComponents -> resetPasswordController "Reset Password"
      signinController -> singlePageApplication "Sends back an authentication token to"
      autoLayout
    }
    dynamic apiApplication "ManagementAccount" "Management account"{
      admin -> singlePageApplication "Uses"
      singlePageApplication -> addAccount "Add account"
      singlePageApplication -> updateAccount "Update account"
      singlePageApplication -> deleteAccount "Delete account"
      database -> addAccount "Get information from database to check"
      addAccount -> database "Request new account"
      database -> updateAccount "Get information from database to show"
      updateAccount -> database "Request update account"
      deleteAccount -> database "Request delete account"
     
      autoLayout
    }

    dynamic apiApplication "DoctorsInformation" "Managerment doctor's information"{
      doctor -> singlePageApplication "Uses"
      singlePageApplication -> addInfoDoctor "Add information doctor"
      singlePageApplication -> updateInfoDoctor "Update information doctor"

      addInfoDoctor -> database "Add information doctor"
      database -> updateInfoDoctor "Get information from database to show"
      updateInfoDoctor -> database "Request update doctor's information"

      autoLayout
    }


    styles {
      element "Person" {
        color #ffffff
        fontSize 22
        shape Person
      }
      element "User" {
        background #08427b
      }
      element "Booking staff" {
        background #999999
      }
      element "Software System" {
        background #1168bd
        color #ffffff
      }
      element "Existing System" {
        background #999999
        color #ffffff
      }
      element "Container" {
        background #438dd5
        color #ffffff
      }
      element "Database" {
        shape Cylinder
      }
    }
  }
}