Teget Aydin
Thomas Ludwig

CSCI 321 Final project - Interactive Map of Ancient Roman Empire

iOS Project Requirements:
	* CoreData Framework
	* MapKit Framework


Project Directory structure:
	* tom-teget-final-project: Xcode project

	* dataset: Contains data used to generate the project. 
		Generally speaking, this data is stored as .kml files (XML-based file that contains latitude, longitude coordinates for data points). As of right now, these KML files delineate each Roman province, but we have not found a good way to incorporate these 		files directly into our app. Instead, we use a python script to parse the KML files into .plist files, which our app can easily parse. 

	* utilities: Contains helper scripts that are not used directly by our application, but are used to generate data our app can use.