#!/bin/bash
#create local variable called "file" to carry database file name
file=phonebooklist.txt
# local variable to use in loops
i=0
#check if file is not exist
if ! [ -f "$file" ]; then  #will enter the condition if file not exist 
	#create the file 
    touch phonebooklist.txt
#end if	
fi
#function to show all available options than can be run with our  
viewMenu()
{
	# Print script options
	echo "-i to add new phone contact" 
	echo "-v to view all contacts"
	echo "-s to search for phone record"
	echo "-e to delete all phone contacts"
	echo "-d to delete one contact"
}

#function to take input from terminal and save it in the file
add()
{
	#print message to inform user with the option functionality 
	echo "Create a new Record"
	
	#print message to help user know what should be entered
	#then takes the input in variable FirstName
	read -p "Enter First Name: " FirstName
	if [ -z $FirstName ] ; then
		echo "Input Error: First Name cannot be empty ."
		echo " The valid format is  : First Name  Last Name  Phone Number and non of them can be empty."
		exit 0
	fi
	#print message to help user know what should be entered
	#then takes the input in variable LastName
	read -p "Enter Last Name: " LastName
	
	#print message to help user know what should be entered
	#then takes the input in variable PhoneNumber
	read -p "Enter phone number: " PhoneNumber
	
	#push the 3 values first name, last name and phone number in the file
	echo $FirstName $LastName $PhoneNumber >> $file
}

#function to look for contact
search()
{
	#print message to inform user with the option functionality 
	echo "Search for contact"
	
	#print message to help user know what should be entered
	#then takes the input in variable "search" 
	read -p "Enter First or Last Name or phone number : " search
	
	if [ -z $search ] ; then
		echo "invalid format."
		exit 0
	fi
	#using grep command to search in the file 
	#search for the "search" varaible content in the "file" that holds file name
	#return the grep value to be stored in varaible "found"
	found=$(grep $search $file)
	
	#-z => string is null, that is, has zero length
	#check if the varaible "found" is null  
	if  [ -z "$found" ] ;then #found is null
		
		#print that no item found
		echo "No Item found"
	
	#otherwise if the found is not null
	else 
		
		#read found line by line 
		cat found | while read -r line ; do
			
			# count line number
			i=$[ $i +1 ]
			
			# line number and line content 
			echo "$i $line"
		done
	fi
}

#function to view all contacts
viewAll()
{
	#print message to inform user with the option functionality 
	echo "Viewing all contacts list"
	
	#read file line by line 
	cat $file | while read line ; do
	
		#count line index number
		i=$[ $i +1 ]
		
		#print line index and  line contents
    	echo "$i $line"
	done
}

#function to delete all contacts
deleteAll()
{
	#print message to inform user with the option functionality 
	echo "Delete all contacts"
	 
	 #override on the file to clear its content 
	 > $file
}

#define to delete specific contact
deleteContact()
{
	#print message to inform user with the option functionality 
	echo "Search a Record"
	
	#print message to help user know what should be entered
	#then takes the input in variable search
	read -p "Enter First or last Name or phone number of the record you wanna delete : " search
	if [ -z $search ] ; then
		echo "invalid format."
		exit 0
	fi
	#using grep command to search in the file 
	#search for the "search" varaible content in the "file" that holds file name
	#return the grep value to be stored in varaible "found"
	found=$(grep $search $file)
	
	#-z => string is null, that is, has zero length
	#check if the varaible "found" is null  
	if  [ -z "$found" ] ;then #found is null
		
		#print that no item found
		echo "No Item found"
	
	#otherwise if the found is not null
	else 
		
		#read found line by line 
		grep $search $file | while read -r line ; do
			
			# count line number
			i=$[ $i +1 ]
			
			# line number and line content 
			echo "$i $line"
	done
	
	#print message to help user know what should be entered
	#then takes the input in variable deleteNo
	read -p "Enter index of the line  you wanna delete: " deleteNo
	
	#local variable to store line index 
	i=0
	
	#read found line by line 
	grep $search $file | while read -r line ; do
	
		# count line number
		i=$[ $i +1 ]
		
		#check if the line index is the index of the element to be deleted 
		if [ $deleteNo -eq $i ] ;then
		
			# delete the line and update the file
			echo "`sed  /"$line"/d  database.txt`" > $file
		fi
	done
	
	fi
}

#if the user run the script without choosing any option
if [ $# == 1 ] || [ $# == 0 ] ; then
	if [ -z $1 ] ; then
		viewMenu
	# -i => inserting new contacts
	elif [ $1 == "-i" ] ;then
		echo "entered if condtion"
		add
	# -s =>  searching for contact(s)
	elif [ $1 == "-s" ] ;then
		search
	# -v => view all option
	elif [ $1 == "-v" ] ;then
		viewAll
	# -e => delete all option
	elif [ $1 == "-e" ] ;then
		deleteAll
	# -d => delete contact
	elif [ $1 == "-d" ] ; then
		deleteContact

	else 
		echo "Not valid prompt input."
		echo " You can enter : "
		viewMenu
	fi
else 
	echo "Too many arguments. expected only one argument of these menu"
	viewMenu
fi 























