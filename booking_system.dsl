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
        mobileApp = container "Mobile App" "Provides a limited subset of the Booking care functionality to customers via their mobile device." "React Native" "Mobile App"
        webApplication = container "Web Application" "Delivers the static content and the Booking care single page application." "Node JS Express MVC"
        // apiApplication = container "API Application" "Provides Booking care functionality via a JSON/HTTPS API." "Node JS Express MVC"
        database = container "Database" "Stores user registration information, hashed authentication credentials, access logs, etc." "Oracle Database Schema" "Database"
      }
    }

    customer -> bookingCareSystem "View information, booking schedules and book appointments"
    bookingCareSystem -> mainframe "Gets account information from, and makes bookings using"
    bookingCareSystem -> email "Send email using"
    customer -> mainframe  "View booking schedules and book appointments"
    mainframe -> email "Send email confirm schedule"
    email -> customer "Send email to"
    customer -> atm "Customer confirms appointment and pays advances"
    email -> doctor "The schedule information of registered customers has been confirmed"
    admin -> mainframe "Uses"
    doctor -> mainframe "Uses"
    customer -> mainframe "Uses"
    atm -> mainframe "Uses"

    customer -> webApplication "Visit web" "HTTPS"
    customer -> singlePageApplication "Views account balances, and makes booking using"
    customer -> mobileApp "Views account balances, and makes booking using"
    webApplication -> singlePageApplication "Delivers to the customer's web browser"
    webApplication -> database "Reads from and writes to" "JDBC"
    mobileApp -> database "Reads from and writes to" "JDBC"
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
            customer mainframe email
            webApplication
            singlePageApplication
            mobileApp
            database
        }
        autoLayout
    }

    styles {
      element "Person" {
        color #ffffff
        fontSize 22
        shape Person
      }
      element "Customer" {
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