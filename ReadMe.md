##Any War Converter
**Confidentia, Tecnologias Informáticas Lda.**  

####Esta aplicação converte os ficheiros War que compõem o pack wAppolo para fazer autodeploy em ambiente não Dockerizado (Ex. Synab) ou ambiente Dockerizado (Outros clientes).

___

###Requisitos mínimos:

- Sistema Operativo Ubuntu 18.04.3 LTS

###Funcionamento:

- Editar o ficheiro `any_war_converter_vX.X.X.desktop` de forma a que a working directory (`Path`) e o caminho para o binário (`Exec`) correspondam.

Ex.:

    [Desktop Entry]
    Type=Application
    Terminal=false
    Name[en_US]=any_war_converter_vX.X.X
    Path=/home/user/
    Exec=/home/user/any_war_converter_vX.X.X

- Colocar os ficheiros a converter, na mesma diretoria da aplicação.

###Ficheiros suportados:

    ara-messenger.war
    ara-portal.war
    cas.war
    lis-integrator.war
    wappolo-api-client.war
    wappolo-api-server.war

Colocar os ficheiros a converter, na mesma diretoria da aplicação.

###Ficheiros não identificados:

- Caso os ficheiros não tenham os nomes correctos acima descritos, a aplicação irá ignorá-los.

###Converter para ambiente não Dockerizado (Synlab):

- É possível converter os ficheiros para as configurações do servidor Synlab (10.34.124.1).

- No menu principal, escolher a opção **SYNLAB (Non Docker)** e seleccionar a opção pretendida:

        TODOS
        Castro Fernandes
        Flaviano Gusmão
        GeneralLab (Sta. Isabel)
        Gnóstica
        Labnorte (Boavista)
        Luznorte

**Notas:**  
A opção **TODOS** converte para todas as dependências Synçab ao mesmo tempo!

###Converter para ambiente não Dockerizado (Outros clientes):

- No menu principal, escolher a opção **DOCKER (For Fast Autodeploy)**.

- Escolher a versão do Docker instalada: **Single Container** ou o novo modelo **Frontend + Backend** preparado para cluster.

- Se necessário, poderá ser adicionado um contexto. É útil para casos em que existe mais que uma instância no servidor. Para isso, na caixa seguinte adicionar o contexto pretendido. Se não necessitar de contexto, deixar a caixa vazia.

**Notas:**  
Não são permitidos caracteres especiais. Apenas minúsculas, maiúsculas e números. O contexto está limitado a 20 caracteres.

- Se existir um ficheiro **cas.war** para conversão, a aplicação irá perguntar se quer personalizar o layout e logo do Cas. É possível escolher entre várias opções para diferentes clientes / ambientes:

        Default
        Confidentia
        CMLGS Açores
        CMLGS Algarve
        CMLGS Coimbra
        CMLGS Lisboa
        CMLGS Porto
        CMLGS Porto HCP
        CMLGS Porto Trindade
        CMLGS Torres
        CMLGS Uália
        CMLGS Viseu

**Notas:**  
A opção **Default** coloca o layout e logo por defeito do Cas.  
Para a personalização do Cas, a aplicação necessitará de utilizar o ficheiro **resources.zip** que deve existir na mesma directoria da aplicação. Caso este ficheiro não exista, a aplicação irá tentar descarregá-lo da internet.

###Reverter um ficheiro War para o seu formato original (por defeito):

- No menu principal, escolher a opção **RESET (Undo All)**.

- O ficheiro será revertido para o seu estado original, anterior às modificações.

###Verificação de integridade dos ficheiros War:

- Os ficheiros gerados pela aplicação serão colocados numa directoria **Deploy** prontos a utilizar.

- Todos os ficheiros War gerados pela aplicação, são verificados através de um algoritmo de verificação de consistência.

- Caso essa verificação falhe em algum ponto, os ficheiros serão automáticamente movidos para uma directoria **Corrupted**.

- Por último, os ficheiros com nomes inválios, ou não reconhecidos pela aplicação, serão movidos para uma directoria **Unknown**.

###Verificar a versão dos ficheiros War:

- No menu principal, escolher a opção **CHECK VERSION (Display Files Revision)**.
___

Developed by **toxic9**  
2020 - Todos os direitos reservados
