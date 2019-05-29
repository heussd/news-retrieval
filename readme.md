# Newsboat Docker

RSS feed retrieval with [Newsboat](https://github.com/newsboat/newsboat), utilizing [fivefilter's Full Text Feed](https://github.com/heussd/fivefilters-full-text-rss-docker). Addresses some minor quirks. 


## Important files

### urls
Text file of feed to retrieve. Call the script `fulltextfeed` for full text retrieval via [fivefilter's Full Text Feed](https://github.com/heussd/fivefilters-full-text-rss-docker):

	# Regular RSS feed
	https://boerse.ard.de/index~rss.xml
	
	# Full text feed retrieval with fivefilters
	"exec:~/fulltextfeed https://www.tagesschau.de/xml/rss2" mainstream



### news.db
SQLite database file to store feeds in. 



## Usage

	docker-compose up