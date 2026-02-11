# taxi_planning
Planning and Reasoning project 
Serena Ragaglia 1941007
Giovanni Di Nola 1894682


downward domain.pddl problem.pddl --search "astar(blind())"
downward domain.pddl problem.pddl --search "astar(lmcut())"

enhsp -o domain.pddl -f problem1.pddl -h hmax -s Greedy
enhsp -o domain.pddl -f problem2.pddl -h hmax -s Greedy > results/p2_greedy_hmax.txt
enhsp -o domain.pddl -f problem3.pddl -h hmax -s Greedy > results/p3_greedy_hmax.txt

enhsp -o domain.pddl -f problem1.pddl -h hadd -s Greedy > results/p1_greedy_hadd.txt
enhsp -o domain.pddl -f problem2.pddl -h hadd -s Greedy > results/p2_greedy_hadd.txt
enhsp -o domain.pddl -f problem3.pddl -h hadd -s Greedy > results/p3_greedy_hadd.txt

enhsp -o domain.pddl -f problem1.pddl -h hmax -s AStar > results/p1_astar_hmax.txt
enhsp -o domain.pddl -f problem2.pddl -h hmax -s AStar > results/p2_astar_hmax.txt
enhsp -o domain.pddl -f problem3.pddl -h hmax -s AStar > results/p3_astar_hmax.txt

enhsp -o domain.pddl -f problem1.pddl -h hadd -s AStar > results/p1_astar_hadd.txt
enhsp -o domain.pddl -f problem2.pddl -h hadd -s AStar > results/p2_astar_hadd.txt
enhsp -o domain.pddl -f problem3.pddl -h hadd -s AStar > results/p3_astar_hadd.txt

enhsp -o domain.pddl -f problem1.pddl -h hmax -s WAStar > results/p1_wastar_hmax.txt
enhsp -o domain.pddl -f problem2.pddl -h hmax -s WAStar > results/p2_wastar_hmax.txt
enhsp -o domain.pddl -f problem3.pddl -h hmax -s WAStar > results/p3_wastar_hmax.txt

enhsp -o domain.pddl -f problem1.pddl -h hadd -s WAStar > results/p1_wastar_hadd.txt
enhsp -o domain.pddl -f problem2.pddl -h hadd -s WAStar > results/p2_wastar_hadd.txt
enhsp -o domain.pddl -f problem3.pddl -h hadd -s WAStar > results/p3_wastar_hadd.txt

swipl indigolog/config.pl taxi/main.pl

legal task
[move(park1, restaurant), move(restaurant, school), pickUp(p2, school), move(school, restaurant), getOff(p2, restaurant)].

illegal task
[move(park1, restaurant), move(restaurant, school), pickUp(p2, school), getOff(p2, school)].
PROGRAM: Program fails: 
        [[],getOff(p2,school)]
 ...at history:
         [pickUp(p2,school),move(restaurant,school),move(park1,restaurant)]

projection task
Write the condition 'and(f1(), neg(f2())).':
|: and(taxi_at(office), neg(request_to(p1, pub))).
Write the sequence of actions '[a1(), ..., an()].':
|: [move(park1, office), pickUp(p1, office), move(office, park2), move(park2, school), move(school, pub), getOff(p1, pub), move(pub, school), move(school, park2), move(park2, office)].
Condition and(taxi_at(office),neg(request_to(p1,pub))) HOLDS after executing [move(park1,office),pickUp(p1,office),move(office,park2),move(park2,school),move(school,pub),getOff(p1,pub),move(pub,school),move(school,park2),move(park2,office)]
true.

regression task
Write the goal situation 'and(f1(), neg(f2())).':
|: and(taxi_at(park2),neg(request_to(p1,pub))).
Goal situation and(taxi_at(park2),neg(request_to(p1,pub))) IS reachable from initial situation