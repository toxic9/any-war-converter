#!/bin/bash
###########################################################################
# Any War Converter
version=v3.3.2
changelog='New CMLGS Uália CAS Colors'
# v3.3.1='Add context restrictions'
# v3.3.0='New check War version option!'
# v3.2.0='New online feature for custom CAS option!'
# v3.0.1='New custom CAS option!'
# v3.0.1='Minor fixes and improvements'
# v3.0.0='CLI mode dropped. Brand new options available!'
# v2.5.0='New option to revert War files to default configuration'
# v2.4.0='All War files support!'
# v2.3.0='Menu is back!'
# v2.2.0='No menu! All labs in one go!'
# v2.1.0='Dual mode support (GUI + CLI)'
# v2.0.1='Change question for radiolist format on ignore_files verification'
# v2.0.0='Now it has an awesome GUI!'
# v1.0.6='Minor fixes and improvements'
# v1.0.5='Minor fixes and improvements'
# v1.0.4='Recognize official wAppolo files'
# v1.0.3='Check War files integrity'
# v1.0.2='Create War files in java compliant format'
# v1.0.1='Fix a bug where sometimes context is not updated'
# v1.0.0='First release!'
# 20200310 sgomes
###########################################################################

main() {
	header
	ckeck_files
	menu
}

header(){
	startup=$(zenity --width=350 --height=200 --title "Any War Converter $version                  toxic9 [2020]" --info --text "Confidentia, Tecnologias Informáticas Lda. apresenta:\nAny War Converter\n\nChangelog:\n$changelog" --ok-label="Continue" 2>/dev/null);
	if [ "$?" != 0 ]; then
		killall -9 zenity
		exit 0
	fi
}

