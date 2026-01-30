(define (problem taxi_problem1)
    (:domain taxi_domain1)
    (:objects p1 - passenger
              p2 - passenger
              l1 - location
              l2 - location
              l3 - location) 
    (:init
        (road l1 l2)
        (road l2 l1)
        (road l2 l3)
        (road l3 l2)
        (passengerAt p1 l1)
        (passengerAt p2 l1)
        (taxiAt l2)
        (requestTo p1 l3)
        (requestFrom p1 l1)
        (= (distance l1 l2) 2)
        (= (distance l2 l3) 3)
        (= (distance l2 l1) 2)
        (= (distance l3 l2) 3)


        (= (distance-cost l1 l2) 0.25)
        (= (distance-cost l2 l3) 0.60)
        (= (distance-cost l2 l1) 0.25)
        (= (distance-cost l3 l2) 0.60)      
        (= (batteryLevel) 100)  
        (= (total-cost) 0)

    )
    (:goal (and
                (passengerAt p1 l3)
                (>= (batteryLevel) 60)
            )
    )
    (:metric minimize (total-cost))
)