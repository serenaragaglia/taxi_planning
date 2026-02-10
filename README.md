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