### Beta regression exploration
**Introduction**

This Shiny application is a simple program to explore [Beta distributions](http://en.wikipedia.org/wiki/Beta_distribution). This family of continuous distribution is defined on the interval [0,1] and controlled by two parameters. It is thus useful to describe a random variable limited to a given interval (for instance a percentage of success in a series of trials). 

In order to model such a variable, beta regression may be used with for instance with the [**betareg** R package](http://cran.r-project.org/web/packages/betareg/vignettes/betareg.pdf). Note that this package uses an alternative parametrization of the distribution. Instead of the two shapes parameters a mean and dispersion parameter are used (see [this link](http://cran.r-project.org/web/packages/betareg/vignettes/betareg.pdf))

**Application structure**

The application essentially does two things:

1. It simulates a beta distribution sample with parameters input by the user;
2. It calculates an estimate of these parameters *via* the betareg function.

The distribution is shown on the "Plot" tab, with the theoretical density function in red and the estimated one in green. A summary of the distribution and the estimates of each parameters is also shown. The user may choose the standard or the alternative parametrization (in the standard parametrization, the values of the alternative parameters is automatically calculated, and vice-versa).

**User Manual**

Use of the application is very straightforward. The distribution and density function can be seen in the "Plot" tab. The user may choose the value of the parameters and the number of samples by playing with the sliders. When the standard parametrization is chosen, the parameters "mu" and "phi" are automatically calculated and changing there value in the slider does nothing. The reverse is true if the alternative parametrization is chosen.

*Made by RaphT in Feb 2015 for Johns Hopkins "Developping Data Products" course on [Coursera](http://www.coursera.org/course/devdataprod)*.

.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~ 