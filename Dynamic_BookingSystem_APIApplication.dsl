workspace "Booking Care"  "This is an example workspace to illustrate the key features of Structurizr, via the DSL, based around a fictional online banking system." {
  model {
    customer = person "Personnal Booking Care" "A customer of the booking care with personal booking accounts." "Customer"

    enterprise "Booking Care" {
      admin = person "Admin Service Booking Care" "Admin servvice within booking" "Booking staff"
      doctor = person "Doctor Service Booking Care" "Doctor service within booking" "Booking staff"

      mainframe = softwareSystem "Main Booking system" "Main booking system" "Existing System"
      email = softwareSystem "Email System" "Manager system" "Existing System"
      atm = softwaresystem "ATM" "Allows customers to withdraw cash." "Existing System"

      bookingCareSystem = softwareSystem "Booking System" "Allow all customer to view information about their booking accounts, and booking" {
        singlePageApplication = container "Single-Page Application" "Provides all of the Booking care functionality to customers via their web browser." "Node JS and React JS" "Web Browser"
        webApplication = container "Web Application" "Delivers the static content and the Booking care single page application." "Node JS Express MVC"
        apiApplication = container "API Application" "Provides Booking care functionality via a JSON/HTTPS API." "Node JS Express MVC"{
          bookingController = component "Booking Controller" "Pre-registration of medical examination order number. Choose medical examination by appointment service. Reduce waiting time at the hospital" "ReactJS"
          emailComponent = component "Email Component" "Provides functional related to booking care." "ReactJs"
        }
        database = container "Database" "Stores user registration information, hashed authentication credentials, access logs, etc." "MySQL" "Database"
      }
    }
    # component (dynamic booking)
    customer -> singlePageApplication
    singlePageApplication -> bookingController
    bookingController -> emailComponent
    emailComponent -> email
    email -> customer
    database -> bookingController "Check for duplicate information. Select * from bookings where time Type = ? date = ?"
    bookingController -> database "Add booking to database"
    email -> doctor "Doctor check information"
    
  }

  views {
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
            customer mainframe email
            webApplication
            singlePageApplication
            database
        }
        autoLayout
    }
    component apiApplication "Components" {
      include *
      animation {
        singlePageApplication email 
        
      }
    }
    
   dynamic apiApplication "Booking" "Pre-registration of medical examination order number. Choose medical examination by appointment service. Reduce waiting time at the hospital" {
    customer -> singlePageApplication "Booking schedule care"
    singlePageApplication -> bookingController "Submits credentials to"
    bookingController -> emailComponent "Validates credentials using"
    emailComponent -> email "Validates credentials using"
    email -> customer "Validates credentials using"
    database -> bookingController "Check for duplicate information. Select * from bookings where time Type = ? date = ?"
    bookingController -> database "Add booking to database"
    email -> doctor "Doctor check information"
    }

    styles {
      element "Person" {
        shape person
        background #08427b
        color #ffffff
        
      }
      element "Customer" {
        
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