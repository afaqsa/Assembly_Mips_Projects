.data
	MainHeading:.asciiz "\n\n\t\t\t\t---------------------------------------------------- \n\t\t\t\t\t\tExamination System \n\t\t\t\t----------------------------------------------------\n"
 
	#///////// user Options  ///////////////////
	options: .asciiz "\nPress 1: For Insert Student's Data \nPress 2 For Insert teacher's data: \nPress 3 for Seach students data: \nPress 4 to Seach Teachers data:  \nPress 5 for Display students data: \nPress 6 for Display Teacher's data: \nPress 7 for Delete Student data: \nPress 8 for Delete Teacher data:\nPress 9 for Exit \nEnter Your choise: "
	invalid: .asciiz "\nYou Entered Wrong Option Please Enter again:"
	
	#///////////////////// Students Deatils ////////////////////
	S_heading: .asciiz "\n\n\t\t\t\t---------------------------------------------------- \n\t\t\t\t\t\t\tStudent's Details \n\t\t\t\t----------------------------------------------------\n"
	Search_heading:.asciiz "\n\n\t\t\t\t---------------------------------------------------- \n\t\t\t\t\t\t\tSearch Details \n\t\t\t\t----------------------------------------------------\n"
	Delete_heading:.asciiz "\n\n\t\t\t\t---------------------------------------------------- \n\t\t\t\t\t\t\tDelete Details \n\t\t\t\t----------------------------------------------------\n"
	Show_heading:.asciiz "\n\n\t\t\t\t---------------------------------------------------- \n\t\t\t\t\t\t\tShow Details \n\t\t\t\t----------------------------------------------------\n"

	Firstame: .asciiz "\nEnter First Name :: "
	lastName: .asciiz "\nEnter Last Name :: "
	Roll_no: .asciiz "\nEnter Roll No :: "
	Dept: .asciiz "\nEnter Department :: "
	Room: .asciiz "\nEnter Room NO :: "
	
	fname_is: .asciiz "\n First Name :: "
	lname_is: .asciiz "\n Last Name :: "
	rollno_is: .asciiz "\n Roll No :: "
	dept_is: .asciiz "\n Department :: "
	room_is: .asciiz "\n Room NO :: "

	H_fname: .asciiz " First Name \t\t |"
	H_lname: .asciiz " Last Name \t\t |"
	H_rollno: .asciiz " Roll No \t\t |"
	H_dept: .asciiz " Department \t\t |"
	H_room: .asciiz " Room NO \t\t |\n"
	
	T_heading: .asciiz "\n\n\t\t\t\t---------------------------------------------------- \n\t\t\t\t\tTeacher's Details \n\t\t\t\t----------------------------------------------------\n"
	NoOF_S: .asciiz "\nHow many students you want to enter :: "
	dataOf_S: .asciiz"\n Enter the data of Student :: "
	NoOF_T: .asciiz "\nHow many Teachers you want to enter :: "
	dataOf_T:.asciiz"\n Enter the data of Teacher :: "
	F_name: .space 20
	L_name: .space 20
	rollno: .space 20
	room: .space 10
	dept: .space 20
	
	studentFile: .asciiz "F:/Assembly_Project/student.txt"
	teacherFile: .asciiz "F:/Assembly_Project/teacher.txt"
	
	studentInfo: .space 400000
	teacherInfo: .space 400000

	search: .asciiz "\nEnter the Roll/id no :: "
	FindRoll:.space 20
	Notpresent: .asciiz "\nData Not Found :: \n"
	deletedSucc: .asciiz "\nDeleted Successfuly :: \n"
	tabs: .asciiz " \t\t |"
	line: .asciiz " --------------------------------------------------------------------------------------------------------\n"