ckeck_files() {
	echo "0"
	wars=(./*.war)
	if [ -e "${wars[0]}" ]; then
		if [[ -f ./ara-messenger.war && -f ./ara-portal.war && -f ./cas.war && -f ./lis-integrator.war && -f ./wappolo-api-client.war && -f ./wappolo-api-server.war ]]; then
			return 0
		else
			zenity --width=350 --height=200 --question --title "WARNING" --text "Nem todos os ficheiros foram encontrados.\nDevem existir nesta directoria:\n\nara-messenger.war\nara-portal.war\ncas.war\nlis-integrator.war\nwappolo-api-client.war\nwappolo-api-server.war\n\nContinuar?" --cancel-label="Não" --ok-label="Sim" 2>/dev/null
			if [ "$?" != 0 ]; then
				killall -9 zenity
				exit 0
			fi
		fi
	else
		echo "#Não foram encontrados ficheiros!"
		exit 0
	fi
}

menu() {
	option=$(zenity --width=390 --height=225 --list --title "MENU" --text "Selecione a conversão que pretende:\n" --radiolist --column "" --column "Opção" TRUE "SYNLAB (Non Docker)" FALSE "DOCKER (For Fast Autodeploy)" FALSE "RESET (Undo All)" FALSE "CHECK VERSION (Display Files Revision)" 2>/dev/null);
	if [ "$?" != 0 ]; then
		killall -9 zenity
		exit 0
	fi

	case $option in
		"SYNLAB (Non Docker)")
			synlab=$(zenity --width=390 --height=300 --list --title "SYNLAB" --text "Selecione o laboratório:\n" --radiolist --column "" --column "Laboratório" TRUE "TODOS" FALSE "Castro Fernandes" FALSE "Flaviano Gusmão" FALSE "GeneralLab (Sta. Isabel)" FALSE "Gnóstica" FALSE "Labnorte (Boavista)" FALSE "Luznorte" 2>/dev/null);
			if [ "$?" != 0 ]; then
				killall -9 zenity
				exit 0
			fi
			case $synlab in
				"TODOS")
					i=1
					cas_logo="Default"
					while [ $i -le 6 ]; do
						change_lab
						process_data
					done
					cleanup_temp
					cleanup_remaining_wars
					end
					;;
				"Castro Fernandes")
					i=1
					cas_logo="Default"
					change_lab
					process_data
					cleanup_temp
					cleanup_remaining_wars
					end
					;;
				"Flaviano Gusmão")
					i=2
					cas_logo="Default"
					change_lab
					process_data
					cleanup_temp
					cleanup_remaining_wars
					end
					;;
				"GeneralLab (Sta. Isabel)")
					i=3
					cas_logo="Default"
					change_lab
					process_data
					cleanup_temp
					cleanup_remaining_wars
					end
					;;
				"Gnóstica")
					i=4
					cas_logo="Default"
					change_lab
					process_data
					cleanup_temp
					cleanup_remaining_wars
					end
					;;
				"Labnorte (Boavista)")
					i=5
					cas_logo="Default"
					change_lab
					process_data
					cleanup_temp
					cleanup_remaining_wars
					end
					;;
				"Luznorte")
					i=6
					cas_logo="Default"
					change_lab
					process_data
					cleanup_temp
					cleanup_remaining_wars
					end
					;;
			esac
			;;
		"DOCKER (For Fast Autodeploy)")
			i=7
			docker_version=$(zenity --width=250 --height=165 --list --title "Docker Version" --text "Indique a versão do Docker:" --radiolist --column "" --column "Versão" TRUE "Single Container" FALSE "Frontend + Backend" 2>/dev/null);
			if [ "$?" != 0 ]; then
				killall -9 zenity
				exit 0
			fi
			context="_invalid_dummy_text_"
			until [[ $context =~ ^[abcdefghijklmnopqrstuvwxyz0123456789]{0,20}$ ]]
			do
				context=$(zenity --width=275 --height=190 --entry --title="Context" --text "Indique o contexto a adicionar:\n\n- Apenas letras minúsculas e números\n- Sem caracteres especiais\n- 20 caracteres no máximo" 2>/dev/null);
				if [ "$?" != 0 ]; then
					killall -9 zenity
					exit 0
				fi
			done
			if [ -f ./cas.war ]; then
				cas_logo=$(zenity --width=250 --height=395 --list --title "CAS Logo" --text "Indique o logo para o CAS:" --radiolist --column "" --column "Logo" TRUE "Default" FALSE "Confidentia" FALSE "CMLGS Açores" FALSE "CMLGS Algarve" FALSE "CMLGS Coimbra" FALSE "CMLGS Lisboa" FALSE "CMLGS Porto" FALSE "CMLGS Porto HCP" FALSE "CMLGS Porto Trindade" FALSE "CMLGS Torres" FALSE "CMLGS Uália" FALSE "CMLGS Viseu" 2>/dev/null);
				if [ "$?" != 0 ]; then
					killall -9 zenity
					exit 0
				fi
			fi
			change_lab
			process_data
			cleanup_temp
			cleanup_remaining_wars
			end
			;;
		"RESET (Undo All)")
			i=8
			cas_logo="Default"
			change_lab
			process_data
			cleanup_temp
			cleanup_remaining_wars
			end
			;;
		"CHECK VERSION (Display Files Revision)")
			{ ara_messenger_ver=$(unzip -p ara-messenger.war META-INF/maven/pt.confidentia/ara-messenger/pom.properties | sed -n '3{p;q}' | cut -c 9-); } 2>/dev/null
			{ ara_portal_ver=$(unzip -p ara-portal.war META-INF/maven/pt.confidentia/ara-portal/pom.properties | sed -n '3{p;q}' | cut -c 9-); } 2>/dev/null
			{ cas_ver=$(unzip -p cas.war META-INF/maven/org.jasig.cas/cas-server-webapp/pom.properties | sed -n '3{p;q}' | cut -c 9-); } 2>/dev/null
			{ lis_integrator_ver=$(unzip -p lis-integrator.war META-INF/maven/pt.confidentia/lis-integrator/pom.properties | sed -n '3{p;q}' | cut -c 9-); } 2>/dev/null
			{ wappolo_api_client_ver=$(unzip -p wappolo-api-client.war META-INF/maven/pt.confidentia/wappolo-api-client/pom.properties | sed -n '2{p;q}' | cut -c 9-); } 2>/dev/null
			{ wappolo_api_server_ver=$(unzip -p wappolo-api-server.war META-INF/maven/pt.confidentia/wappolo-api-server/pom.properties | sed -n '2{p;q}' | cut -c 9-); } 2>/dev/null
			if [ -f ./ara-messenger.war ]; then
				ara_messenger_ver2="ara-messenger.war $ara_messenger_ver\n"
				if [ "$ara_messenger_ver" = "" ]; then
					ara_messenger_ver2="ara-messenger.war (Ficheiro corrompido)\n"
				fi
			else
				ara_messenger_ver2=""
			fi
			if [ -f ./ara-portal.war ]; then
				ara_portal_ver2="ara-portal.war $ara_portal_ver\n"
				if [ "$ara_portal_ver" = "" ]; then
					ara_portal_ver2="ara-portal.war (Ficheiro corrompido)\n"
				fi
			else
				ara_portal_ver2=""
			fi
			if [ -f ./cas.war ]; then
				cas_ver2="cas.war $cas_ver\n"
				if [ "$cas_ver" = "" ]; then
					cas_ver2="cas.war (Ficheiro corrompido)\n"
				fi
			else
				cas_ver2=""
			fi
			if [ -f ./lis-integrator.war ]; then
				lis_integrator_ver2="lis-integrator.war $lis_integrator_ver\n"
				if [ "$lis_integrator_ver" = "" ]; then
					lis_integrator_ver2="lis-integrator.war (Ficheiro corrompido)\n"
				fi
			else
				lis_integrator_ver2=""
			fi
			if [ -f ./wappolo-api-client.war ]; then
				wappolo_api_client_ver2="wappolo-api-client.war $wappolo_api_client_ver\n"
				if [ "$wappolo_api_client_ver" = "" ]; then
					wappolo_api_client_ver2="wappolo-api-client.war (Ficheiro corrompido)\n"
				fi
			else
				wappolo_api_client_ver2=""
			fi
			if [ -f ./wappolo-api-server.war ]; then
				wappolo_api_server_ver2="wappolo-api-server.war $wappolo_api_server_ver\n"
				if [ "$wappolo_api_server_ver" = "" ]; then
					wappolo_api_server_ver2="wappolo-api-server.war (Ficheiro corrompido)\n"
				fi
			else
				wappolo_api_server_ver2=""
			fi
			if [ "$ara_messenger_ver2$ara_portal_ver2$cas_ver2$lis_integrator_ver2$wappolo_api_client_ver2$wappolo_api_server_ver2" = "" ]; then
				zenity --width=350 --height=200 --title "War Version" --info --text "Não foram encontrados ficheiros!" --ok-label="Continue" 2>/dev/null
				if [ "$?" != 0 ]; then
					killall -9 zenity
					exit 0
				fi
			menu
			else	
				zenity --width=350 --height=200 --title "War Version" --info --text "$ara_messenger_ver2$ara_portal_ver2$cas_ver2$lis_integrator_ver2$wappolo_api_client_ver2$wappolo_api_server_ver2" --ok-label="Continue" 2>/dev/null
				if [ "$?" != 0 ]; then
					killall -9 zenity
					exit 0
				fi
			fi
			menu
			;;
	esac
}

change_lab() {
	case $i in
		"1")
			lab='castrofernandes'
			dc='castrofernandes'
			port='8055'
			;;
		"2")
			lab='fgusmao'
			dc='fgusmao'
			port='8050'
			;;
		"3")
			lab='generallab'
			dc='generallab'
			port='8051'
			;;
		"4")
			lab='gnostica'
			dc='gnostica'
			port='8048'
			;;
		"5")
			lab='labnorte'
			dc='hppboavista'
			port='8052'
			;;
		"6")
			lab='luznorte'
			dc='luznorte'
			port='8053'
			;;
		"7")
			lab=$context
			;;
	esac
}

process_data() {
	echo "#Por favor aguarde..."

# Unzip war files to temporary directories:
	echo "5"
	unzip -d ./ara-messenger ./ara-messenger.war &> /dev/null
	unzip -d ./ara-portal ./ara-portal.war &> /dev/null
	unzip -d ./cas ./cas.war &> /dev/null
	unzip -d ./lis-integrator ./lis-integrator.war &> /dev/null
	unzip -d ./wappolo-api-client ./wappolo-api-client.war &> /dev/null
	unzip -d ./wappolo-api-server ./wappolo-api-server.war &> /dev/null

# Process custom cas (add or remove):
	if [ -f ./cas.war ]; then
		if [ ! -f ./resources.zip ]; then
			wget "https://raw.githubusercontent.com/toxic9/any-war-converter/master/resources.zip" -O ./resources.zip &> /dev/null
			if [ ! -s ./resources.zip ]; then
				cleanup_temp
				rm -f ./resources.zip &> /dev/null
				echo "#A ligação à internet falhou..."
				exit 0
			fi
		fi
		if [ "$(md5sum resources.zip | awk '{ print $1 }')" = "bda00027460a947dbe8526e4234879c8" ]; then
			unzip -d ./ ./resources.zip &> /dev/null
			case $cas_logo in
				"Default")
					cp ./resources/css/cas_default.css ./cas/css/cas.css &> /dev/null
					rm -f ./cas/images/bgc.png &> /dev/null
					rm -f ./cas/images/bgcb.png &> /dev/null
					rm -f ./cas/images/favicon.png &> /dev/null
					rm -f ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_default.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_default.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
				"Confidentia")
					cp ./resources/css/cas_confidentia.css ./cas/css/cas.css &> /dev/null
					cp ./resources/images/bgc_confidentia.png ./cas/images/bgc.png &> /dev/null
					cp ./resources/images/bgcb_confidentia.png ./cas/images/bgcb.png &> /dev/null
					cp ./resources/images/favicon.png ./cas/images/favicon.png &> /dev/null
					cp ./resources/images/logo_confidentia.png ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_confidentia.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_confidentia.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
				"CMLGS Açores")
					cp ./resources/css/cas_cmlgs.css ./cas/css/cas.css &> /dev/null
					rm -f ./cas/images/bgc.png &> /dev/null
					rm -f ./cas/images/bgcb.png &> /dev/null
					cp ./resources/images/favicon.png ./cas/images/favicon.png &> /dev/null
					cp ./resources/images/logo_cmlgs_acores.png ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
				"CMLGS Algarve")
					cp ./resources/css/cas_cmlgs.css ./cas/css/cas.css &> /dev/null
					rm -f ./cas/images/bgc.png &> /dev/null
					rm -f ./cas/images/bgcb.png &> /dev/null
					cp ./resources/images/favicon.png ./cas/images/favicon.png &> /dev/null
					cp ./resources/images/logo_cmlgs_algarve.png ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
				"CMLGS Coimbra")
					cp ./resources/css/cas_cmlgs.css ./cas/css/cas.css &> /dev/null
					rm -f ./cas/images/bgc.png &> /dev/null
					rm -f ./cas/images/bgcb.png &> /dev/null
					cp ./resources/images/favicon.png ./cas/images/favicon.png &> /dev/null
					cp ./resources/images/logo_cmlgs_coimbra.png ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
				"CMLGS Lisboa")
					cp ./resources/css/cas_cmlgs.css ./cas/css/cas.css &> /dev/null
					rm -f ./cas/images/bgc.png &> /dev/null
					rm -f ./cas/images/bgcb.png &> /dev/null
					cp ./resources/images/favicon.png ./cas/images/favicon.png &> /dev/null
					cp ./resources/images/logo_cmlgs_lisboa.png ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
				"CMLGS Porto")
					cp ./resources/css/cas_cmlgs.css ./cas/css/cas.css &> /dev/null
					rm -f ./cas/images/bgc.png &> /dev/null
					rm -f ./cas/images/bgcb.png &> /dev/null
					cp ./resources/images/favicon.png ./cas/images/favicon.png &> /dev/null
					cp ./resources/images/logo_cmlgs_porto.png ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
				"CMLGS Porto HCP")
					cp ./resources/css/cas_cmlgs.css ./cas/css/cas.css &> /dev/null
					rm -f ./cas/images/bgc.png &> /dev/null
					rm -f ./cas/images/bgcb.png &> /dev/null
					cp ./resources/images/favicon.png ./cas/images/favicon.png &> /dev/null
					cp ./resources/images/logo_cmlgs_porto_hcp.png ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
				"CMLGS Porto Trindade")
					cp ./resources/css/cas_cmlgs.css ./cas/css/cas.css &> /dev/null
					rm -f ./cas/images/bgc.png &> /dev/null
					rm -f ./cas/images/bgcb.png &> /dev/null
					cp ./resources/images/favicon.png ./cas/images/favicon.png &> /dev/null
					cp ./resources/images/logo_cmlgs_porto_trindade.png ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
				"CMLGS Torres")
					cp ./resources/css/cas_cmlgs.css ./cas/css/cas.css &> /dev/null
					rm -f ./cas/images/bgc.png &> /dev/null
					rm -f ./cas/images/bgcb.png &> /dev/null
					cp ./resources/images/favicon.png ./cas/images/favicon.png &> /dev/null
					cp ./resources/images/logo_cmlgs_torres.png ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
				"CMLGS Uália")
					cp ./resources/css/cas_cmlgs_ualia.css ./cas/css/cas.css &> /dev/null
					rm -f ./cas/images/bgc.png &> /dev/null
					rm -f ./cas/images/bgcb.png &> /dev/null
					cp ./resources/images/favicon.png ./cas/images/favicon.png &> /dev/null
					cp ./resources/images/logo_cmlgs_ualia.png ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_cmlgs_ualia.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_cmlgs_ualia.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
				"CMLGS Viseu")
					cp ./resources/css/cas_cmlgs.css ./cas/css/cas.css &> /dev/null
					rm -f ./cas/images/bgc.png &> /dev/null
					rm -f ./cas/images/bgcb.png &> /dev/null
					cp ./resources/images/favicon.png ./cas/images/favicon.png &> /dev/null
					cp ./resources/images/logo_cmlgs_viseu.png ./cas/images/logo.png &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/bottom_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/bottom.jsp &> /dev/null
					cp ./resources/WEB-INF/view/jsp/confidentia/ui/includes/top_cmlgs.jsp ./cas/WEB-INF/view/jsp/confidentia/ui/includes/top.jsp &> /dev/null
					;;
			esac
		else
			cleanup_temp
			echo "#Ficheiro \"resources.zip\" corrompido..."
			exit 0
		fi
	fi

# Fill variables with necessary text to be replaced:
	echo "10"
	case $i in
		"1"|"2"|"3"|"4"|"5"|"6")
			aramessengerold='<context-root>.*</context-root>'
			aramessengernew='<context-root>/'$lab'/aramessenger</context-root>'
			araportalold='<context-root>.*</context-root>'
			araportalnew='<context-root>/'$lab'/wap</context-root>'
#			wconfigold='<param-value>.*</param-value>' ## NOT USED SINCE v1.0 BUG ##
			wconfignew='        <param-value>/opt/glassfish4/glassfish/domains/'$lab'/wconfig/java-cas-client.properties</param-value>'
			casold='http://localhost:.*/cas'
			casnew='http://localhost:'$port'/'$lab'/cas'
			ldapold='<value>ldap://.*</value>'
			ldapnew='<value>ldap://localhost:10389</value>'
			domainold='<property name="searchBase" value=".*" />'
			domainnew='<property name="searchBase" value="ou=People,dc='$dc',dc=labco,dc=eu" />'
			lisintegratorold='<context-root>.*</context-root>'
			lisintegratornew='<context-root>/'$lab'/lisintegrator</context-root>'
			apiclientold='<context-root>.*</context-root>'
			apiclientnew='<context-root>/'$lab'/wappoloapiclient</context-root>'
			apiserverold='<context-root>.*</context-root>'
			apiservernew='<context-root>/'$lab'/wappoloapi</context-root>'
			;;
		"7")
			if [ "$lab" = "" ]; then
				aramessengerold='<context-root>.*</context-root>'
				aramessengernew='<context-root>/aramessenger</context-root>'
				araportalold='<context-root>.*</context-root>'
				araportalnew='<context-root>/wap</context-root>'
#				wconfigold='<param-value>.*</param-value>' ## NOT USED SINCE v1.0 BUG ##
				wconfignew='        <param-value>/opt/wconfig/java-cas-client.properties</param-value>'
				casold='http://localhost:.*/cas'
				casnew='http://localhost:8080/cas'
				ldapold='<value>ldap://.*</value>'
				if [ "$docker_version" = "Single Container" ]; then
					ldapnew='<value>ldap://localhost:10389</value>'
				else
					ldapnew='<value>ldap://wappolo-backend:10389</value>'
				fi
				domainold='<property name="searchBase" value=".*" />'
				domainnew='<property name="searchBase" value="ou=People,dc=confidentia,dc=pt" />'
				lisintegratorold='<context-root>.*</context-root>'
				lisintegratornew='<context-root>/lisintegrator</context-root>'
				apiclientold='<context-root>.*</context-root>'
				apiclientnew='<context-root>/wappoloapiclient</context-root>'
				apiserverold='<context-root>.*</context-root>'
				apiservernew='<context-root>/wappoloapi</context-root>'
			else
				aramessengerold='<context-root>.*</context-root>'
				aramessengernew='<context-root>/'$lab'/aramessenger</context-root>'
				araportalold='<context-root>.*</context-root>'
				araportalnew='<context-root>/'$lab'/wap</context-root>'
#				wconfigold='<param-value>.*</param-value>' ## NOT USED SINCE v1.0 BUG ##
				wconfignew='        <param-value>/opt/wconfig/java-cas-client.properties</param-value>'
				casold='http://localhost:.*/cas'
				casnew='http://localhost:8080/'$lab'/cas'
				ldapold='<value>ldap://.*</value>'
				ldapnew='<value>ldap://localhost:10389</value>'
				if [ "$docker_version" = "Single Container" ]; then
					ldapnew='<value>ldap://localhost:10389</value>'
				else
					ldapnew='<value>ldap://wappolo-backend-'$lab':10389</value>'
				fi
				domainold='<property name="searchBase" value=".*" />'
				domainnew='<property name="searchBase" value="ou=People,dc=confidentia,dc=pt" />'
				lisintegratorold='<context-root>.*</context-root>'
				lisintegratornew='<context-root>/'$lab'/lisintegrator</context-root>'
				apiclientold='<context-root>.*</context-root>'
				apiclientnew='<context-root>/'$lab'/wappoloapiclient</context-root>'
				apiserverold='<context-root>.*</context-root>'
				apiservernew='<context-root>/'$lab'/wappoloapi</context-root>'
			fi
			;;
		"8")
			aramessengerold='<context-root>.*</context-root>'
			aramessengernew='<context-root>/aramessenger</context-root>'
			araportalold='<context-root>.*</context-root>'
			araportalnew='<context-root>/wap</context-root>'
