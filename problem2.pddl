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
        (= (total-cost) 0)

    )
    (:goal 
            (passengerAt p1 l3)
    )
    (:metric minimize (total-cost))
)