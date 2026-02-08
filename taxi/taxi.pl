:- dynamic controller/1.
:- discontiguous
    fun_fluent/1,
    rel_fluent/1,
    proc/2,
    causes_val/4,
    causes_true/3,
    causes_false/3.

cache(_) :- fail.

%% DOMAIN OBJECTS


location(school).
location(restaurant).
location(park1).
location(park2).
location(bank).
location(office1).
location(apartment1).
location(apartment2).
location(airport).
location(pub).
location(mall).
location(hotel).
location(chargeStation1).
location(chargeStation2).

passenger(p1).
passenger(p2).
passenger(p3).
passenger(p4).

%% STATIC RELATIONS

cost_per_distance(2).

road(school, restaurant).
road(restaurant, school).
road(school, park2).
road(park2, school).
road(restaurant, park1).
road(park1, restaurant).
road(restaurant, bank).
road(bank, restaurant).
road(bank, park2).
road(park2, bank).
road(bank, office1).
road(office1, bank).
road(office1, park2).
road(park2, office1).
road(office1, park1).
road(park1, office1).
road(park2, chargeStation1).
road(chargeStation1, park2).
road(office1, apartment1).
road(apartment1, office1).
road(restaurant, apartment2).
road(apartment2, restaurant).
road(apartment2, pub).
road(pub, apartment2).
road(apartment1, hotel).
road(hotel, apartment1).
road(hotel, chargeStation2).
road(chargeStation2, hotel).
road(chargeStation2, park1).
road(park1, chargeStation2).
road(apartment2, airport).
road(airport, apartment2).
road(school, airport).
road(airport, school).
road(chargeStation1, pub).
road(pub, chargeStation1).
road(mall, pub).
road(pub, mall).
road(mall, apartment1).
road(apartment1, mall).


distance(school, restaurant, 5).
distance(restaurant, school, 5).
distance(school, park2, 6).
distance(park2, school, 6).
distance(restaurant, park1, 4).
distance(park1, restaurant, 4).
distance(restaurant, bank, 5).
distance(bank, restaurant, 5).
distance(bank, park2, 6).
distance(park2, bank, 6).
distance(bank, office1, 8).
distance(office1, bank, 8).
distance(office1, park2, 5).
distance(park2, office1, 5).
distance(office1, park1, 4).
distance(park1, office1, 4).
distance(park2, chargeStation1, 3).
distance(chargeStation1, park2, 3).
distance(office1, apartment1, 4).
distance(apartment1, office1, 4).
distance(restaurant, apartment2, 6).
distance(apartment2, restaurant, 6).
distance(apartment1, hotel, 5).
distance(hotel, apartment1, 5).
distance(hotel, chargeStation2, 4).
distance(chargeStation2, hotel, 4).
distance(chargeStation2, park1, 7).
distance(park1, chargeStation2, 7).
distance(apartment2, airport, 8).
distance(airport, apartment2, 8).
distance(school, airport, 10).
distance(airport, school, 10).
distance(chargeStation1, pub, 3).
distance(pub, chargeStation1, 3).
distance(mall, pub, 4).
distance(pub, mall, 4).
distance(mall, apartment1, 6).
distance(apartment1, mall, 6).
distance(apartment2, pub, 2).
distance(pub, apartment2, 2).

charge_station(chargeStation1).
charge_station(chargeStation2).

congested(apartment1).
congested(mall).
congested(park2).
congested(airport).


/* FLUENTS  and  CAUSAL LAWS */

% taxi_at
rel_fluent(taxi_at(L)) :- location(L).
causes_true(move(_, L2),  taxi_at(L2), true).
causes_false(move(L1, _), taxi_at(L1), true).

% passenger_at
rel_fluent(passenger_at(P, L)) :- passenger(P), location(L).
causes_false(pickUp(P, L), passenger_at(P, L), true).
causes_true(getOff(P, L), passenger_at(P, L), true).

% on_taxi
rel_fluent(on_taxi(P)) :- passenger(P).
causes_true(pickUp(P, _),  on_taxi(P), true).
causes_false(getOff(P, _), on_taxi(P), true).

