:- dynamic controller/1.
:- discontiguous
    fun_fluent/1,
    rel_fluent/1,
    proc/2,
    causes_true/3,
    causes_false/3.

cache(_) :- fail.

%% DOMAIN OBJECTS

location(school).
location(restaurant).
location(park1).
location(park2).
location(bank).
location(office).
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

charge_station(chargeStation1).
charge_station(chargeStation2).

%% STATIC RELATIONS

road(L1,L2).
distance(L1,L2,D).

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
road(bank, office).
road(office, bank).
road(office, park2).
road(park2, office).
road(office, park1).
road(park1, office).
road(park2, chargeStation1).
road(chargeStation1, park2).
road(office, apartment1).
road(apartment1, office).
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

chargeStation(chargeStation1).
chargeStation(chargeStation2).

congested(apartment1).
congested(mall).
congested(park2).
congested(airport).

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
distance(bank, office, 8).
distance(office, bank, 8).
distance(office, park2, 5).
distance(park2, office, 5).
distance(office, park1, 4).
distance(park1, office, 4).
distance(park2, chargeStation1, 3).
distance(chargeStation1, park2, 3).
distance(office, apartment1, 4).
distance(apartment1, office, 4).
distance(restaurant, apartment2, 6).
distance(apartment2, restaurant, 6).
distance(apartment2, pub, 2).
distance(pub, apartment2, 2).
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

cost_per_distance(2).

%% FLUENTS

rel_fluent(taxi_at(L)) :- location(L).
rel_fluent(passenger_at(P,L)) :- passenger(P), location(L).
rel_fluent(on_taxi(P)) :- passenger(P).
rel_fluent(request_to(P,L)) :- passenger(P), location(L).

fun_fluent(battery_level).
fun_fluent(total_cost).

%% TRAFFIC LIGHT FLUENTS

rel_fluent(light_green(L)) :- location(L).
rel_fluent(light_red(L)) :- location(L).

%% ACTIONS

prim_action(move(L1,L2)) :- location(L1), location(L2).
prim_action(pickup(P,L)) :- passenger(P), location(L).
prim_action(dropoff(P,L)) :- passenger(P), location(L).
prim_action(recharge(L)) :- location(L).
% `toggle_light/1` is exogenous and therefore not declared as a prim_action here.

%% ACTION PRECONDITIONS

poss(move(L1,L2), (
    taxi_at(L1),
    road(L1,L2),
    battery_level(B),
    distance(L1,L2,D),
    cost_per_distance(C),
    B >= D * C
)).

poss(pickup(P,L), (
    taxi_at(L),
    passenger_at(P,L),
    request_to(P,_),
    \+ on_taxi(_)
)).

poss(dropoff(P,L), (
    on_taxi(P),
    taxi_at(L),
    request_to(P,L)
)).

poss(recharge(L), (
    taxi_at(L),
    charge_station(L),
    battery_level(B),
    B < 100
)).

% Exogenous action declaration for traffic-light toggles
exog_action(toggle_light(L)) :- location(L).

% Treat exogenous actions as primitive for the executor and give them
% an unconditional precondition (they can occur at any time).
prim_action(Act) :- exog_action(Act).
poss(Act, true) :- exog_action(Act).

%% CAUSAL LAWS

% --- taxi position
causes_true(move(_,L2), taxi_at(L2), true).
causes_false(move(L1,_), taxi_at(L1), true).

% --- passenger boarding
causes_true(pickup(P,_), on_taxi(P), true).
causes_false(dropoff(P,_), on_taxi(P), true).

causes_false(pickup(P,L), passenger_at(P,L), true).
causes_true(dropoff(P,L), passenger_at(P,L), true).

% --- request satisfied
causes_false(dropoff(P,L), request_to(P,L), true).

% --- battery
causes_true(recharge(_), battery_level(100), true).

causes_true(move(L1,L2), battery_level(B2),
    ( battery_level(B1),
      distance(L1,L2,D),
      cost_per_distance(C),
      B2 is B1 - D * C )
).

% --- cost
causes_true(move(L1,L2), total_cost(C2),
    ( total_cost(C1),
      distance(L1,L2,D),
      cost_per_distance(C),
      C2 is C1 + D * C )
).

% --- traffic lights (exogenous)
% toggle_light flips a light from red to green or green to red
causes_true(toggle_light(L), light_green(L),
    ( light_red(L) )
).
causes_false(toggle_light(L), light_red(L),
    ( light_red(L) )
).

causes_true(toggle_light(L), light_red(L),
    ( light_green(L) )
).
causes_false(toggle_light(L), light_green(L),
    ( light_green(L) )
).

%% INITIAL STATE

initially(taxi_at(office), true).

initially(passenger_at(p1, restaurant), true).
initially(passenger_at(p2, school), true).
initially(passenger_at(p3, apartment2), true).
initially(passenger_at(p4, park1), true).

initially(request_to(p1, park2), true).
initially(request_to(p2, apartment1), true).
initially(request_to(p3, mall), true).
initially(request_to(p4, airport), true).

initially(on_taxi(P), false) :- passenger(P).

initially(battery_level(100), true).
initially(total_cost(0), true).
initially(light_green(L), true) :- location(L).

%% GOAL

goal(neg(some(P,L, request_to(P,L)))).

%% COMPLEX ACTIONS

proc(pi_move,
    pi([l1,l2], move(l1,l2))
).

proc(pi_pickup,
    pi([p,l], pickup(p,l))
).

proc(pi_dropoff,
    pi([p,l], dropoff(p,l))
).

proc(pi_recharge,
    pi(l, recharge(l))
).

proc(choose_action,
    ndet(
        ndet(pi_move, pi_pickup),
        ndet(pi_dropoff, pi_recharge)
    )
).

%% CONTROLLERS
proc(control(full_search), search(full_search)).

proc(full_search, [
    star(choose_action),
    ?(goal)
]).

%% EXECUTOR INFO

actionNum(X,X).