(define (problem taxi_problem1)
    (:domain taxi_domain1)
    (:objects p1 - passenger
              p2 - passenger
            school - location
            restaurant - location
            bank - location
            office - location
            park1 - location
            park2 - location       
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

        (passengerAt p1 restaurant)
        (passengerAt p2 school)
        (taxiAt office)
        
        (requestTo p1 park2)
        (requestTo p2 office)        
        
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

        (= (cost-per-distance) 0.25)
  
        (= (batteryLevel) 100)  
        (= (total-cost) 0)

    )
    (:goal (forall (?l - location)
                        (and
                            (not (requestTo p1 ?l))
                            (not (requestTo p2 ?l))
                        )                                
            )        
    )
    (:metric minimize (total-cost))
)