#			wconfigold='<param-value>.*</param-value>' ## NOT USED SINCE v1.0 BUG ##
			wconfignew='        <param-value>/opt/wconfig/java-cas-client.properties</param-value>'
			casold='http://localhost:.*/cas'
			casnew='http://localhost:8080/cas'
			ldapold='<value>ldap://.*</value>'
			ldapnew='<value>ldap://localhost:10389</value>'
			domainold='<property name="searchBase" value=".*" />'
			domainnew='<property name="searchBase" value="ou=People,dc=confidentia,dc=pt" />'
			lisintegratorold='<context-root>.*</context-root>'
			lisintegratornew='<context-root>/lisintegrator</context-root>'
			apiclientold='<context-root>.*</context-root>'
			apiclientnew='<context-root>/wappoloapiclient</context-root>'
			apiserverold='<context-root>.*</context-root>'
			apiservernew='<context-root>/wappoloapi</context-root>'
			;;
	esac

# Replace necessary text within war files:
	echo "20"
	sed -i "s|$aramessengerold|$aramessengernew|g" ./ara-messenger/WEB-INF/glassfish-web.xml &> /dev/null
	sed -i "s|$araportalold|$araportalnew|g" ./ara-portal/WEB-INF/glassfish-web.xml &> /dev/null
	sed -i "7s|.*|$wconfignew|g" ./ara-portal/WEB-INF/web.xml &> /dev/null
	sed -i "s|$casold|$casnew|g" ./cas/WEB-INF/cas.properties &> /dev/null
	sed -i "s|$ldapold|$ldapnew|g" ./cas/WEB-INF/deployerConfigContext.xml &> /dev/null
	sed -i "s|$domainold|$domainnew|g" ./cas/WEB-INF/deployerConfigContext.xml &> /dev/null
	sed -i "s|$lisintegratorold|$lisintegratornew|g" ./lis-integrator/WEB-INF/glassfish-web.xml &> /dev/null
	sed -i "s|$apiclientold|$apiclientnew|g" ./wappolo-api-client/WEB-INF/glassfish-web.xml &> /dev/null
	sed -i "s|$apiserverold|$apiservernew|g" ./wappolo-api-server/WEB-INF/glassfish-web.xml &> /dev/null

