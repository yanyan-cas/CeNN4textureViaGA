function [best_fitness, elite, generation] = my_ga(number_of_variables, fitness_function, ...

   population_size, parent_number, mutation_rate, maximal_generation, minimal_cost)

% number_of_variables = 求解问题的参数个数

% fitness_function = 自定义适应度函数名

% population_size = 种群规模（每一代个体数目）

% parent_number = 每一代中保持不变的数目（除了变异）

% mutation_rate = 变异概率

% maximal_generation = 最大演化代数

% minimal_cost = 最小目标值（函数值越小，则适应度越高）



cumulative_probabilities = cumsum((parent_number:-1:1) ...

                        / sum(parent_number:-1:1)); %一个从0到1增长得越来越慢的函数

best_fitness = ones(maximal_generation, 1); % 用于记录每一代的最佳适应度

elite = zeros(maximal_generation, number_of_variables); % 用于记录每一代的最优解

child_number = population_size - parent_number; % 每一代子女的数目

population = rand(population_size, number_of_variables); % 初始化种群



for generation = 1 : maximal_generation % 演化循环开始

   cost = feval(fitness_function, population); % 计算所有个体的适应度

   [cost, index] = sort(cost); % 将适应度函数值从小到大排序

   population = population(index(1:parent_number), :); % 先保留一部分较优的个体

   best_fitness(generation) = cost(1); % 记录本代的最佳适应度

   elite(generation, :) = population(1, :); % 记录本代的最优解（精英）

   if best_fitness(generation) < minimal_cost; break; end % 若最优解已足够好，则停止演化

   

   for child = 1:2:child_number % 染色体交叉开始

       mother = min(find(cumulative_probabilities > rand)); % 选择一个较优秀的母亲

       father = min(find(cumulative_probabilities > rand)); % 选择一个较优秀的父亲

       crossover_point = ceil(rand*number_of_variables); % 随机地确定一个染色体交叉点

       mask1 = [ones(1, crossover_point), zeros(1, number_of_variables - crossover_point)];

       mask2 = not(mask1);

       mother_1 = mask1 .* population(mother, :); % 母亲染色体的前部分

       mother_2 = mask2 .* population(mother, :); % 母亲染色体的后部分

       father_1 = mask1 .* population(father, :); % 父亲染色体的前部分

       father_2 = mask2 .* population(father, :); % 父亲染色体的后部分

       population(parent_number + child, :) = mother_1 + father_2; % 一个孩子

       population(parent_number+child+1, :) = mother_2 + father_1; % 另一个孩子

   end % 染色体交叉结束

   

   % 染色体变异开始

   mutation_population = population(2:population_size, :); % 精英不参与变异

   number_of_elements = (population_size - 1) * number_of_variables; % 全部基因数目

   number_of_mutations = ceil(number_of_elements * mutation_rate); % 将要变异的基因数目

   mutation_points = ceil(number_of_elements * rand(1, number_of_mutations)); % 确定要变异的基因

   mutation_population(mutation_points) = rand(1, number_of_mutations); % 对选中的基因进行变异操作

   population(2:population_size, :) = mutation_population; % 发生变异之后的种群

   % 染色体变异结束

   

end % 演化循环结束