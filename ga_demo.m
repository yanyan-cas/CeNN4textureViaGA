clear; close all;



% 调用 my_ga 进行计算

[best_fitness, elite, generation] = my_ga(10, 'my_fitness', 100, 50, 0.1, 10000, 1.0e-6);



% 最佳适应度的演化情况

figure

loglog(1 : generation, best_fitness(1 : generation), 'linewidth',2)

xlabel('Generation','fontsize',15);

ylabel('Best Fitness','fontsize',15);

set(gca,'fontsize',15,'ticklength',get(gca,'ticklength')*2);



% 最优解的演化情况

figure

semilogx(1 : generation, 2 * elite(1 : generation, :) - 1)

xlabel('Generation','fontsize',15);

ylabel('Best Solution','fontsize',15);

set(gca,'fontsize',15,'ticklength',get(gca,'ticklength')*2);