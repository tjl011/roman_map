#!/usr/bin/python3.4

"""
Author: Thomas Ludwig (tjl011)
CSCI321 - Final project 
"""
import sys
import os.path as PATH
from bs4 import BeautifulSoup

PLIST_HEADER = '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">'
PLIST_HEADER2 = '<plist version="1.0">'

class PListGenerator:
	""" This class is used to create a provincial overlay resource
		file based on the parsing of its source kml file.
	"""
	
	def __init__(self, fileName, provinceName, coordList):
		""" Inputs:
				- fileName: desired output file name.
				- province Name: 'Official' name of Roman province
				- coordList: list of (latitude, longitude) tuples
		"""
		self.fileName = fileName
		self.provinceName = provinceName
		self.coordList = coordList
	
	def buildFile(self):
		f = open(self.fileName, "w")
		# Write file headers
		f.write(PLIST_HEADER)
		f.write("\n")
		f.write(PLIST_HEADER2)
		f.write("\n<dict>\n")
		
		# Write province name
		f.write("\t<key>province</key>\n")
		f.write("\t<string>{:s}</string>\n".format(self.provinceName))
		
		# TODO - ADD COLOR WRITING
		
		# write province coordinates
		f.write("\t<key>coordinates</key>\n")
		f.write("\t<array>\n")
		for cTup in self.coordList:
			# output: <string>{1.123,2.456}</string>
			sline = "\t\t<string>{{{:f},{:f}}}</string>\n".format(cTup[0],
				cTup[1])
			f.write(sline)
		
		f.write("\t</array>\n")
		f.write("</dict>\n</plist>")
		f.close()

class ProvinceListGenerator:
	""" This class is used to create a resource file that contains the 
		names of all the province *.plist files in the project.
	"""
	
	def __init__(self, fileName, mapName, kmlList):
		""" Inputs:
				- fileName: desired output file name.
				- mapName: Desired name of map
				- kmlList: list of kml file names (file extension
				 and paths removed)
		"""
		self.fileName = fileName
		self.mapName = mapName
		self.kmlList = kmlList
	
	def buildFile(self):
		f = open(self.fileName, "w")
		# Write file headers
		f.write(PLIST_HEADER)
		f.write("\n")
		f.write(PLIST_HEADER2)
		f.write("\n<dict>\n")
		
		# Write map name
		f.write("\t<key>name</key>\n")
		f.write("\t<string>{:s}</string>\n".format(self.mapName))
		
		# write provinces names
		f.write("\t<key>provinces</key>\n")
		f.write("\t<array>\n")
		for kml in self.kmlList:
			f.write("\t\t<string>{:s}</string>\n".format(kml))
			
		f.write("\t</array>\n")
		f.write("</dict>\n</plist>")
		f.close()
