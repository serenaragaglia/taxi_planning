(define (problem taxi_problem2)
    (:domain taxi_domain1)
    (:objects 
            p1 - passenger
            p2 - passenger
            p3 - passenger
            p4 - passenger
            school - location
            restaurant - location
            bank - location
            office - location
            park1 - location
            park2 - location  
            apartment1 - location
            apartment2 - location
            hotel - location
            airport - location
            pub - location
            mall - location

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

        (passengerAt p1 restaurant)
        (passengerAt p2 school)
        (passengerAt p3 apartment2)
        (passengerAt p4 park1)
        (taxiAt office)
        
        (requestTo p1 park2)

        (requestTo p2 apartment1)    

        (requestTo p3 mall)

        (requestTo p4 airport)


        
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

        (= (cost-per-distance) 2)
  
        (= (batteryLevel) 100)  
        (= (total-cost) 0)

    )
    (:goal (and (passengerAt p1 park2)
                (passengerAt p2 apartment1)
                (passengerAt p3 mall)
                (passengerAt p4 airport)
        )
    )
    (:metric minimize (total-cost))
)