# Create new war files:
	echo "30"
	cd ara-messenger &> /dev/null && jar -cvf ../ara-messenger.war . &> /dev/null && cd .. &> /dev/null
	cd ara-portal &> /dev/null && jar -cvf ../ara-portal.war . &> /dev/null && cd .. &> /dev/null
	cd cas &> /dev/null && jar -cvf ../cas.war . &> /dev/null && cd .. &> /dev/null
	cd lis-integrator &> /dev/null && jar -cvf ../lis-integrator.war . &> /dev/null && cd .. &> /dev/null
	cd wappolo-api-client &> /dev/null && jar -cvf ../wappolo-api-client.war . &> /dev/null && cd .. &> /dev/null
	cd wappolo-api-server &> /dev/null && jar -cvf ../wappolo-api-server.war . &> /dev/null && cd .. &> /dev/null

# Check ara-messenger.war integrity:
	echo "40"
	messhead="$(grep -rnw 'ara-messenger.war' -e 'META-INF/maven/pt.confidentia/ara-messenger/pom.properties' 2>/dev/null)"
	if [ "$messhead" = "Binary file ara-messenger.war matches" ]; then
		mkdir "Deploy" &> /dev/null
		mv ./ara-messenger.war ./Deploy/ara-messenger.war &> /dev/null
	else
		if [ -f "./ara-messenger.war" ]; then
			mkdir "Corrupted" &> /dev/null
			mv ./ara-messenger.war ./Corrupted/ara-messenger.war &> /dev/null
		fi
	fi

