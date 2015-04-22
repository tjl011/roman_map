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
from PListGenerator import PListGenerator

# Tom's directory paths
__IN_PATH = "/home/tom/ludwig_aydin_finalproject/dataset"
__OUT_PATH = "/home/tom/ludwig_aydin_finalproject/ios_dataset"

class Main:
	
	def __init__(self, inputDir, outputDir):
		self.inputDir = inputDir # directory containing kml files to parse
		self.outputDir = outputDir # directory to output files to
		
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
		
	def run(self):
		inFileList = glob.glob(self.inputDir + "/*.kml")
		
		for f in inFileList:
			province = self.__getProvinceName(f)
			plistName = self.__getPListName(f)
			print("Generating output for " + province)
			
			kmlParser = KMLProvinceParser(f)
			plistGen = PListGenerator(plistName, province, kmlParser.getCoordList())
			plistGen.buildFile()

if __name__ == "__main__":
	if len(sys.argv) < 3:
		print("Usage: python3 data_generator.py <path to kml> <output path>")
		sys.exit(1)
	else:
		print("building list...")
		m = Main(__IN_PATH, __OUT_PATH)
		m.run()


		
		

