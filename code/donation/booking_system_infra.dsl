workspace "Booking Care System" "This is a booking care system for a fictional healthcare organization." {
  model {
    users = person "Users" "Patients or caretakers who use the booking care system to book appointments."
    doctors = person "Doctors" "Doctors who use the booking care system to manage their schedules and view patient records."
    admin = person "Admin" "Administrative staff who use the booking care system to manage the system and patient records."

    enterprise "Healthcare Organization" {
        bookingCareSystem = softwareSystem "Booking Care System" "A booking care system for a healthcare organization." {
            apiApplication = container "API Application" "Provides booking care functionality via a JSON/HTTPS API." "Express.js and Node.js" {
                appointmentController = component "Appointment Controller" "Handles requests related to booking and canceling appointments."
                patientController = component "Patient Controller" "Handles requests related to managing patient records."
                authenticationComponent = component "Authentication Component" "Handles user authentication and authorization."
                paymentController = component "Payment Controller" "Handles requests related to processing payments for appointments."
                notificationController = component "Notification Controller" "Sends notifications to users and doctors about appointments and other important events."
            }
            webOfficeApplication = container "Web Office Application" "Provides booking care functionality to office staff via a web browser." "Next.js and JavaScript" {
                schedulingComponent = component "Scheduling Component" "Handles requests related to managing doctors' schedules."
                notificationComponent = component "Notification Component" "Sends notifications to users and doctors about appointments and other important events."
                ownerPatientRecordComponent = component "Owner Patient Record Component" "Handles requests related to viewing and updating owner patient record."
                ownerBillingComponent = component "Owner Billing Component" "Handles requests related to processing payments and generating owner billing statements."
                appointmentHistoryComponent = component "Appointment History Component" "Handles requests related to viewing a patient's appointment history."
            }
            cmsWebApplication = container "CMS Web Application" "Provides content management functionality for the booking care website." "React and JavaScript" {
                contentManagementComponent = component "Content Management Component" "Handles requests related to managing the content on the booking care website."
                patientRecordComponent = component "Patient Record Component" "Handles requests related to viewing and updating patient records."
                billingComponent = component "Billing Component" "Handles requests related to processing payments and generating billing statements."
                adminManagementComponent = component "Admin Management Component" "Handles requests related to managing admin users."
                doctorManagementComponent = component "Doctor Management Component" "Handles requests related to managing doctor users."
            }
            database = container "Database" "Stores patient records, appointment information, payment information, and other data for the booking care system." "MySQL Database"
        }
    }

    # relationships between people and software systems
    users -> bookingCareSystem "Book appointments and view appointment history using"
    doctors -> bookingCareSystem "Manage schedules and view patient records using"
    admin -> bookingCareSystem "Manage the system and patient records using"

    # relationships between containers
    apiApplication -> database "Reads from and writes to"
    webOfficeApplication -> apiApplication "Uses"
    cmsWebApplication -> apiApplication "Uses"
  }
  views {
    systemcontext bookingCareSystem "SystemContext" {
      include *
      autoLayout
    }

    container bookingCareSystem "Containers" {
      include *
      animation {
        apiApplication
        webOfficeApplication
        cmsWebApplication
        database
      }
      autoLayout
    }

    component apiApplication "Api_Application_Components" {
      include *
      animation {
        appointmentController
        patientController
        authenticationComponent
        paymentController
        notificationController
      }
      autoLayout
    }

    component webOfficeApplication "Web_Office_Application_Components" {
      include *
      animation {
        schedulingComponent
        notificationComponent
        ownerPatientRecordComponent
        ownerBillingComponent
        appointmentHistoryComponent
      }
      autoLayout
    }

    component cmsWebApplication "CMS_Web_Application_Components" {
      include *
      animation {
        contentManagementComponent
        patientRecordComponent
        billingComponent
        adminManagementComponent
        doctorManagementComponent
      }
      autoLayout
    }

    styles {
      element "Person" {
        color #ffffff
        fontSize 22
        shape Person
      }
      element "Software System" {
        background #1168bd
        color #ffffff
      }
      element "Container" {
        background #438dd5
        color #ffffff
      }
      element "Component" {
        background #85bbf0
        color #000000
      }
    }
  }
}