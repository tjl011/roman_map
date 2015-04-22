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
	
	def __init__(self, fileName, provinceName, coordList):
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
	
