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

def __interpretKMLColor(colorStr):
	""" This helper function takes as input the <color>...</color>
		line as input and converts the hexadecimal representation of
		alpha, blue, green, red (aabbggrr) into floating point numbers
		between 0.0 and 1.0, (which is one way which UIColor is instantiated.
	"""
	pass

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
	
	# TODO - ADD COLOR GRABBER
	
	
	def __populateCoordList(self):
		""" Helper method used to populate the coordList with a list of
			tuples in the form (lat, long) as floats.
		"""
		coordGenerator = [s for s in self.__kmlSoup.Placemark.coordinates.stripped_strings]
		self.__coordList = coordGenerator[0].split()
		
		# generates 3-tuple: (longitude, latitude,0)
		for i in range(len(self.__coordList)):
			slist = [s for s in self.__coordList[i].split(',')]
			# line below switched due to KML format, want (lat, long)
			self.__coordList[i] = (float(slist[1]), float(slist[0]))
	
	def getCoordList(self):
		""" Getter method for object attribute __coordList.
		"""
		return self.__coordList
	
	def prettyPrint(self):
		""" Debugging purposes only. This method prints out a formatted
			representation of the latitude, longititude coordinates 
			of each point parsed by BeautifulSoup.
		"""
		print("name: {:s}".format(self.name))
		for ctup in self.__coordList:
			print("x: {:f} y: {:f}".format(ctup[0], ctup[1]))
	
# used to test parser
if __name__ == "__main__":
	kmlParser = KMLProvinceParser(sys.argv[1])
	kmlParser.prettyPrint()
	
		