# Check ara-portal.war integrity:
	echo "50"
	porthead="$(grep -rnw 'ara-portal.war' -e 'META-INF/maven/pt.confidentia/ara-portal/pom.properties' 2>/dev/null)"
	if [ "$porthead" = "Binary file ara-portal.war matches" ]; then
		mkdir "Deploy" &> /dev/null
		mv ./ara-portal.war ./Deploy/ara-portal.war &> /dev/null
	else
		if [ -f "./ara-portal.war" ]; then
			mkdir "Corrupted" &> /dev/null
			mv ./ara-portal.war ./Corrupted/ara-portal.war &> /dev/null
		fi
	fi

# Check cas.war integrity:
	echo "60"
	cashead="$(grep -rnw 'cas.war' -e 'META-INF/maven/org.jasig.cas/cas-server-webapp/pom.properties' 2>/dev/null)"
	if [ "$cashead" = "Binary file cas.war matches" ]; then
		mkdir "Deploy" &> /dev/null
		mv ./cas.war ./Deploy/cas.war &> /dev/null
	else
		if [ -f "./cas.war" ]; then
			mkdir "Corrupted" &> /dev/null
			mv ./cas.war ./Corrupted/cas.war &> /dev/null
		fi
	fi

# Check lis-integrator.war integrity:
	echo "70"
	lishead="$(grep -rnw 'lis-integrator.war' -e 'META-INF/maven/pt.confidentia/lis-integrator/pom.properties' 2>/dev/null)"
	if [ "$lishead" = "Binary file lis-integrator.war matches" ]; then
		mkdir "Deploy" &> /dev/null
		mv ./lis-integrator.war ./Deploy/lis-integrator.war &> /dev/null
	else
		if [ -f "./lis-integrator.war" ]; then
			mkdir "Corrupted" &> /dev/null
			mv ./lis-integrator.war ./Corrupted/lis-integrator.war &> /dev/null
		fi
	fi

