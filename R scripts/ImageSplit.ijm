imgPath=getDirectory("Choose a Directory");
fileList=getFileList(imgPath);
imgList=newArray(0);
for (i=0;i<fileList.length;i=i+1){
	if(endsWith(fileList[i], ".tif")){
		imgList=Array.concat(imgList,fileList[i]);
	}
}

imgChoose=getNumber("prompt", 1);
//the number allows to select a specific .tif image within the folder
fileName=imgList[imgChoose];
print(fileName);
open(imgPath+fileName);

//Starting parameters, we have optimized the grid parameters for each individual picture, according to the relative position
//of the bacterial spots within each picture. This ensures that in each subimage exactly one bacterial spot is located.
if(imgChoose==1){
	//applies for the 2409 image
	xStart=94;
	yStart=130;
	xDiff=297;
	yDiff=204;
	saveFolder="2409";
	fileName_save="2409-t24_5%-";
}else{
	if(imgChoose==2){
		//applies for the 2509 image
		xStart=93;
		yStart=140;
		xDiff=298;
		yDiff=203;
		saveFolder="2509";
		fileName_save="2509-t24_5%-";
	}else{
		if(imgChoose==3){
			//applies for the 2609 image
			xStart=102;
			yStart=103;
			xDiff=291;
			yDiff=216;
			saveFolder="2609";
			fileName_save="2609-t24_5%-";
		}else{
			//applies for the 0110 image
			xStart=100;
			yStart=160;
			xDiff=280;
			yDiff=200;
			saveFolder="0110";
			fileName_save="0110-t24_5%-";
		}
	}
}

x0=xStart-xDiff/2;
if (x0<0){
	x0=0;
}

y0=yStart-yDiff/2;
if (y0<0){
	y0=0;
}

requires("1.45s");
setOption("ExpandableArrays",true);
xCoordinates=newArray;
xCoordinates[0]=x0;
xPrevious=x0;
for (i=1;i<7;i++){
	xNext=xPrevious+xDiff;
	if (xNext>getWidth()){
		xNext=getWidth();
	}
	xCoordinates[i]=xNext;
	xPrevious=xNext;
	}

yCoordinates=newArray;
yCoordinates[0]=y0;
yPrevious=y0;
for (j=1;j<8;j++){
	yNext=yPrevious+yDiff;
	if (yNext>getHeight()){
		yNext=getHeight();
	}
	yCoordinates[j]=yNext;
	yPrevious=yNext;
}

//Preparing the ROIs on top of the image
saveDirectory=imgPath+saveFolder+"\\";
imageExtension=".tif";
imageN=1;
for (j=0; j<yCoordinates.length;j++){
	for (i=0; i<xCoordinates.length;i++){
		open(imgPath+fileName);
		xCo=xCoordinates[i];
		yCo=yCoordinates[j];
		makeRectangle(xCo, yCo, xDiff, yDiff);
		run("Duplicate..."," ");
		stringImageN=""+imageN;
		print(saveDirectory+fileName_save+stringImageN+imageExtension);
		saveAs("Tiff",saveDirectory+fileName_save+stringImageN+imageExtension);
		imageN++;
		close();
		selectWindow(fileName);
		close();
	}
}
