Unzip the 'data.zip' and put all the matlab matrix into the current working folder.

Open testImage.m, input the address of the image. 

The output of the function is a vector "pred" with 14 elements. Each element represents one class. 1 means that the image has the corresponding food, -1 means the image doesn't have the corresponding food.

Example:
pred = [-1 -1 -1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1] means that the image is 'burger' image.

class            colomn
'apple':          1
'banana'          2
'broccoli'        3
'burger'          4
'cookie'          5
'egg'             6
'frenchfry'       7
'hotdog'          8
'pasta'           9
'pizza'           10
'rice'            11
'salad'           12
'strawberry'      13
'tomato'          14