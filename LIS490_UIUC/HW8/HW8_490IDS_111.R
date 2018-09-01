# HW 8 - Due Tuesday Nov 8, 2016 in moodle and hardcopy in class. 
# Upload R file to Moodle with filename: HW8_490IDS_YOURID.R
# Do not remove any of the comments. These are marked by #

### This assignment will use Google Earth for data display. 
### The .rda file is uploaded to Moodle.

### Load HW8.rda and attach the XML library

load('hw8.rda')
library(XML)
### Part 1.  Create the data frame
### Look at the instructions in HW8.pdf.
### Functions you'll want to use: xmlParse(), xmlRoot(), xpathSApply(), xmlGetAttr().
### It also might make it easier to use: xmlToList(), merge().


### Load the data frame called LatLon from HW8.rda.  

### Download the gzipped XML factbook document from
### http://jmatchparser.sourceforge.net/factbook/
### and create an XML "tree" in R 
Tree <- xmlParse("factbook.xml.gz")
Root <- xmlRoot(Tree)
### Use XPath to extract the infant mortality and the CIA country codes from the XML tree
###   
### Create a data frame called IM using this XML file.
### The data frame should have 2 columns: for Infant Mortality and CIA.Codes.
infant.mortality <-
  as.numeric(xpathSApply(Root,
              '//field[@name="Infant mortality rate"]/rank',
              xmlGetAttr,
              'number'))
CIA_infant <- xpathSApply(Root,
                         '//field[@name="Infant mortality rate"]/rank',
                         xmlGetAttr,
                         'country')

IM <- data.frame('Infant Mortality' = infant.mortality, 'CIA.Codes' = CIA_infant)

### Extract the country populations from the same XML document
### Create a data frame called Pop using these data.
### This data frame should also have 2 columns, for Population and CIA.Codes.

Population <-
  as.numeric(xpathSApply(Root,
              '//field[@name="Population"]/rank',
              xmlGetAttr,
              'number'))
CIA_pop <- xpathSApply(Root,
                          '//field[@name="Population"]/rank',
                          xmlGetAttr,
                          'country')
Pop <- data.frame('Population' = Population, 'CIA.Codes' = CIA_pop)

### Merge the two data frames to create a data frame called IMPop with 3 columns:
### IM, Pop, and CIA.Codes
IMPop <- merge(IM, Pop, by = 'CIA.Codes')
### Now merge IMPop with LatLon (from newLatLon.rda) to create a data frame called AllData that has 6 columns
### for Latitude, Longitude, CIA.Codes, Country Name, Population, and Infant Mortality
### (please check lat,long are not reversed in the file)
IMPop$CIA.Codes <- toupper(IMPop$CIA.Codes)
AllData <- merge(LatLon,IMPop, by = 'CIA.Codes')
### Part 2.  Create a KML document
### Make the KML document described in HW8.pdf.  It should have the basic
### structure shown in that document.  You can use the addPlacemark function below to make
### the Placemark nodes, you just need to complete the line for the Point node and
### figure out how to use the function.

makeBaseDocument = function(){
### This code creates the template KML document 
  doc = newXMLDoc()
  Root = newXMLNode('Document',doc = doc)
  newXMLNode('Name', 'Country Facts', parent = Root)
  newXMLNode('Description', 'Infant Motality', parent = Root)
  LookAt = newXMLNode('LookAt', parent = Root)
  newXMLNode('longitude','-121',parent = LookAt)
  newXMLNode('latitude','43',parent = LookAt)
  newXMLNode('altitude','4100000',parent = LookAt)
  newXMLNode('title','0',parent = LookAt)
  newXMLNode('heading','0',parent = LookAt)
  newXMLNode('altitudeMode','absolute',parent = LookAt)
  Folder = newXMLNode('Folder', parent = Root)
  
  return(doc)
}

