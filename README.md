# Commen-trends
A method for selecting stocks in Diff-in-diff research to ensure common trends

# Commen-trends hypothesis
Diff-in-diff method is usually used to research what influence an event will have on a certain aspect of stocks, such as volatility, return and trading volume. To using this method, we need to set a treatment-group stocks which has been influenced by the event and a control-group stocks which hasn't been influenced by the event. And the two groups should satisfy the common-trends hypothesis--without the event, the trends change over time should be the same.

# Input
function commentrends(X,Y,varargin)
X--the stockcodes of the treatment-group stocks,it's a column vector
Y--the dependent variables which we wanna know how the event has influenced it. The first column is stockcodes and other column is the data organized by the time
varargin--the independent variables, organized like Y.

# methods
In order to keep their trends same, Harris and Bae proposed a method which controls some independent variables that influence the dependent variable we want to research. Through controlling the distance between the independent variable as close as possible, we will satisfy the hypothesis.

My program mainly belongs to 4 part. The first part and the second part are the data preparing parts. Since the data of stocks we get from the database always contain all stocks, so we need to deleting the unlisted stock during the event study period and fill missing values. Also more importantly, we need to separate the stocks into two groups, treatment group and the control pool group where control-group are going to be selected.

The third part calculate the distance between each treatment stock and each stock in the control pool so that every treatment stock will have a matching stock which has the smallest distance to it. But note that two or more treatment stocks may have the same matching stock. Then we have part 4 to deal with this situation. In this part, we keep that matching stock and rechosing for other treatment stocks. Finally, we can get the stockcodes in the control group.

# Drawbacks
Actually in part 3, when we calculating the distance matrix, we need to do a panel regression of dependent variable on the independent variables and using the coefficients to mutiply the corresponding distance(kinda like weighting sum). But the number of independent variables is up to the topic and theory. I didn't figure out how to deal with panel regrssion under this situation. So I just sum the distance.
