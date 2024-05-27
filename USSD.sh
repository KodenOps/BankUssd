#!/bin/bash

shopt -s xpg_echo

#Set default Balance
Bal=100000
#convert to integer
Bal=$(($Bal))


#fuction to display the main menu

function mainMenu(){
	clear
	echo "========================================================================"
	echo "||                                                                    ||"
	echo "||                                                                    ||"
	echo "||                       Welcome to Osborne Bank	              ||"
	echo "||                                                                    ||"
	echo "||                                                                    ||"
	echo "||                          1. Check Balance                          ||"
	echo "||                          2. Transfer Fund                          ||"
	echo "||                          3. Buy Data                               ||"
	echo "||                          4. Buy Airtime                            ||"
	echo "||                          Any other key to Exit                     ||"
	echo "||                                                                    ||"
	echo "||                                                                    ||"
	echo "||                                                                    ||"
	echo "||                                                                    ||"
	echo "========================================================================"
	read ACTION
	ACTION=$(($ACTION))
	#LOGIC
	case $ACTION in
		1) checkBalance;;
		2) transferFunds;;
		3) BuyData;;
		4) BuyAirtime;;
	esac
}


#check balance

function checkBalance(){
	
	echo " ====================================================="
	echo "         Your Available balance is: #$Bal              "
	echo " ====================================================="
	DoMore
}


#Transfer funds
function transferFunds() {
	
	echo "====================================================="
	echo "          Enter Account Number (10 digits)           "
	echo "====================================================="
	read ACCOUNT_NO
	length=${#ACCOUNT_NO}
	if [ $length -eq 10 ];then 
		echo "====================================================="
        	echo "             Choose Bank                             "
        	echo "====================================================="
		echo "1. EcoBank\n2. Access Bank\n3. Polaris bank\n4. Jaiz bank\n0. Go Back Home\nAny other key to quit"
		read Bank
		BankName=""
		Bank=$(($Bank))
		case $Bank in
			1) BankName="Ecobank";;
			2) BankName="Access  Bank";;
			3) BankName="Polaris Bank";;
			4) BankName="Jaiz Bank";;
			0) mainMenu;;
		esac

		echo "====================================================="
		echo "             Enter Amount                            "
		echo "====================================================="
		read Amount
		Amount=$(($Amount))
		if [ $Amount -lt 1000 ];then
			echo "You Cannot Transfer Less Than #1000"
			DoMore
			
		else
		echo "==========================================="
		echo "Transfer #$Amount to $ACCOUNT_NO in $BankName? "
		echo "==========================================="
		echo "1. Yes\n2. Go Back Home"
		read choice
		choice=$(($choice))
		if [ $choice -eq 1 ];then
			balcheck=$(($Bal-$Amount))
			if [ $balcheck -gt 0 ];then
				echo "==================================="
				echo "  Funds Transferred Successfully"
				echo "==================================="
				Bal=$(($Bal-$Amount))
				checkBalance
			else
				echo "==================="
				echo "Insufficient Funds"
				echo "==================="
				DoMore
			fi
		elif [ $choice -eq 2 ];then
		mainMenu
		fi
	fi
else
	echo "Account number is wrong. It must be 10 characters"
	DoMore
fi
	}

function DoMore(){

	echo "====================================="
	echo "   Want to do another thing?"
	echo "====================================="
	echo "1. YES\nANY OTHER KEYS TO EXIT"
	read choice
	choice=$(($choice))

	if [ $choice -eq 1 ];then
		mainMenu
	fi
}

#buy data

function BuyData(){
	clear
	echo "===================================="
	echo "Kindly Select Your Preffered Network"
	echo "===================================="
	echo "1. MTN\n2. GLO\n3. Airtel\n4. Etisalat"
	read NETWORK
	choice=""
	NETWORK=$(($NETWORK))
	case $NETWORK in
		1) choice=MTN;;
		2) choice=GLO;;
		3) choice=AIRTEL;;
		4) choice=ETISALAT;;
		*) echo "That is not a valid answer" 
			BuyData;;
	esac
	echo "===================================="
	echo "Kindly Select Your Preffered Plan"
        echo "===================================="
	echo "1. 500GB for #10000\n2. 1000GB for #20000\n3. 50GB for #1000\n4. 10GB for #500\nPress Any Other Key To Go Back Home"
	read PLAN
	PLAN=$(($PLAN))
	data=""
	amount=0
	case $PLAN in 
		1) amount=10000
			data="500GB";;
		2) amount=20000
			data="1000GB";;
		3) amount=1000
			data="50GB";;
		4) amount=500
			data="10GB";;
		*) mainMenu;;
	esac
	echo "=============================================="
        echo " You are Buying $data for #$amount, Proceed?  "
        echo "=============================================="
	echo "1. YES\n2. NO"
	read PROCEED
	PROCEED=$(($PROCEED))
	case $PROCEED in
		1) Bal=$(($Bal-$amount))
			echo "===================================="
			echo "$data of data purchased successfully"
			echo "===================================="
			checkBalance;;
		2) mainMenu;;
	esac

}

#Buy airtime
function BuyAirtime(){
	echo "===================================="
	echo "Enter Amount To buy                 "
	echo "===================================="
	read AMOUNT
	AMOUNT=$(($AMOUNT))
	balanceChecker=$(($Bal-$AMOUNT))
	if [ $balanceChecker -lt 0 ];then
		echo "Insuficient Balance"
		DoMore
	else
		echo "===================================="
		echo "Select Network;"
		echo "===================================="
		echo "1. MTN\n2. GLO\n3. Airtel\n4. Etisalat"
		read NETWORK
		choice=""
		NETWORK=$(($NETWORK))
		case $NETWORK in
		1) choice=MTN;;
		2) choice=GLO;;
		3) choice=AIRTEL;;
		4) choice=ETISALAT;;
		*) echo "That is not a valid answer"
		BuyAirtime;;
		esac
		echo "============================="
		echo "Enter Mobile Number (11 digits)"
		echo "============================="
		read NUMBER
		length=${#NUMBER}
		if [ $length -ne 11 ];then
			echo "Incorrect Number Entered. Check and Retry"
			DoMore
		else
			echo "========================================="
			echo "Buy $AMOUNT $choice airtime for $NUMBER? "
			echo "========================================="
			echo "1. YES\nANY OTHER KEY TO GO BACK HOME"
			read RESP
			RESP=$(($RESP))
			case $RESP in
				1) Bal=$(($Bal-$AMOUNT))
					echo "================================"
					echo "Airtime Purchase Was Successful "
					echo "================================"
					checkBalance
					DoMore;;
				*) mainMenu;;
			esac
		fi
	fi
}
mainMenu