.text
	li $t4, 0
	li $s7, 0
	la $s0, studentInfo
	la $s4, teacherInfo
	#li $s1, 0 # lenght counter for studens
	#li $s2, 0, #lenght counter for teachers
	la $a0, studentFile # file name loading
	jal openForRead
	la $a1, studentInfo
	jal read
	la $t2, studentInfo
	jal countLenght
	add $s0, $s0,$t4
	
	li $t4, 0
	la $a0, teacherFile # file name loading
	jal openForRead
	la $a1, teacherInfo
	jal read
	la $t2, teacherInfo
	jal countLenght
	add $s4, $s4,$t4
	

main:
# printing options
 	la $a0, MainHeading
 	li $v0, 4
 	syscall
	la $a0, options
	li $v0, 4
	syscall 
	
	li $v0, 5 # taking users inputs
	syscall
	
	beq $v0, 1, E_S_Data
	beq $v0, 2, E_T_Data
	beq $v0, 3, S_Searching
	beq $v0, 4, T_Searching
	beq $v0, 5, S_Show
	beq $v0, 6, T_Show
	beq $v0, 7, S_Delete
	beq $v0, 8, T_Delete
	beq $v0, 9, Exit
	
	li $v0, 4
	la $a0, invalid
	syscall
	j main
Exit:
	li $v0, 10
	syscall
#////////////////////// NoOF_S Students data ////////////////
E_S_Data:
	la $a0, S_heading
	li $v0, 4
	syscall
	
	la $a0,NoOF_S
	li $v0, 4
	syscall 
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	li $t1, 1
	la $t2, studentInfo
	li $t4, 0
	jal countLenght
	la $s0, studentInfo
	add $s0, $s0, $t4
	j loop
	
nextStudent:
	add $t1, $t1, 1
	
loop:
	bgt $t1, $t0, S_DataInFile
	la $a0, dataOf_S
	li $v0, 4
	syscall
	li $v0, 1
	move $a0,$t1
	syscall
	jal input_data
	jal arrange_S_Data
	#jal cleardata
	
	j nextStudent
S_DataInFile:
	la $a0, studentFile # loading file name
	jal openFile
	la $a1,studentInfo
	jal InsertData
	j main
	
#/////////////////NoOF_S Teachers data /////////////////////////
E_T_Data:

	la $a0, T_heading
	li $v0, 4
	syscall
	
	la $a0,NoOF_T
	li $v0, 4
	syscall 
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	li $t1, 1
	la $t2, teacherInfo
	li $t4, 0
	jal countLenght
	la $s1, teacherInfo
	add $s1, $s1, $t4
	j loop1
	
nextTeacher:
	add $t1, $t1, 1
	
loop1:
	bgt $t1, $t0, T_DataInFile
	la $a0, dataOf_T
	li $v0, 4
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	
	jal input_data
	jal arrange_T_Data
	#jal cleardata
	
	j nextTeacher
T_DataInFile:
	la $a0, teacherFile # loading file name
	jal openFile
	la $a1,teacherInfo
	jal InsertData
	j main
	
#//////////////////////////////////////////////
input_data:
	li $v0, 4
	la $a0,Firstame
	syscall
	
	li $v0, 8
	la $a0, F_name
	li $a1, 20
	syscall
	
	li $v0, 4
	la $a0,lastName
	syscall
	
	li $v0, 8
	la $a0, L_name
	li $a1, 20
	syscall
	
	li $v0, 4
	la $a0,Roll_no
	syscall
	
	li $v0, 8
	la $a0, rollno
	li $a1, 20
	syscall
	
	li $v0, 4
	la $a0,Dept
	syscall
	
	li $v0, 8
	la $a0, dept
	li $a1, 20
	syscall

	li $v0, 4
	la $a0,Room
	syscall
	
	li $v0, 8
	la $a0, room
	li $a1, 20
	syscall	
	
	jr $ra	

arrange_S_Data:
	sub $sp, $sp ,4
	sw, $ra, ($sp)
	la $t2, rollno
	jal Store
	la $t2, F_name
	jal Store
	la $t2, L_name
	jal Store
	la $t2, dept
	jal Store
	la $t2, room
	jal Store
	li $t3,'\n'
	
	sb $t3, ($s0)
	addi $s0, $s0, 1
	lw $ra, ($sp)
	add $sp, $sp, 4
	jr $ra

