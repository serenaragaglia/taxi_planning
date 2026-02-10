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
location(office).
location(pub).

passenger(p1).
passenger(p2).
passenger(p3).
passenger(p4).

%% STATIC RELATIONS

cost_per_distance(2).

road(school, restaurant). road(restaurant, school).
road(school, park2). road(park2, school).
road(restaurant, park1). road(park1, restaurant).
road(restaurant, bank). road(bank, restaurant).
road(bank, park2). road(park2, bank).
road(bank, office). road(office, bank).
road(office, park2). road(park2, office).
road(office, park1). road(park1, office).
road(school, pub). road(pub, school).


distance(school, restaurant, 5). distance(restaurant, school, 5).
distance(school, park2, 6). distance(park2, school, 6).
distance(restaurant, park1, 4). distance(park1, restaurant, 4).
distance(restaurant, bank, 5). distance(bank, restaurant, 5).
distance(bank, park2, 6). distance(park2, bank, 6).
distance(bank, office, 4). distance(office, bank, 4).
distance(office, park2, 6). distance(park2, office, 6).
distance(office, park1, 4). distance(park1, office, 4).
distance(school, pub, 7). distance(pub, school, 7).


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

% congested
rel_fluent(congested(L)) :- location(L).

% battery_level
fun_fluent(battery_level).
causes_val(recharge(_), battery_level, 100, true).

causes_val(move(L1, L2), battery_level, B2,
    and(neg(congested(L2)),
    and(battery_level = B1,
    and(distance(L1, L2, D),
    and(cost_per_distance(C),
        B2 is B1 - D * C))))).

causes_val(move(L1, L2), battery_level, B2,
    and(congested(L2),
    and(battery_level = B1,
    and(distance(L1, L2, D),
    and(cost_per_distance(C),
        B2 is B1 - D * C * 2))))).

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
        neg(some(j, on_taxi(j)))))).

prim_action(getOff(P, L)) :- passenger(P), location(L).
poss(getOff(P, L),
    and(on_taxi(P),
    and(taxi_at(L),
        request_to(P, L)))).

execute(A, SR) :- ask_execute(A, SR).

% exogenous actions for congestion
exog_action(start(L)) :- location(L).
exog_action(end(L)) :- location(L).

prim_action(Act) :- exog_action(Act).

% poss for exog actions
poss(start(L), congested(L) = false) :- location(L).
poss(end(L), congested(L) = true) :- location(L).

% effect of exog actions
causes_false(end(L), congested(L), true).
causes_true(start(L), congested(L), true).

/* exogenous actions for requests
exog_action(call(P, L)) :- passenger(P), location(L).
poss(call(P,L), neg(some(j, request_to(P, j) ) ) ) :- passenger(P), location(L).

causes_true(call(P, L), request_to(P, L), true).*/


% changing world
rel_fluent(has_changed).
causes_true(start(_L), has_changed, true).
causes_true(end(_L), has_changed, true).

% causes_true(call(_P, _L), has_changed, true).

/* INITIAL STATE */

initially(taxi_at(park1), true).
initially(taxi_at(L), false) :- location(L), \+ initially(taxi_at(L), true).

initially(passenger_at(p1, office), true).
initially(passenger_at(p2, school), true).
initially(passenger_at(P, L), false) :- passenger(P), location(L), \+ initially(passenger_at(P, L), true).

initially(request_to(p1, pub), true).
initially(request_to(p2, restaurant), true).
initially(request_to(P, L), false) :-
    passenger(P), location(L), \+ initially(request_to(P, L), true).


initially(congested(L), false):- location(L).

initially(has_changed, false).

initially(on_taxi(P), false) :- passenger(P).
initially(battery_level, 100).
initially(total_cost, 0).
proc(some_pending, some(p, some(l, request_to(p, l)))).
proc(pending_passenger(P), some(l, request_to(P, l))).

proc(pi_move, pi([l1, l2], move(l1, l2))).
proc(pi_pickup, pi([p, l], pickUp(p, l))).
proc(pi_dropoff, pi([p, l], getOff(p, l))).

proc(final_condition, neg(some(p, some(l, request_to(p, l))))).

proc(random_walk, star(pi([l1, l2], move(l1, l2)))).

proc(random_action, 
    ndet(pi_dropoff, 
        ndet(pi_pickup, 
            ndet(pi_move, 
                ndet(pi_recharge))))).

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

/*CONTROLLERS*/

proc(control(wander), search(wander)).
proc(wander, [
  star(random_action),
  ?(taxi_at(restaurant))
]).

proc(control(dumb), search(dumb)).
proc(dumb, [
  star(random_action),
  ?(final_condition)
]).

proc(control(basic), search(basic)).
proc(basic, [
    while(and(neg(final_condition), battery_level > 10), serve_some_passenger), go_to_destination(office)]).

/*Reactive controller*/
proc(control(reactive), [
    prioritized_interrupts([
        interrupt(has_changed, [
            unset(has_changed),
            gexec(has_changed, search(dumb))
        ])
    ]),
    search(basic)
]).


actionNum(X, X).
