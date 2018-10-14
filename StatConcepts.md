
1. **Probability**: the plausibility of a random outcome, given a model parameter value, without reference to any observed data.
2. **Likelihood**: he plausibility of a model parameter value, given specific observed data.
	- **Likelihood function**:a function of the parameters of a statistical model, given specific observed data

3. **Skewness**
	- Negatively skewed $\Leftrightarrow$ Left skewed $\Leftrightarrow$ tail on the left side
	- Positively skewed $\Leftrightarrow$ Right skewed $\Leftrightarrow$ tail on the right side
<center>
![Skewness](https://github.com/datamasterkfz/Statistics/graphs/raw/master/Skewness.png)
</center>

4. **Bessel's correction**: use $n-1$ instead of $n$ in the formula for calculation the sample variance and sample standard deviation. Yields larger estimation of sample variance/standard deviation.
	- **Intuition**: Because samples tend to be values in the middle of the population. Especially in a normal distribution, most of the values are centered  in the middle. Therefore the variability of the sample will be less than the variability of the entire sample. 
<center>
$s_n^2 = \frac{\sum_{i=1}^n (x_i-\bar x)^2}{n}\ \ \ \rightarrow s_{n-1}^2 = \frac{\sum_{i=1}^n (x_i-\bar x)^2}{n-1}$
</center>

5. **Type I and Type II error**
<center>
![TypeI_TypeII](https://github.com/datamasterkfz/Statistics/graphs/raw/master/TypeI_TypeII.png)
</center>

6. **Pearson and Spearman correlation**
	- Pearson correlation: measure the linear correlation between two variables
	- Spearman correlation: meansure how well the relationship between two variables can be described using a monotonic function
	
**Note**: The Spearman correlation between two variables is equal to the Person correlation between rank values of those two variables
<center>
![correlation]()
</center>

7. 