# Check wappolo-api-client.war integrity:
	echo "80"
	cliehead="$(grep -rnw 'wappolo-api-client.war' -e 'META-INF/maven/pt.confidentia/wappolo-api-client/pom.properties' 2>/dev/null)"
	if [ "$cliehead" = "Binary file wappolo-api-client.war matches" ]; then
		mkdir "Deploy" &> /dev/null
		mv ./wappolo-api-client.war ./Deploy/wappolo-api-client.war &> /dev/null
	else
		if [ -f "./wappolo-api-client.war" ]; then
			mkdir "Corrupted" &> /dev/null
			mv ./wappolo-api-client.war ./Corrupted/wappolo-api-client.war &> /dev/null
		fi
	fi

# Check wappolo-api-server.war integrity:
	echo "90"
	servhead="$(grep -rnw 'wappolo-api-server.war' -e 'META-INF/maven/pt.confidentia/wappolo-api-server/pom.properties' 2>/dev/null)"
	if [ "$servhead" = "Binary file wappolo-api-server.war matches" ]; then
		mkdir "Deploy" &> /dev/null
		mv ./wappolo-api-server.war ./Deploy/wappolo-api-server.war &> /dev/null
	else
		if [ -f "./wappolo-api-server.war" ]; then
			mkdir "Corrupted" &> /dev/null
			mv ./wappolo-api-server.war ./Corrupted/wappolo-api-server.war &> /dev/null
		fi
	fi

