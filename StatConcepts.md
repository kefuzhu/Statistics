**1. Probability**: the plausibility of a random outcome, given a model parameter value, without reference to any observed data.

**2. Likelihood**: he plausibility of a model parameter value, given specific observed data.

- **Likelihood function**:a function of the parameters of a statistical model, given specific observed data

**3. Cofficient of Variation**: a standard measure of dispersion of a probability distribution, calculated by the ratio of the standard deviation to the mean. **Larger value indicates the distribution is more spread out**

<center>
$CV = \frac{\sigma}{\mu}$
</center>

**4. Skewness**
	
- Negatively skewed $\Leftrightarrow$ Left skewed $\Leftrightarrow$ tail on the left side
- Positively skewed $\Leftrightarrow$ Right skewed $\Leftrightarrow$ tail on the right side

<p align="center">
	<img src="https://github.com/kefuzhu/Statistics/raw/master/graphs/Skewness.png">
</p>


**5. Bessel's correction**: use $n-1$ instead of $n$ in the formula for calculation the sample variance and sample standard deviation. Yields larger estimation of sample variance/standard deviation.

- **Intuition**: Because samples tend to be values in the middle of the population. Especially in a normal distribution, most of the values are centered  in the middle. Therefore the variability of the sample will be less than the variability of the entire population. 
<center>
$s_n^2 = \frac{\sum_{i=1}^n (x_i-\bar x)^2}{n}\ \ \ \rightarrow s_{n-1}^2 = \frac{\sum_{i=1}^n (x_i-\bar x)^2}{n-1}$
</center>

**6. Type I and Type II error**

<p align="center">
	<img src="https://github.com/kefuzhu/Statistics/raw/master/graphs/TypeI_TypeII.png">
</p>

**7. Pearson and Spearman correlation**

- Pearson correlation: measure the linear correlation between two variables
- Spearman correlation: meansure how well the relationship between two variables can be described using a monotonic function
	
**Note**: The Spearman correlation between two variables is equal to the Person correlation between rank values of those two variables

![correlation](https://github.com/kefuzhu/Statistics/raw/master/graphs/correlation_1.png)![correlation](https://github.com/kefuzhu/Statistics/raw/master/graphs/correlation_3.png)

<p align="center">
	<img src="https://github.com/kefuzhu/Statistics/raw/master/graphs/correlation_2.png">
</p>

**8. Confidence Interval**: 

- **Median**: ($\frac{n}{2} - z^{*}\frac{\sqrt{n}}{2}\ th\ ranked\ value,1 + \frac{n}{2} + z^{*}\frac{\sqrt{n}}{2}\ th\ ranked\ value$)

<p align="center">
	<img src="https://github.com/kefuzhu/Statistics/raw/master/graphs/confidence_interval_median.png">
</p>

- **Mean**: 
	- Known variance: ( $\overline{x} - z^{*}\frac{\sigma}{\sqrt{n}},\ \overline{x} + z^{*}\frac{\sigma}{\sqrt{n}}$)
	- Unknown variance: ( $\overline{x} - t^{*}\frac{s}{\sqrt{n}},\ \overline{x} + t^{*}\frac{s}{\sqrt{n}}$)

**9. MSE (Mean Squared Error)**: assesses the quality of an estimator. Values close to zero are better. 

<center>
$MSE = \frac{1}{n} \sum_{i=1}^n (Y_i - \hat{Y_i})^2$
</center>

**But extremely small MSE may indicate an overfitting of a model. The MSE will usually drop after certain complexity of a model. Adding more complexity is not desirable. See an example graph for different degree of polynomial regression**

<p align="center">
	<img src="https://github.com/kefuzhu/Statistics/raw/master/graphs/MSE.png">
</p>

