import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier 

#load in the iris data set into dictionary object
iris = load_iris()

#Uncomment bellow for some info or visualization 
#print(iris.key()) 	#keys
#print(iris)		#data set
#print(iris["DESCR"])	#statistics and description 
#print(iris.data.T)	#transpose into lists of feature entries 

#from printing all the data the species encoded via a 
#'0' target is a setosa, '1' is a versicolor, and '2' is a verginica.
#
#The other values are the descriptors of the data of iris flowers.
#the origin of this data is found here: https://en.wikipedia.org/wiki/Iris_flower_data_set

features = iris.data.T #sepal length, sepal width, petal length, petal width
sepal_l = features[0]
sepal_w = features[1]
petal_l = features[2]
petal_w = features[3]

sepalLabelL = iris.feature_names[0]
sepalLabelW = iris.feature_names[1]
petalLabelL = iris.feature_names[2]
petalLabelW = iris.feature_names[3]

plt.scatter(sepal_l, sepal_w, c=iris.target)	#the different color represents each species 
plt.title('Sepal Length Vs Sepal Width')
plt.xlabel(sepalLabelL)
plt.ylabel(sepalLabelW)
plt.show()

plt.scatter(petal_l, sepal_l, c=iris.target)
plt.title('Sepal Length Vs Petal Length')
plt.xlabel(petalLabelL)
plt.ylabel(sepalLabelL)
plt.show()

#classifier train and test data 
XTrain, XTest, yTrain, yTest = train_test_split(iris['data'], iris['target'], random_state=0)
knn = KNeighborsClassifier(n_neighbors = 2)

#fit the data to obtain a model
knn.fit(XTrain, yTrain)

#Testing the model and predicting a new piece of data
#sepalL sepalW petalL petalW 
Xnew = np.array([[5, 2.9, 1, .2]])
predict = knn.predict(Xnew)

print('\n')
print(predict)

#how accurate is that prediction?
print(knn.score(XTest, yTest)) #%accuracy 0->1

print('\n')

print('\n')
print('\n ended \n')
