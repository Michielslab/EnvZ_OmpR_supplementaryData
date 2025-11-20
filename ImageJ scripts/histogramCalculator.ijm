//opens individual spots and analyses the mean pixel intensity of each individual bacterial spot (which is related to the whiteness of the bacterial spot)
run("Close All");
run("Clear Results");

imgPath=getDirectory("Choose a Directory");
imgList=getFileList(imgPath);
dashSplit=split(imgList[0],"-");
commonFileName=dashSplit[0]+"-"+dashSplit[1];

for (i=0; i<imgList.length+1; i++){
	open(imgPath+"\\"+commonFileName+"-"+(i+1)+".tif");
	run("Subtract Background...", "rolling=1000");
	getStatistics(area, mean, min, max, std, histogram);
	print(mean);
	selectWindow(commonFileName+"-"+(i+1)+".tif");
	close();
}