#!/usr/bin/python3.4

"""
Author: Thomas Ludwig (tjl011)
CSCI321 - Final project 

This file iterates through all *.kml files in a given directory,
and outputs them as *.plist files in a user-specified directory.

"""
# standard modules
import sys
import glob
import os.path

# team-made modules
from KMLProvinceParser import KMLProvinceParser
import PListGenerator as PListGen

# Tom's directory paths
__IN_PATH = "/home/tom/ludwig_aydin_finalproject/dataset"
__OUT_PATH = "/home/tom/ludwig_aydin_finalproject/ios_dataset"
PLEN = len('.plist') # number of characters in file extension

LIST_OUTPUT_NAME = "province_list.plist" # file to keep track of all provinces

class Main:
	
	def __init__(self, inputDir, outputDir):
		self.inputDir = inputDir # directory containing kml files to parse
		self.outputDir = outputDir # directory to output files to
	
	def __getRawProvinceName(self, filePath):
		""" Helper to generate the raw plist file name.
		"""
		splitPath = os.path.split(filePath) # (head, tail)
		rawProvince = os.path.splitext(splitPath[1])[0]
		return rawProvince
	
	def __getProvinceName(self, filePath):
		""" Helper method to generate province name based on *.kml file
			path name (i.e. filePath).
		"""
		splitPath = os.path.split(filePath) # (head, tail)
		rawProvince = os.path.splitext(splitPath[1])[0]
		province = " ".join([s.capitalize() for s in rawProvince.split("_")])
		return province

	def __getPListName(self, filePath):
		""" Helper function to generate the *.plist resource file name
			given a *.kml file name.
		"""
		splitPath = os.path.split(filePath) # (head, tail)
		rawFileName = os.path.splitext(splitPath[1])[0]
		outFile = self.outputDir + "/" + rawFileName + ".plist"
		return outFile
	
	def __createProvinceList(self, kmlFileList, mapTitle):
		""" This method creates a *.plist resource file that contains
			an array of all the province names as kml files, i.e. 
			Moesia Superior --> moesia_superior.kml
			Inputs:
				- kmlFileList: list of *.kml files in a directory
				- mapTitle: Title of map used to create *.kml files.
		"""
		
	def run(self):
		inFileList = glob.glob(self.inputDir + "/*.kml")
		
		provinceList = [self.__getProvinceName(f) for f in inFileList]
		plistList = [self.__getPListName(f) for f in inFileList]
		provNameList = [self.__getRawProvinceName(f) for f in plistList]
		
		# Create file that keeps track of all the provinces
		outname = self.outputDir + '/' + LIST_OUTPUT_NAME
		overviewList = PListGen.ProvinceListGenerator(outname, 
		"Map under Reign of Trajan", provNameList)
		overviewList.buildFile()
						
		for i in range(len(inFileList)):
			print("Generating output for " + provinceList[i])
			
			kmlParser = KMLProvinceParser(inFileList[i])
			plistGen = PListGen.PListGenerator(plistList[i], provinceList[i],
				kmlParser.getCoordList())
			plistGen.buildFile()

if __name__ == "__main__":
	if len(sys.argv) < 3:
		print("Usage: python3 data_generator.py <path to kml> <output path>")
		sys.exit(1)
	else:
		print("building list...")
		m = Main(__IN_PATH, __OUT_PATH)
		m.run()


		
		

