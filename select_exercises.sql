# Exercises from https://ds.codeup.com/sql/basic-statements/

USE albums_db;

DESCRIBE albums;

# 3.a. 31 Rows in the albums table based on Table information

# 3.b. How many unique artist names in the albums table?
SELECT DISTINCT artist FROM albums; # Reveals 23 rows, so 23 unique artist names

# 3.c. What is the primary key for the albums table?
SHOW CREATE TABLE albums; # This reveals the primary key is 'id'. Also discovered via "Structure tab"

# 3.d. What are the oldest and most recent release dates among the albums?
# Sorting data by release date reveals the oldest album in the Table is the Beatles' "Sgt. Pepper's Lonely Hearts Club Band" and the most recent is Adele's "21"

# 4.a. Name of all albums by Pink Floyd:
SELECT name FROM albums WHERE  artist = "Pink Floyd";

# 4.b. Release year of "Sgt. Pepper's Lonely Hearts Club Band"
SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

# 4.c. Genre for the album Nevermind
SELECT genre FROM albums WHERE name = "Nevermind";

# 4.d. Which albums released in the 1990s
SELECT name FROM albums WHERE release_date BETWEEN '1990' and '1999';

# 4.e. Which albums had less than 20 million certified sales
SELECT name FROM albums WHERE sales < 20;

# 4.f. All albums with genre of "Rock"
SELECT name FROM albums WHERE genre = "Rock";
	# These results only include results that exactly match the genre "Rock"
	
# If we want results to include results such as Progressive or Hard Rock:
	SELECT name FROM albums WHERE genre LIKE "%Rock%";