increment:
	beq $t3,' ',return
 	sb $t3, ($s0)
	addi $t2, $t2, 1
	addi $s0, $s0, 1
Store:
	lb $t3, ($t2)
	bne $t3,'\n',increment
return:	
	li $t3, ' '
	sb $t3, ($s0)
	addi $s0, $s0, 1
	jr $ra
#////////////////////////////////////////////////
arrange_T_Data:
	sub $sp, $sp ,4
	sw, $ra, ($sp)
	la $t2, rollno
	jal Store1
	la $t2, F_name
	jal Store1
	la $t2, L_name
	jal Store1
	la $t2, dept
	jal Store1
	la $t2, room
	jal Store1
	li $t3,'\n'
	
	sb $t3, ($s4)
	addi $s4, $s4, 1
	lw $ra, ($sp)
	add $sp, $sp, 4
	jr $ra

increment1:
	beq $t3,' ',return1
 	sb $t3, ($s4)
	addi $t2, $t2, 1
	addi $s4, $s4, 1
Store1:
	lb $t3, ($t2)
	bne $t3,'\n',increment1
return1:	
	li $t3, ' '
	sb $t3, ($s4)
	addi $s4, $s4, 1
	jr $ra
openFile:
	li $v0, 13 # open file
	#la $a0, filename # loading file name
	li $a1, 1 # mode of writing in file 
	syscall

	move $s3, $v0 # file descriptor
	jr $ra
InsertData:
	li $v0, 15 # write in file
	move $a0, $s3 #file descriptor
	#la $a1,fileword  # word u want to print
	li $a2, 400000 # size of word
	syscall
	
	j closefile
openForRead:
	li $v0, 13 # open file
	#la $a0, filename # file name loading
	li $a1, 0 # reading file
	syscall
	move $s3, $v0 # file descriptor
	jr $ra
read:
	li $v0, 14 # read from file
	move $a0, $s3 # file descriptor
	#la $a1, fileword # buffer holding string of whole file
	li $a2, 400000 # size of buffer
	syscall
closefile:	
	li $v0, 16 # close file
	move $a0, $s3
	syscall
	jr $ra
lenght:
	add $t2, $t2,1
	add $t4, $t4, 1
countLenght:
	lb $t3, ($t2)
	bne $t3,'\0',lenght
	jr $ra
searching:
	

	sub $sp, $sp, 4
	sw  $ra,($sp)
	
	la $a0, search
	li $v0, 4
	syscall
	
	li $v0, 8
	la $a0, FindRoll
	li $a1, 20
	syscall
	move $t2, $a0
	li $t4, 0
	jal countLenght
	sub $t4, $t4,1
	move $t7, $t4
	
	li $s7, 0
	la $t3, FindRoll
	lw $ra, ($sp)
	add $sp, $sp,4
	jr $ra
T_Searching:
	la $a0, Search_heading
	li $v0, 4
	syscall
	jal searching
	la $t2, teacherInfo
	j file
S_Searching:
	la $a0, Search_heading
	li $v0, 4
	syscall
	jal searching
	la $t2, studentInfo
	j file
file:
	move $s1,$t2
	#li $t0, 0 
	jal find
	beq $t0, 1 , PrintData
	
	la $a0, Notpresent
	li $v0, 4
	syscall
	j main
	
row_inc:
	add $t2, $t2, 1	
	la $t3, FindRoll
	
	move $t7, $t4
	add $s7, $s7, 1
find:
	lb $t8, ($t2)
	lb $t5, ($t3)
	move $t6, $t2
	beq $t8, '\0', notFound
	beq $t8, $t5,col_inc
	j row_inc
col_inc:
	sub $t7, $t7,1
	add $t3, $t3, 1
	add $t6, $t6, 1
checkRollNo:
	ble $t7, 0, found
	lb $t8, ($t3)
	lb $t5, ($t6)
	beq $t5, $t8, col_inc
	j row_inc
