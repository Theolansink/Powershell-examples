# script that uses file new-accounts.csv as input
# script creates file AD-usernames.csv as output
# inputfile has just one column: name.
# Example names are John Breskens and Dirk van de Pol.
# The Outputfile had three columns: firstname, lastname and samaccountname.
# Examples are john,breskens,jbreskens and dirk,pol,dpol

# create array $names with first line "firstname, lastname, samaccountname"
$names=@("firstname," + "lastname," + "samaccountname")

# read from file new-accounts.csv (comma separated file) in current directory
# the ` at the end of the line means: extend the line
import-csv .\new-accounts.csv | `

# for each line
foreach-object { 

  # convert name to just first and lastname
  # a name like Dirk van de Pol has to be converted to Dirk Pol

  $name = $_.naam -replace('\s[a-zA-Z]+\s', ' ')

  # concert characters in name to lowercase
  $name = $name.ToLower()

  # write contents variable $name to the screen
  Write-Output $name;

  # split string name in firstname and lastname
  $firstname,$lastname = $name.split(" ", 2)

  

  # set samaccountname (firstcharacter firstname + lastname)
  $samaccountname=$firstname.Substring(0,1)+$lastname

  # add firstname, lastname, samaccountname to array $names
  $names+=$firstname + "," + $lastname + "," + $samaccountname
} 
    

 # write result (in array $names) to outputfile (comma separated file)
 Out-file .\formatted-accountnames.csv -inputobject $names -force