//Starting values
xStart=150;
yStart=150;
dX=200;
dY=200;
xSpots=7;
ySpots=8;

xWidth=xStart+xSpots*dX;
yHeigth=yStart+ySpots*dY;
print(xWidth);
print(yHeigth);

requires("1.45s");
setOption("ExpandableArrays",true);
xCoordinates=newArray;
xCoordinates[0]=xStart;
xPrevious=xStart;
for (i=1;i<xSpots;i++){
	xNext=xPrevious+dX;
	xCoordinates[i]=xNext;
	xPrevious=xNext;
	}
Array.print(xCoordinates);

yCoordinates=newArray;
yCoordinates[0]=yStart;
yPrevious=yStart;
for (j=1;j<ySpots;j++){
	yNext=yPrevious+dY;
	yCoordinates[j]=yNext;
	yPrevious=yNext;
	}
Array.print(yCoordinates);

newImage("spotTest_simulated_area&grey", "8-bit white", xWidth, yHeigth, 1);
imageN=0;

pathfile=File.openDialog("Return txt file summarizing the spot area and grey score");

areaGrey=File.openAsString(pathfile);
rows=split(areaGrey, "\n");
print(rows[0]);
areaArray=newArray(rows.length);
grayArray=newArray(rows.length);
for(i=0; i<rows.length; i++){
	columns=split(rows[i],"\t");
	areaArray[i]=parseFloat(columns[1]);
	grayArray[i]=parseFloat(columns[2]);
}


Array.print(areaArray);
Array.print(grayArray);

Array.getStatistics(grayArray, min, max, mean, stdDev);
grayMin=min;
grayRange=max-grayMin;
print(grayRange);
//grayColor=getResult("Grey",imageN);
//setColor(grayColor);
//setColor(grayArray[imageN]);
//fillOval(xCoordinates[0], yCoordinates[0], 2*sqrt(areaArray[imageN]/PI), 2*sqrt(areaArray[imageN]/PI));
for (j=0;j<yCoordinates.length;j++){
	for (i=0;i<xCoordinates.length;i++){
		xCo=xCoordinates[i];
		yCo=yCoordinates[j];
		spotArea=areaArray[imageN];
		r=sqrt(spotArea/PI);
		setColor(255*(1-(grayArray[imageN]-grayMin)/grayRange));
		fillOval(xCo-r,yCo-r, 2*r, 2*r);
		imageN++;
	}
}
