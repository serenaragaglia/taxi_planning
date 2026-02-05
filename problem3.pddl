(define (problem taxi_problem3)
    (:domain taxi_domain1)
    (:objects 
            p1 - passenger
            p2 - passenger
            p3 - passenger
            p4 - passenger

            school - location
            restaurant - location
            bank - location
            office1 - location
            park1 - location
            park2 - location  
            apartment1 - location
            apartment2 - location
            hotel - location
            airport - location
            pub - location
            mall - location
            
            chargeStation1 - location
            chargeStation2 - location

    ) 
    (:init
        (road school restaurant)
        (road restaurant school)
        (road school park2)
        (road park2 school)
        (road restaurant park1)
        (road park1 restaurant)
        (road restaurant bank)
        (road bank restaurant)

        (road bank park2)
        (road park2 bank)
        (road bank office1)
        (road office1 bank)
        (road office1 park2)
        (road park2 office1)
        (road office1 park1)
        (road park1 office1)

        (road park2 chargeStation1)
        (road chargeStation1 park2)
        (road office1 apartment1)
        (road apartment1 office1)
        (road restaurant apartment2)
        (road apartment2 restaurant)
        (road apartment2 pub)
        (road pub apartment2)
        (road apartment1 hotel)
        (road hotel apartment1)
        (road hotel chargeStation2)
        (road chargeStation2 hotel)
        (road chargeStation2 park1)
        (road park1 chargeStation2)
        (road apartment2 airport)
        (road airport apartment2)
        (road school airport)
        (road airport school)

        (road chargeStation1 pub)
        (road pub chargeStation1)
        (road mall pub)
        (road pub mall)
        (road mall apartment1)
        (road apartment1 mall)





    ;;passengers' location
        (passengerAt p1 restaurant)
        (passengerAt p2 pub)
        (passengerAt p3 apartment2)
        (passengerAt p4 school)

        (taxiAt office1)
        
    ;;passengers' requests
        (requestTo p1 park2)

        (requestTo p2 hotel)    

        (requestTo p3 mall)

        (requestTo p4 apartment1)


    ;;charge stations defintion
        (chargeStation chargeStation1)
        (chargeStation chargeStation2)

    ;;distances definitions
        (= (distance school restaurant) 5)
        (= (distance restaurant school) 5)
        (= (distance school park2) 6)
        (= (distance park2 school) 6)
        (= (distance restaurant park1) 4)
        (= (distance park1 restaurant) 4)
        (= (distance restaurant bank) 5)
        (= (distance bank restaurant) 5)
        (= (distance bank park2) 6)
        (= (distance park2 bank) 6)
        (= (distance bank office1) 8)
        (= (distance office1 bank) 8)
        (= (distance office1 park2) 5)
        (= (distance park2 office1) 5)
        (= (distance office1 park1) 4)
        (= (distance park1 office1) 4)
        (= (distance park2 chargeStation1) 3)
        (= (distance chargeStation1 park2) 3)
        (= (distance office1 apartment1) 4)
        (= (distance apartment1 office1) 4)
        (= (distance restaurant apartment2) 6)
        (= (distance apartment2 restaurant) 6)

        (= (distance apartment1 hotel) 5)
        (= (distance hotel apartment1) 5)
        (= (distance hotel chargeStation2) 4)
        (= (distance chargeStation2 hotel) 4)
        (= (distance chargeStation2 park1) 7)
        (= (distance park1 chargeStation2) 7)
        (= (distance apartment2 airport) 8)
        (= (distance airport apartment2) 8)
        (= (distance school airport) 10)
        (= (distance airport school) 10)
        (= (distance chargeStation1 pub) 3)
        (= (distance pub chargeStation1) 3)
        (= (distance mall pub) 4)
        (= (distance pub mall) 4)
        (= (distance mall apartment1) 6)
        (= (distance apartment1 mall) 6)

    ;;congested locations
        (congested apartment1)
        (congested mall)
        (congested park2)
        (congested airport)
        

    
    ;;traffic lights definition
        ;(trafficLight park2 office1)
        ;(trafficLight office1 park2)

        ;(trafficLight bank office1)
        ;(trafficLight office1 bank)

        (trafficLight park1 office1)
        (trafficLight office1 park1)

        (trafficLight pub mall)
        (trafficLight mall pub)


        (trafficLight restaurant bank)
        (trafficLight bank restaurant)
    
    ;;traffic lights color

        ;;(lightColor red park2 office1)
        ;;(lightColor red office1 park2)

        ;;(lightColor red bank office1)
        ;;(lightColor red office1 bank)

        (lightColor red park1 office1)
        (lightColor red office1 park1)


        (lightColor red pub mall)
        (lightColor red mall pub)


        (lightColor red restaurant bank)
        (lightColor red bank restaurant)


        (= (cost-per-distance) 2)
  
        (= (batteryLevel) 100)  
        (= (total-cost) 0)

    )
    (:goal (forall (?l - location)
                    (not(exists (?p - passenger)(requestTo ?p ?l) ))                               
            )
    )
    (:metric minimize (total-cost))
)