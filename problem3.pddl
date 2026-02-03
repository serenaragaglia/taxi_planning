(define (problem taxi_problem3)
    (:domain taxi_domain1)
    (:objects 
            p1 - passenger
            p2 - passenger
            p3 - passenger
            p4 - passenger
            p5 - passenger
            p6 - passenger
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

            museum - location
            library - location
            college - location
            office2 - location
            conventionCenter - location
            bookstore - location
            gym - location
            cinema - location
            theater - location
            
            
            chargeStation1 - location
            chargeStation2 - location
            chargeStation3 - location

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
        (road bank office)
        (road office bank)
        (road office park2)
        (road park2 office)
        (road office park1)
        (road park1 office)

        (road park2 chargeStation1)
        (road chargeStation1 park2)
        (road office apartment1)
        (road apartment1 office)
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

        (road park1 conventionCenter)
        (road conventionCenter park1)
        (road conventionCenter theater)
        (road theater conventionCenter)
        (road conventionCenter park1)
        (road park1 conventionCenter)
        (road theater office2)
        (road office2 theater)
        (road gym office2)
        (road office2 gym)
        (road gym hotel)
        (road hotel gym)
        (road mall library)
        (road library mall)
        (road library college)
        (road college library)
        (road college museum)
        (road museum college)
        (road college chargeStation3)
        (road chargeStation3 college)
        (road museum chargeStation1)
        (road chargeStation1 museum)
        (road mall museum)
        (road museum mall)
        (road cinema chargeStation1)
        (road chargeStation1 cinema)
        (road cinema bookstore)
        (road bookstore cinema)
        (road bookstore airport)
        (road airport bookstore)

        (passengerAt p1 restaurant)
        (passengerAt p2 school)
        (passengerAt p3 apartment2)
        (passengerAt p4 park1)
        (passengerAt p5 gym)
        (passengerAt p6 library)
        (taxiAt office)
        
        (requestTo p1 park2)

        (requestTo p2 apartment1)    

        (requestTo p3 mall)

        (requestTo p4 airport)

        (requestTo p5 school)

        (requestTo p6 cinema)

        (request)

        (requestTo)

        (chargeStation chargeStation1)
        (chargeStation chargeStation2)
        (chargeStation chargeStation3)

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
        (= (distance bank office) 8)
        (= (distance office bank) 8)
        (= (distance office park2) 5)
        (= (distance park2 office) 5)
        (= (distance office park1) 4)
        (= (distance park1 office) 4)
        (= (distance park2 chargeStation1) 3)
        (= (distance chargeStation1 park2) 3)
        (= (distance office apartment1) 4)
        (= (distance apartment1 office) 4)
        (= (distance restaurant apartment2) 6)
        (= (distance apartment2 restaurant) 6)
        (= (distance apartment2 pub) 2)
        (= (distance pub apartment2) 2)
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
        (= (distance park1 conventionCenter) 5)
        (= (distance conventionCenter park1) 5)
        (= (distance conventionCenter theater) 4)
        (= (distance theater conventionCenter) 4)
        (= (distance theater office2) 6)
        (= (distance office2 theater) 6)
        (= (distance gym office2) 3)
        (= (distance office2 gym) 3)
        (= (distance gym hotel) 4)
        (= (distance hotel gym) 4)
        (= (distance mall library) 5)
        (= (distance library mall) 5)
        (= (distance library college) 6)
        (= (distance college library) 6)
        (= (distance college museum) 7)
        (= (distance museum college) 7)
        (= (distance college chargeStation3) 8)
        (= (distance chargeStation3 college) 8)
        (= (distance museum chargeStation1) 4)
        (= (distance chargeStation1 museum) 4)
        (= (distance mall museum) 6)
        (= (distance museum mall) 6)
        (= (distance cinema chargeStation1) 5)
        (= (distance chargeStation1 cinema) 5)
        (= (distance cinema bookstore) 4)
        (= (distance bookstore cinema) 4)
        (= (distance bookstore airport) 7)
        (= (distance airport bookstore) 7)

        (congested apartment1)
        (congested mall)
        (congested park2)
        (congested airport)
        (congested museum)
        (congested conventionCenter)
        (congested pub)

        (trafficLight apartment1 office)
        (trafficLight pub mall)
        (trafficLight airport bookstore)
        (trafficLight theater conventionCenter)
        (trafficLight hotel gym)

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