% request_to
rel_fluent(request_to(P, L)) :- passenger(P), location(L).
causes_false(getOff(P, L), request_to(P, L), true).
causes_true(pickUp(P, _), request_to(P, _), true).

% battery_level
fun_fluent(battery_level).
causes_val(recharge(_), battery_level, 100, true).
causes_val(move(L1, L2), battery_level, B2,
    and(battery_level = B1,
    and(distance(L1, L2, D),
    and(cost_per_distance(C),
        B2 is B1 - D * C)))).

% total_cost
fun_fluent(total_cost).
causes_val(move(L1, L2), total_cost, C2,
    and(congested(L2),
    and(total_cost = C1,
    and(distance(L1, L2, D),
        C2 is C1 + D * 5)))).
causes_val(move(L1, L2), total_cost, C2,
    and(neg(congested(L2)),
    and(total_cost = C1,
    and(distance(L1, L2, D),
        C2 is C1 + D)))).
causes_val(recharge(_), total_cost, C2,
    and(total_cost = C1, C2 is C1 + 10)).

/* ACTIONS and PRECONDITIONS*/

prim_action(move(L1, L2)) :- location(L1), location(L2).
poss(move(L1, L2),
    and(taxi_at(L1),
    and(road(L1, L2),
    (battery_level > (D * C)))
    )) :- distance(L1, L2, D), cost_per_distance(C).


prim_action(recharge(L)) :- location(L).
poss(recharge(L),
    and(charge_station(L),
    and(taxi_at(L),
        battery_level < 100))).

prim_action(pickUp(P, L)) :- passenger(P), location(L).
poss(pickUp(P, L),
    and(passenger_at(P, L),
    and(taxi_at(L),
    and(some(l, request_to(P, l)),
        neg(some(q, on_taxi(q))))))).

prim_action(getOff(P, L)) :- passenger(P), location(L).
poss(getOff(P, L),
    and(on_taxi(P),
    and(taxi_at(L),
        request_to(P, L)))).

execute(A, SR) :- ask_execute(A, SR).
exog_occurs(_) :- fail.

/* INITIAL STATE */

initially(taxi_at(office1), true).
initially(taxi_at(L), false) :- location(L), L \= office1.

initially(passenger_at(p1, restaurant), true).
initially(passenger_at(p2, pub), true).
initially(passenger_at(p3, apartment2), true).
initially(passenger_at(p4, school), true).
initially(passenger_at(P, L), false) :-
    passenger(P), location(L), \+ initially(passenger_at(P, L), true).

initially(request_to(p1, park2), true).
initially(request_to(p2, hotel), true).
initially(request_to(p3, mall), true).
initially(request_to(p4, apartment1), true).
initially(request_to(P, L), false) :-
    passenger(P), location(L), \+ initially(request_to(P, L), true).

initially(on_taxi(P), false) :- passenger(P).
initially(battery_level, 100).
initially(total_cost, 0).
proc(some_pending, some(p, some(l, request_to(p, l)))).
proc(pending_passenger(P), some(l, request_to(P, l))).



/* COMPLEX ACTIONS */


proc(go_to_destination(L),
    while(neg(taxi_at(L)),
        pi(from,
        pi(to,
            [?(taxi_at(from)),
             ?(road(from, to)),
             move(from, to)])))).

proc(serve_passenger(P, Src, Dst),
    [go_to_destination(Src),
     pickUp(P, Src),
     go_to_destination(Dst),
     getOff(P, Dst)]).

proc(serve_some_passenger,
    pi(p,
        [?(pending_passenger(p)),
         pi(src, [?(passenger_at(p, src)),
         pi(dst, [?(request_to(p, dst)),
                   serve_passenger(p, src, dst)])])])).

proc(recharge_battery,
    pi(L,
        [?(charge_station(L)),
         go_to_destination(L),
         recharge(L)])).

proc(serve_battery_aware,
    [serve_some_passenger,
     if((battery_level(B), B < 25), recharge_battery, true)]).

/*CONTROLLERS*/

proc(control(basic),
[
        while(some_pending, serve_some_passenger),
     go_to_destination(office1)]).

actionNum(X, X).