found:
 	li $t0, 1
 	jr $ra
	#j PrintData
notFound:
	li $t0, 0
	jr $ra

PrintData:
	add $s1, $s1, $s7
	
	la $a0,rollno_is
	li $v0, 4
	syscall
	
	jal printing
	la $a0,fname_is
	li $v0, 4
	syscall
	
	jal printing
	
	la $a0,lname_is
	li $v0, 4
	syscall
	
	jal printing
	
	
	
	la $a0,dept_is
	li $v0, 4
	syscall
	
	jal printing
	
	la $a0,room_is
	li $v0, 4
	syscall
	
	jal printing
	
	j main
incr:
	add $s1, $s1,1
printing:
	
	lb $t3, ($s1)
	li $v0, 11
	move $a0, $t3
	syscall
	beq $t3, '\n', main
	bne $t3,' ', incr
	add $s1, $s1,1
	jr $ra
L_lenght:
	add $t2, $t2,1
	add $t4, $t4, 1
linelenght:
	lb $t3, ($t2)
	bne $t3,'\n',L_lenght
	jr $ra
S_Delete:
	la $a0, Delete_heading
	li $v0, 4
	syscall
	jal searching
	
	#move $t6, $zero
	la $t2, studentInfo
	jal find
	beq $t0, 0 , NotDeleted
	li $t4, 0
	la $t2, studentInfo
	add $t2, $t2, $s7
	jal linelenght
	la $t2, studentInfo
	add $t2, $t2, $s7
	move $t3, $t2
	add $t3, $t3, $t4
	add $t3, $t3, 1
	jal deleting
	la $a0, studentFile # loading file name
	jal openFile
	la $a1,studentInfo
	jal InsertData
	
	la $a0, deletedSucc
	li $v0, 4
	syscall
	j main
NotDeleted:
	la $a0, Notpresent
	li $v0, 4
	syscall
	j main
T_Delete:
	la $a0, Delete_heading
	li $v0, 4
	syscall
	jal searching
	la $t2, teacherInfo
	jal find
	beq $t0, 0 , NotDeleted
	li $t4, 0
	la $t2, teacherInfo
	add $t2, $t2, $s7
	jal linelenght
	la $t2, teacherInfo
	add $t2, $t2, $s7
	move $t3, $t2
	add $t3, $t3, $t4
	add $t3, $t3, 1
	jal deleting
	la $a0, teacherFile # loading file name
	jal openFile
	la $a1,teacherInfo
	jal InsertData
	
	la $a0, deletedSucc
	li $v0, 4
	syscall
	j main
deletnext:
	add $t3, $t3, 1
	add $t2, $t2, 1
deleting:
	lb $t5, ($t3)
	sb $t5, ($t2)
	#sb $t6, ($t3)
	beq $t5,'\0',delreturn
	
	j deletnext
delreturn:
	jr $ra
S_Show:
	la $a0, Show_heading
	li $v0, 4
	syscall
	la $t2, studentInfo
	li $t4, 0
	jal countLenght
	la $t2, studentInfo
	jal showData
	j main
T_Show:
	la $a0, Show_heading
	li $v0, 4
	syscall
	la $t2, teacherInfo
	li $t4, 0
	jal countLenght
	
	la $t2, teacherInfo
	jal showData
	j main
showData:
	li $v0, 4
	la $a0,H_rollno
	syscall
	
	la $a0,H_fname
	syscall
	la $a0,H_lname
	syscall
	la $a0,H_dept
	syscall
	la $a0,H_room
	syscall
	la $a0,line
	syscall
	j showing

inc:
	add $t2, $t2, 1
	sub $t4, $t4, 1
showing:
	ble $t4, 1, Show_return
	lb $t3, ($t2)
	beq $t3,'\0' Show_return
	li $v0, 11
	move $a0, $t3
	syscall
	beq $t3,' ',Tabs
	j inc
Show_return:
	jr $ra
Tabs:
	la $a0, tabs
	li $v0, 4
	syscall
	j inc