addPlacemark = function(lat, lon, ctryCode, ctryName, pop, infM, parent, 
                        inf1, pop1, style = FALSE)
{
  pm = newXMLNode("Placemark", 
                  newXMLNode("name", ctryName), attrs = c(id = ctryCode), 
                  parent = parent)
  newXMLNode("description", paste(ctryName, "\n Population: ", pop, 
                                  "\n Infant Mortality: ", infM, sep =""),
             parent = pm)

  newXMLNode("Point",newXMLNode('coordinates',paste(lon,lat,sep = ",")),parent = pm)
             
### You need to fill in the code for making the Point node above, including coordinates.
### The line below won't work until you've run the code for the next section to set up
### the styles.

  if(style) newXMLNode("styleUrl", paste("#YOR", inf1, "-", pop1, sep = ''), parent = pm)
}

### Save your KML document here, call it Part2.kml, and open it in Google Earth.
### (You will need to install Google Earth.)  
### It should have pushpins for all the countries.
doc1 <- makeBaseDocument()
doc1.root <- xmlRoot(doc1)
for(i in 1:dim(AllData)[1]) {
  addPlacemark(
    lat = AllData[i, 3],
    lon = AllData[i, 4],
    ctryCode = AllData[i, 1],
    ctryName = AllData[i, 2],
    pop = AllData[i, 6],
    infM = AllData[i, 5],
    parent = doc1.root[['Folder']],
    inf1 = 0,
    pop1 = 0
  )
}
saveXML(doc1, file = "Part2.kml")
### Part 3.  Add Style to your KML
### Now you are going to make the visualizatiion a bit fancier.  Pretty much all the code is given to you
### below to create style elements that are to be placed near the top of the document.
### These , you just need to figure out what it all does.

### Start fresh with a new KML document, by calling makeBaseDocument()

doc2 = makeBaseDocument()

### The following code is an example of how to create cut points for 
### different categories of infant mortality and population size.
### Figure out what cut points you want to use and modify the code to create these 
### categories.
infCut = cut(AllData[,5], breaks = c(0, 10, 25, 38, 75, 200))
infCut = as.numeric(infCut)
popCut = cut(log(AllData[,6]), breaks = 5)
popCut = as.numeric(popCut)
# Create color Cut based on population number
color = c('blue','green','orange','red','yellow')
colCut = color[popCut]

### Now figure out how to add styles and placemarks to doc2
### You'll want to use the addPlacemark function with style = TRUE

### Below is code to make style nodes. 
### You should not need to do much to it.

### You do want to figure out what scales to you for the sizes of your circles

# Initialize scale (Proportional to population cutoff scale)
scales = c(1, 2.5, 5, 7.5, 9.5)


addStyle = function(col1, inf1, pop1, parent, urlBase, scale = scales)
{
  st = newXMLNode("Style", attrs = c("id" = paste("YOR", inf1, "-", pop1, sep =
                                                   "")), parent = parent)
  newXMLNode("IconStyle",
             newXMLNode("scale", scales[pop1]),
             newXMLNode(
               "Icon",
               paste(urlBase, "color_label_circle_", col1, ".png", sep = "")
             ),
             parent = st)
}

# Capture the root
doc2.root <- xmlRoot(doc2)
# Add placemarks for each country
for (i in 1:dim(AllData)[1]) {
  addStyle(colCut[i],
           infCut[i],
           popCut[i],
           doc2.root[['Folder']],
           'http://www.stanford.edu/~vcs/StatData/circles/')
  addPlacemark(
    lat = AllData[i, 3],
    lon = AllData[i, 4],
    ctryCode = AllData[i, 1],
    ctryName = AllData[i, 2],
    pop = AllData[i, 6],
    infM = AllData[i, 5],
    parent = doc2.root[['Folder']],
    inf1 = infCut[i],
    pop1 = popCut[i],
    style = TRUE
  )
}
# Save file
saveXML(doc2, file = "Part3.kml")
### You will need to figure out what order to call addStyle() and addPlacemark()
### so that the tree is built properly. You may need to adjust the code to call the png files

### Finally, save your KML document, call it Part3.kml and open it in Google Earth to 
### verify that it works.  For this assignment, you only need to submit your code, 
### nothing else.  You can assume that the grader has already loaded HW8.rda.

