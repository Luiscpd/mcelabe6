import os
import sys
import csv
dato =[]
nbinario = "01001"
number = 0
class binary_to_decimal():

	def converter_binary_to_decimal(self,binary):

		binary_to_decimal = binary
		decimal = 0

		for digit in binary:
			if digit == "0" or digit == "1": 
				decimal = decimal*2 + int(digit) 
				
		

			else:
				return "INVALID"
				break
	
		dato = [decimal]
		with open('datos.csv','a', newline='') as file:
			writer = csv.writer(file)
			writer.writerow(dato)
		return decimal

		
b_d = binary_to_decimal()
while number < 10:		
	print(b_d.converter_binary_to_decimal(nbinario))
			

