# taxi_planning
Planning and Reasoning project 
Serena Ragaglia 1941007
Giovanni Di Nola 1894682


downward domain.pddl problem.pddl --search "astar(blind())"
downward domain.pddl problem.pddl --search "astar(lmcut())"

enhsp -o domain.pddl -f problem.pddl -h hmax -s Greedy

enhsp -o domain.pddl -f problem.pddl -h hmax -s AStar
enhsp -o domain.pddl -f problem2.pddl -h hadd -s AStar


enhsp -o domain.pddl -f problem.pddl -h hmax -s WAStar
enhsp -o domain.pddl -f problem.pddl -h hadd -s WAStar