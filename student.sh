#!/bin/bash

filename="student.txt"

echo "student data management"
echo -e "1. Show All Records:\n2. Insert new Datas:\n3. Delete:\n4. Update:\n5. Exit:"

while true;do
	read -p "Enter your choice:" choice

	case "$choice" in
		1)
			echo "All Records:"
			cat "$filename"
			;;
		2)      read -p "Enter Roll Number:" roll
			
			if grep -q "^$roll" "$filename"; then
				echo -e "Student Record already exits\nChoose option 4 to update the record"
				continue
		        fi
			read -p "Enter your Name: " name
			read -p "Enter your Department: " dept
			read -p "Enter your SGPA: " sgpa
			echo "$roll | $name | $dept | $sgpa" >> "$filename"
			echo "New Student Record created with Roll Number $roll"
			;;
		3)
			read -p "Enter Roll Number:" roll

			if ! [[ "$roll" =~ ^[0-9]+$ ]]; then
				echo "Enter a valid number"
				continue
			fi
			if grep -q "^$roll" "$filename"; then
				grep -v "^$roll" "$filename" > temp.txt
				mv temp.txt "$filename"
				echo "Deleted successfully"
				cat "$filename"
			else
				echo "Not Present"
			fi
			;;
		4)
			read -p "Enter Roll Number:" roll
			
			if ! [[ "$roll" =~ ^[0-9]+$ ]]; then
				echo "Enter a valid number"
				continue
			fi
			if grep -q "^$roll" "$filename"; then
				read -p "Enter Your Name:" name
				read -p "Enter dept": dept
				read -p "Enter sgpa": sgpa
				sed -i "s/^$roll.*/$roll | $name | $dept | $sgpa/" "$filename"
				echo "Updated"
				cat "$filename"
			else
				echo "Not present"
			fi
			;;
		5)
			echo "Exiting..."
			exit
			;;
		*)
			echo "ENter a valid number:"
			;;
	esac
done
