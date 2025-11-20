//opens individual spots and analyses the area of each individual spot
run("Close All");
run("Clear Results");

imgPath=getDirectory("Choose a Directory");
imgList=getFileList(imgPath);
dashSplit=split(imgList[0],"-");
commonFileName=dashSplit[0]+"-"+dashSplit[1];

for (i=0; i<imgList.length+1;i++){
	open(imgPath+"\\"+commonFileName+"-"+(i+1)+".tif");
	selectWindow(commonFileName+"-"+(i+1)+".tif");
	//Substracting background
	run("Subtract Background...", "rolling=500");
	run("8-bit");
	//Local tresholding using Otsu
	setThreshold(27, 255);
	setOption("BlackBackground", false);
	run("Convert to Mask");
	run("Fill Holes");
	//Counting the particles using a 100 square pixel treshold, to discard small pixels that are not considered bacteria
	run("Set Measurements...", "area redirect=None decimal=6");
	run("Analyze Particles...", "size=100-Infinity show=Outlines display clear summarize");
	selectWindow(commonFileName+"-"+(i+1)+".tif");
	close();
	selectWindow("Drawing of "+commonFileName+"-"+(i+1)+".tif");
	close();
}
	