# Check if unknown war files exist:
	echo "95"
	unknown_wars=(./*.war)
	if [ -e "${unknown_wars[0]}" ]; then
		mkdir "Unknown" &> /dev/null
		cp ./*.war ./Unknown/ &> /dev/null
	fi

# Arrange output:
	echo "98"
	case $i in
		"1")
			mkdir "./Castro Fernandes"  &> /dev/null
			mv "./Deploy" "./Castro Fernandes/Deploy" &> /dev/null
			mv "./Corrupted" "./Castro Fernandes/Corrupted" &> /dev/null
			mv "./Unknown" "./Castro Fernandes/Unknown" &> /dev/null
			;;
		"2")
			mkdir "./Flaviano Gusmão"  &> /dev/null
			mv "./Deploy" "./Flaviano Gusmão/Deploy" &> /dev/null
			mv "./Corrupted" "./Flaviano Gusmão/Corrupted" &> /dev/null
			mv "./Unknown" "./Flaviano Gusmão/Unknown" &> /dev/null
			;;
		"3")
			mkdir "./GeneralLab"  &> /dev/null
			mv "./Deploy" "./GeneralLab/Deploy" &> /dev/null
			mv "./Corrupted" "./GeneralLab/Corrupted" &> /dev/null
			mv "./Unknown" "./GeneralLab/Unknown" &> /dev/null
			;;
		"4")
			mkdir "./Gnostica"  &> /dev/null
			mv "./Deploy" "./Gnostica/Deploy" &> /dev/null
			mv "./Corrupted" "./Gnostica/Corrupted" &> /dev/null
			mv "./Unknown" "./Gnostica/Unknown" &> /dev/null
			;;
		"5")
			mkdir "./Labnorte"  &> /dev/null
			mv "./Deploy" "./Labnorte/Deploy" &> /dev/null
			mv "./Corrupted" "./Labnorte/Corrupted" &> /dev/null
			mv "./Unknown" "./Labnorte/Unknown" &> /dev/null
			;;
		"6")
			mkdir "./Luznorte"  &> /dev/null
			mv "./Deploy" "./Luznorte/Deploy" &> /dev/null
			mv "./Corrupted" "./Luznorte/Corrupted" &> /dev/null
			mv "./Unknown" "./Luznorte/Unknown" &> /dev/null
			;;
		"7")
			info1=" ($docker_version)"
			if [ "$lab" = "" ]; then
				info2=" (Sem contexto)"
			else
				info2=" (Contexto = $lab)"
			fi
			if [ "$cas_logo" = "" ]; then
				info3=""
			else
				info3=" (CAS logo = $cas_logo)"
			fi
			mkdir "./Docker$info1$info2$info3" &> /dev/null
			mv "./Deploy" "./Docker$info1$info2$info3/Deploy" &> /dev/null
			mv "./Corrupted" "./Docker$info1$info2$info3/Corrupted" &> /dev/null
			mv "./Unknown" "./Docker$info1$info2$info3/Unknown" &> /dev/null
			;;
		"8")
			mkdir "./Default"  &> /dev/null
			mv "./Deploy" "./Default/Deploy" &> /dev/null
			mv "./Corrupted" "./Default/Corrupted" &> /dev/null
			mv "./Unknown" "./Default/Unknown" &> /dev/null
			;;
	esac

# Increase loop number:
	i=$(($i + 1))

}

cleanup_temp() {
# Delete temporary directories:
	echo "99"
	rm -rf ./ara-messenger/ &> /dev/null
	rm -rf ./ara-portal/ &> /dev/null
	rm -rf ./cas/ &> /dev/null
	rm -rf ./lis-integrator/ &> /dev/null
	rm -rf ./wappolo-api-client/ &> /dev/null
	rm -rf ./wappolo-api-server/ &> /dev/null
	rm -rf ./resources/ &> /dev/null
}

cleanup_remaining_wars() {
# Delete remaining war files:
	rm -f ./*.war &> /dev/null
}

end() {
# Show final message:
	echo "100"
	echo "#TERMINADO!\n\nDeploy = Ficheiros War prontos a publicar!\nUnknown = Ficheiros War com nomes não identificados\nCorrupted = Ficheiros War corrompidos"
}

# Call main function:
main | zenity --width=400 --height=200 --title "Any War Converter $version                  toxic9 [2020]" --progress --auto-kill 2>/dev/null

exit 0
