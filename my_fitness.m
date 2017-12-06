function y = my_fitness(population)

population = 2 * population - 1;

y = sum(population.^2, 2);
end