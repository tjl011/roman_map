#!/usr/bin/python3.4

"""
@author Thomas Ludwig

Note: This module requires Python 3.2 or higher.
External libraries used: BeautifulSoup 4.x and lxml?

"""
import sys
import os.path as PATH
from bs4 import BeautifulSoup

_FILE_EXT = ".kml"
_FILE_EXT_LEN = len(_FILE_EXT)

class KMLProvinceParser:
	
	def __init__(self, filePath):
		""" 
		Initializes KMLProvinceParser
		inputs: 
			- filePath: path to a valid KML file (can be relative
						or absolute)
		"""
		
		self.__coordList = [] # list of latitutude, longitude tuples
		self.__kmlSoup = None
		
		# get data from file
		try:
			with open(filePath, 'r') as f:
				data = f.read()
				self.__kmlSoup = BeautifulSoup(data, ["xml", "lxml"])
			f.close()
		except Exception:
			# TODO - more strigent exception handling
			print("Failed to parse file {:s}".format(filePath))
			sys.exit(-1)
		
		self.__populateCoordList()
		self.outDir, self.name = PATH.split(filePath)
		if self.name == "":
			print("ERROR!")
			sys.exit(-1)
		self.name = self.name[:-_FILE_EXT_LEN]
	
	def __populateCoordList(self):
		coordGenerator = [s for s in self.__kmlSoup.Placemark.coordinates.stripped_strings]
		self.__coordList = coordGenerator[0].split()
		
		# generates 3-tuple: (latitude,longitude,0)
		for i in range(len(self.__coordList)):
			slist = [s for s in self.__coordList[i].split(',')]
			self.__coordList[i] = (float(slist[0]), float(slist[1]))
	
	def prettyPrint(self):
		print("name: {:s}".format(self.name))
		for ctup in self.__coordList:
			print("x: {:f} y: {:f}".format(ctup[0], ctup[1]))
	
# used to test parser
if __name__ == "__main__":
	kmlParser = KMLProvinceParser(sys.argv[1])
	kmlParser.prettyPrint()
	
		
