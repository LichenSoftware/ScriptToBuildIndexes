# ScriptToBuildIndexes
SQL script to generate sql statements to build indexes

This script returns a list of top 100 most fragmented database indexes ordered by most fragmented to least fragmented.  Of the fields returned you can append the 'altstart', 'name', and 'altend' fields together for each row to give you the script to rebuild the index for that table.

Giving you a script like this 'ALTER INDEX ALL ON 	[Table Name]	 REBUILD ;' for each index

This script would be useful if you were writing code to find and fix indexes.
