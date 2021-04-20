# Gestão de chaves e certificado
A maioria dos usuários recorre ao OpenSSL porque deseja configurar e executar um servidor web que suporte SSL. Esse processo consiste em três etapas: (1) gerar uma chave privada forte, (2) criar uma Solicitação de Assinatura de Certificado (CSR) e enviá-la a uma CA, e (3) instalar o certificado fornecido pela CA em seu servidor web. Essas etapas (e algumas outras) são abordadas nesta seção.

## Geração de chaves
O primeiro passo na preparação para o uso da criptografia pública é gerar uma chave privada. Antes de começar, você deve tomar várias decisões:
### Algoritmo da chave
OpenSSL suporta chaves RSA, DSA e ECDSA, mas nem todos os tipos são práticos para uso em todos os cenários. Por exemplo, para chaves de servidor Web, todos usam RSA, porque as chaves DSA são efetivamente limitadas a 1.024 bits (o Internet Explorer não suporta nada mais forte) e as chaves ECDSA ainda precisam ser amplamente suportadas pelas CAs. Para SSH, DSA e RSA são amplamente utilizados, enquanto ECDSA pode não ser suportado por todos os clientes.
### Tamanho da chave
Os tamanhos de chave padrão podem não ser seguros, razão pela qual você deve sempre explicitamente configurar o tamanho da chave. Por exemplo, o padrão para chaves RSA é apenas 512 bits, que é simplesmente inseguro. Se você usou uma chave de 512 bits no seu servidor hoje, um intruso poderia pegar o seu certificado e usar força bruta para recuperar sua chave privada, após o que ele ou ela poderia personificar seu site. Hoje, as chaves RSA de 2.048 bits são consideradas seguras, e é isso que você deve usar. O objetivo é usar também 2.048 bits para chaves DSA e pelo menos 256 bits para ECDSA.
### Frase de senha
Usar uma senha com uma chave é opcional, mas altamente recomendado. As chaves protegidas podem ser armazenadas, transportadas e copiadas com segurança. Por outro lado, tais chaves são inconvenientes, porque eles não podem ser usados sem suas frases de acesso. Por exemplo, pode ser-lhe pedido que introduza a frase-passe sempre que pretender reiniciar o servidor Web. Para a maioria, isso é muito inconveniente ou tem implicações de disponibilidade inaceitáveis. Além disso, usar chaves protegidas na produção não aumenta realmente a segurança muito, se em tudo. Isso ocorre porque, uma vez ativadas, as chaves privadas são mantidas desprotegidas na memória do programa; Um atacante que pode chegar ao servidor pode obter as chaves a partir daí com apenas um pouco mais de esforço. Assim, frases-chave deve ser visto apenas como um mecanismo para proteger as chaves privadas quando eles não estão instalados em sistemas de produção. Em outras palavras, é bom manter frases secretas nos sistemas de produção, ao lado das teclas. Se você precisa de uma melhor segurança na produção, você deve investir em uma solução de hardware.
Para gerar uma chave RSA, use o comando genrsa:
```
$ openssl genrsa -aes128 -out fd.key 2048
Generating RSA private key, 2048 bit long modulus
....+++
......................................................................................
+++
e is 65537 (0x10001)
Enter pass phrase for fd.key: ****************
Verifying - Enter pass phrase for fd.key: ****************
```
Aqui, especifico que a chave deve ser protegida com AES-128. Você também pode usar AES-192 ou AES-256 (-aes192 e -aes256, são intercabiáveis respectivamente), mas é melhor ficar longe dos outros algoritmos (DES, 3DES e SEED).
As chaves privadas são armazenadas no chamado formato PEM[^1], que é apenas texto:
```
$ cat fd.key
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: AES-128-CBC,01EC21976A463CE36E9DB59FF6AF689A
vERmFJzsLeAEDqWdXX4rNwogJp+y95uTnw+bOjWRw1+O1qgGqxQXPtH3LWDUz1Ym
mkpxmIwlSidVSUuUrrUzIL+V21EJ1W9iQ71SJoPOyzX7dYX5GCAwQm9Tsb40FhV/
[21 lines removed...]
4phGTprEnEwrffRnYrt7khQwrJhNsw6TTtthMhx/UCJdpQdaLW/TuylaJMWL1JRW
i321s5me5ej6Pr4fGccNOe7lZK+563d7v5znAx+Wo1C+F7YgF+g8LOQ8emC+6AVV
-----END RSA PRIVATE KEY-----
```
Uma chave privada não é apenas um blob de dados aleatórios, mesmo que isso seja o que parece de relance. Você pode ver a estrutura de uma chave usando o seguinte comando rsa:
```
$ openssl rsa -text -in fd.key
Enter pass phrase for fd.key: ****************
Private-Key: (2048 bit)
modulus:
00:9e:57:1c:c1:0f:45:47:22:58:1c:cf:2c:14:db:
[...]
publicExponent: 65537 (0x10001)
privateExponent:
1a:12:ee:41:3c:6a:84:14:3b:be:42:bf:57:8f:dc:
[...]
prime1:
00:c9:7e:82:e4:74:69:20:ab:80:15:99:7d:5e:49:
[...]
prime2:
00:c9:2c:30:95:3e:cc:a4:07:88:33:32:a5:b1:d7:
[...]
exponent1:
68:f4:5e:07:d3:df:42:a6:32:84:8d:bb:f0:d6:36:
[...]
exponent2:
5e:b8:00:b3:f4:9a:93:cc:bc:13:27:10:9e:f8:7e:
[...]
coefficient:
34:28:cf:72:e5:3f:52:b2:dd:44:56:84:ac:19:00:
[...]
writing RSA key
-----BEGIN RSA PRIVATE KEY-----
[...]
-----END RSA PRIVATE KEY-----
```
Se você precisa ter apenas a parte pública de uma chave separadamente, você pode fazer isso com o seguinte comando rsa:
```
$ openssl rsa -in fd.key -pubout -out fd-public.key
Enter pass phrase for fd.key: ****************
```
Se você olhar para o arquivo recém-gerado, você verá que os marcadores indicam claramente que a informação contida é realmente pública:
```
$ cat fd-public.key 
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4WANYBE/SNBJ3QLeqsLw
tHRNi5hJyL1ftgJIYmCo+Zy+sltsJuER/5utVSoAjAGTybJ9Ra4kMnfVR+L//b2O
QzjuHDblpheoRCVXiKXiCQKiYRbZKfgj8gVnxD7T/ioWXEbRfodimDOPK9BSBh2r
CcGeQVFcw7czIE3cBYTF7AbcbwS1dugkNoHGrSLpEwG4cRhdo4bdnvgps8Kqu7SN
25ovnHkWIdUkgnREBiGLoq/Spqbyvfl6cl11MAtRDd+EkcaVMXyjYmtww3PnAlF1
RUgOyWKqEq4IqKPPR3H2zYS8scmoBUjqFRiYZzKSdZn77CjYlM3VwBlKWHT3L1s8
kQIDAQAB
-----END PUBLIC KEY-----
```
É uma boa prática verificar se a saída contém o que você está esperando. Por exemplo, se você esquecer de incluir a opção -pubout na linha de comando, a saída conterá sua chave particular em vez da chave pública.

A geração de chaves DSA é um processo de duas etapas: os parâmetros DSA são criados no primeiro passo e a chave no segundo. Ao invés de executar os passos um de cada vez, eu tendem a usar os dois comandos a seguir como um:
```
$ openssl dsaparam -genkey 2048 | openssl dsa -out dsa.key -aes128
Generating DSA parameters, 2048 bit long prime
This could take some time
[...]
read DSA key
writing DSA key
Enter PEM pass phrase: ****************
Verifying - Enter PEM pass phrase: ****************
```
Esta abordagem permite-me gerar uma chave protegida por palavra-passe sem deixar quaisquer ficheiros temporários (parâmetros DSA) e/ou chaves temporárias no disco.

O processo é semelhante para chaves ECDSA, exceto que não é possível criar chaves de tamanhos arbitrários. Em vez disso, para cada tecla você seleciona uma curva nomeada, que controla o tamanho da chave, mas também controla outros parâmetros da EC. O exemplo a seguir cria uma chave ECDSA de 256 bits usando a curva denominada secp256r1:
```
$ openssl ecparam -genkey -name secp256r1 | openssl ec -out ec.key -aes128
using curve name prime256v1 instead of secp256r1
read EC key
writing EC key
Enter PEM pass phrase: ****************
Verifying - Enter PEM pass phrase: ****************
```
OpenSSL suporta muitas curvas nomeadas (você pode obter uma lista completa fazendo `openssl ecparam -list_curves`
 ), mas, para chaves de servidor web, você está limitado a apenas duas curvas que são suportadas por todos os principais navegadores: secp256r1 (OpenSSL usa o nome prime256v1) e secp384r1.

> #######Nota
>Se você estiver usando o OpenSSL 1.0.2, você pode economizar tempo gerando chaves usando o comando `genpkey`, que foi melhorado para suportar várias chaves, tipos e parâmetros de configuração. Agora representa uma interface unificada para geração de chaves.

# Criando Solicitações de Assinatura de Certificado
Depois de ter uma chave privada, você pode continuar a criar um Certificate Signing Request (CSR). Este é um pedido formal pedindo uma CA para assinar um certificado, e ele contém a chave pública da entidade solicitando o certificado e algumas informações sobre a entidade. Estes dados serão todos parte do certificado. Um CSR é sempre assinado com a chave privada correspondente à chave pública que ele carrega.
A criação de um CSR é geralmente um processo interativo durante o qual você estará fornecendo os elementos do certificado como, por exemplo, o Common Name. Leia atentamente as instruções fornecidas pela ferramenta openssl. Se você deseja que um campo esteja vazio, você deve inserir um único ponto (.) na linha, em vez de apenas pressionar Return. Se você pressionar Return, OpenSSL preencherá o campo CSR correspondente com o valor padrão. (Esse comportamento não faz sentido quando usado com a configuração padrão do OpenSSL, que é o que praticamente todos fazem. Faz sentido quando você percebe que pode realmente mudar os padrões, modificando a configuração do OpenSSL ou fornecendo sua própria configuração dos arquivos.)
```
$ openssl req -new -key fd.key -out fd.csr
Enter pass phrase for fd.key: ****************
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:GB
State or Province Name (full name) [Some-State]:.
Locality Name (eg, city) []:London
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Feisty Duck Ltd
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:www.feistyduck.com
Email Address []:webmaster@feistyduck.com
```
>#######Nota
>De acordo com a Secção 5.4.1 do RFC 2985, o challenge password é um campo opcional que foi concebido para ser utilizado durante a revogação do certificado como uma forma de identificar a entidade original que tinha solicitado o mesmo. Se inserida, a senha será incluída textualmente na CSR e comunicada à CA. É raro encontrar um CA que se baseie neste campo; recomendamos que você deixe este campo vazio. Ter uma senha de desafio não aumenta a segurança da CSR de forma alguma. Além disso, este campo não deve ser confundido com a senha de chave, que é um recurso separado.

Depois que um CSR é gerado, use-o para assinar o seu próprio certificado e/ou enviá-lo para uma autoridade de certificação pública e pedir-lhes para assinar o certificado. Ambas as abordagens são descritas nas seções a seguir. Mas antes de fazer isso, é uma boa idéia para verificar novamente que o CSR está correto. Veja como:
```
$ openssl req -text -in fd.csr -noout
Certificate Request:
Data:
Version: 0 (0x0)
Subject: C=GB, L=London, O=Feisty Duck Ltd, CN=www.feistyduck.com...
/emailAddress=webmaster@feistyduck.com
Subject Public Key Info:
Public Key Algorithm: rsaEncryption
Public-Key: (2048 bit)
Modulus:
00:b7:fc:ca:1c:a6:c8:56:bb:a3:26:d1:df:e4:e3:
[16 more lines...]
d1:57
Exponent: 65537 (0x10001)
Attributes:
a0:00
Signature Algorithm: sha1WithRSAEncryption
a7:43:56:b2:cf:ed:c7:24:3e:36:0f:6b:88:e9:49:03:a6:91:
[13 more lines...]
47:8b:e3:28
```
# Criando CSRs de Certificados Existentes
Você pode salvar alguma digitação se estiver renovando um certificado e não quiser fazer nenhuma alteração nas informações nele apresentadas. Com o seguinte comando, você pode criar um CSR novo em folha de um certificado existente:
`$ openssl x509 -x509toreq -in fd.crt -out fd.csr -signkey fd.key`
>######Nota
>A menos que você esteja utilizando alguma forma de chave pública fixa e não quer trocá-la, é recomendado sempre gerar uma nova chave toda vez que solicitar um novo certificado, diminuindo a exposição do mesmo certificado por um longo período de tempo.

## Geração automática de CSR
A geração de CSR não precisa ser interativa. Usando um arquivo de configuração personalizado do OpenSSL, você pode automatizar o processo (como explicado nesta seção) e fazer certas coisas que não são possíveis interativamente (conforme discutido nas seções subseqüentes).
Por exemplo, digamos que queremos automatizar a geração de um CSR para www.feistyduck.com. Podemos começar por criando um arquivo fd.cnf com o seguinte conteúdo:
```
[req]
prompt = no
distinguished_name = dn
req_extensions = ext
input_password = PASSPHRASE
[dn]
CN = www.feistyduck.com
emailAddress = webmaster@feistyduck.com
O = Feisty Duck Ltd
L = London
C = GB
[ext]
subjectAltName = DNS:www.feistyduck.com,DNS:feistyduck.com
```
Agora você pode criar o CSR diretamente da linha de comando:
```
$ openssl req -new -config fd.cnf -key fd.key -out fd.csr
```
## Assinando seus próprios certificados
Se você estiver instalando um servidor com suporte a TLS para seu próprio uso, provavelmente não deseja ir a uma autoridade de certificação para obter um certificado confiável. É muito mais fácil usar apenas um certificado auto-assinado. Se você é um usuário do Firefox, na primeira visita ao site, você pode criar uma exceção de certificado, após o qual o site será tão seguro quanto se fosse protegido por um certificado de confiança pública.
Se você já tiver um CSR, crie um certificado usando o seguinte comando:
```
$ openssl x509 -req -days 365 -in fd.csr -signkey fd.key -out fd.crt
Signature ok
subject=/CN=www.feistyduck.com/emailAddress=webmaster@feistyduck.com/O=Feisty Duck ...
Ltd/L=London/C=GB
Getting Private key
Enter pass phrase for fd.key: ****************
```
Você realmente não precisa criar um CSR em uma etapa separada. O comando a seguir cria um certificado auto-assinado começando apenas com a chave:
```
$ openssl req -new -x509 -days 365 -key fd.key -out fd.crt
```
Se você não quiser responder a qualquer pergunta, use a opção -subj para fornecer as informações de assunto do certificado na linha de comando:
```
$ openssl req -new -x509 -days 365 -key fd.key -out fd.crt -subj "/C=GB/L=London/O=Feisty Duck Ltd/CN=www.feistyduck.com"
```
## Criando certificados válidos para multiplus hostnames
Por padrão, os certificados produzidos pelo OpenSSL têm apenas um nome comum e são válidos apenas para um nome de host. Devido a isso, mesmo se você tiver sites relacionados, você é forçado a usar um certificado separado para cada site. Nessa situação, usar um único certificado multidomínio faz muito mais sentido. Além disso, mesmo quando você está executando um único site, é necessário garantir que o certificado é válido para todos os caminhos possíveis que os usuários finais podem tomar para alcançá-lo. Na prática, isso significa usar pelo menos dois nomes, um com o prefixo www e um sem (ex: www.feistyduck.com and feistyduck.com).
Há dois mecanismos para suportar vários nomes de host em um certificado. O primeiro é listar todos os nomes de host desejados usando uma extensão X.509 chamada Subject lternative Name (SAN). O segundo é usar curingas. Você também pode usar uma combinação das duas abordagens quando for mais conveniente. Na prática, para a maioria dos sites, você pode especificar um nome de domínio sem FQDN e um curinga para cobrir todos os subdomínios (ex: feistyduck.com and *.feistyduck.com).
>######Atenção
>Quando um certificado contém nomes alternativos, todos os nomes comuns são ignorados. Certificados mais recentes produzidos por CAs não podem nem mesmo incluir nomes comuns. Por esse motivo, inclua todos os nomes de host desejados na lista de nomes alternativos.

Em primeiro lugar, coloque as informações de extensão em um arquivo de texto separado. Eu vou chamá-lo de fd.ext. No arquivo, especifique o nome da extensão (subjectAltName) e liste os nomes de host desejados, como no exemplo a seguir:
```
subjectAltName = DNS:*.feistyduck.com, DNS:feistyduck.com
```
Em seguida, ao usar o comando x509 para emitir um certificado, consulte o arquivo usando a opção -extfile:
```
$ openssl x509 -req -days 365 -in fd.csr -signkey fd.key -out fd.crt -extfile fd.ext
```
O resto do processo não é diferente de antes. Mas quando você examinar o certificado gerado posteriormente, você verá que ele contém a extensão SAN:
```
X509v3 extensions:
	X509v3 Subject Alternative Name:
		DNS:*.feistyduck.com, DNS:feistyduck.com
```
## Examinando Certificados
Certificados se parecem muito com apenas dados aleatórios à primeira vista, mas eles contêm uma grande quantidade de informações; você só precisa saber como descompactá-lo. O comando x509 faz exatamente isso, então use-o para ver os certificados auto-assinados que você gerou.
```
$ openssl x509 -text -in fd.crt -noout
Certificate:
Data:
Version: 1 (0x0)
Serial Number: 13073330765974645413 (0xb56dcd10f11aaaa5)
Signature Algorithm: sha1WithRSAEncryption
Issuer: CN=www.feistyduck.com/emailAddress=webmaster@feistyduck.com, ...
O=Feisty Duck Ltd, L=London, C=GB
Validity
Not Before: Jun 4 17:57:34 2012 GMT
Not After : Jun 4 17:57:34 2013 GMT
Subject: CN=www.feistyduck.com/emailAddress=webmaster@feistyduck.com, ...
O=Feisty Duck Ltd, L=London, C=GB
Subject Public Key Info:
Public Key Algorithm: rsaEncryption
Public-Key: (2048 bit)
Modulus:
00:b7:fc:ca:1c:a6:c8:56:bb:a3:26:d1:df:e4:e3:
[16 more lines...]
d1:57
Exponent: 65537 (0x10001)
Signature Algorithm: sha1WithRSAEncryption
49:70:70:41:6a:03:0f:88:1a:14:69:24:03:6a:49:10:83:20:
[13 more lines...]
74:a1:11:86
```
Normalmente, os certificados auto-assinados contêm apenas os dados de certificado mais básicos, como visto no exemplo anterior. Em comparação, os certificados emitidos por CAs públicas são muito mais interessantes, pois contêm uma série de campos adicionais (através do mecanismo de extensão X.509). Vamos ver sobre eles rapidamente.
A extensão _*Basic Constraints*_ é usada para marcar certificados como pertencentes a uma AC, o que lhes dá a capacidade de assinar outros certificados. Certificados emitidos por não-CA terão essa extensão omitida ou terão o valor de CA definida como FALSE. Esta extensão é crítica, o que significa que todos os softwares que usam certificados devem entender seu significado.
```
X509v3 Basic Constraints: critical
	CA:FALSE
```
As extensões Key Usage (KU) e Extended Key Usage (EKU) restringem como um certificado pode ser usado. Se essas extensões estiverem presentes, somente os usos listados serão permitidos. Se as extensões não estiverem presentes, não há restrições de uso. O que você vê neste exemplo é típico de um certificado de servidor da Web, que, por exemplo, não permite a assinatura de código:
```
X509v3 Key Usage: critical
	Digital Signature, Key Encipherment
X509v3 Extended Key Usage:
	TLS Web Server Authentication, TLS Web Client Authentication
```
A extensão de Pontos de Distribuição de CRL lista os endereços onde as informações da Lista de Revogação de Certificados (CRL) da CA podem ser encontradas. Essas informações são importantes nos casos em que os certificados precisam ser revogados. As CRLs são listas assinadas por CA de certificados revogados, publicados em intervalos de tempo regulares (por exemplo, sete dias).
```
X509v3 CRL Distribution Points:
Full Name:
URI:http://crl.starfieldtech.com/sfs3-20.crl
```
>#######Nota
>Você pôde ter observado que a posição de CRL não usa um usuário seguro, e você Pode estar se perguntando se o link é, portanto, inseguro. Não é. Como cada CRL é assinada Pela CA que o emitiu, os navegadores podem verificar sua integridade. De fato, se as CRLs fossem Distribuídos por TLS, os navegadores podem enfrentar um problema de galinha e ovo em que
Deseja verificar o status de revogação do certificado usado pelo servidor O próprio CRL!

A extensão Políticas de Certificado (Certificate Policies) é usada para indicar a política sob a qual o certificado foi emitido. Por exemplo, onde os indicadores de validação estendida (EV) podem ser encontrados (como no exemplo que se segue). Os indicadores são na forma de identificadores de objeto exclusivo (OIDs) e eles são exclusivos para a CA emissora. Além disso, essa extensão geralmente contém um ou mais pontos de declaração de política de certificado (Certificate Policy Statement - CPS), que geralmente são páginas da Web ou documentos PDF.
```
X509v3 Certificate Policies:
Policy: 2.16.840.1.114414.1.7.23.3
CPS: http://certificates.starfieldtech.com/repository/
```
A extensão Authority Information Access (AIA) contém duas informações importantes. Em primeiro lugar, ela lista o endereço do OCSP (Online Certificate Status Protocol), que pode ser usado para verificar a revogação de certificado em tempo real. Depois,  a extensão também pode conter um link para onde o certificado do emissor (o próximo certificado na cadeia) pode ser encontrado. Atualmente, os certificados de servidor raramente são assinados diretamente por certificados raiz confiáveis, o que significa que os usuários devem incluir um ou mais certificados intermediários em sua configuração. Os erros, dessa forma, são fáceis de acontecer e invalidam os certificados. Alguns clientes (por exemplo, o Internet Explorer) usam as informações fornecidas nesta extensão para corrigir uma cadeia de certificados incompleta, porém, muitos outros clientes não o fazem.
```
Authority Information Access:
OCSP - URI:http://ocsp.starfieldtech.com/
CA Issuers - URI:http://certificates.starfieldtech.com/repository/sf...
_intermediate.crt
```
As extensões Subject Key Identifier e Authority Key Identifier estabelecem identificadores de chave de autoridade e de assunto exclusivos, respectivamente. O valor especificado na extensão Authority Key Identifier de um certificado deve corresponder ao valor especificado na extensão Subject Key Identifier no certificado emissor. Essas informações são muito úteis durante o processo de criação de caminho de certificação, no qual um cliente está tentando encontrar todos os caminhos possíveis de um certificado folha (servidor) para um certificado raiz confiável (CA). Muitas vezes, as autoridades de certificação usam uma chave privada com mais de um certificado e este campo permite que o software identifique de forma confiável qual certificado pode ser correspondido a qual chave. No mundo real, muitas cadeias de certificados fornecidas pelos servidores são inválidas, mas esse fato muitas vezes passa despercebido porque os navegadores são capazes de encontrar caminhos de confiança alternativos.
```
X509v3 Subject Key Identifier:
4A:AB:1C:C3:D3:4E:F7:5B:2B:59:71:AA:20:63:D6:C9:40:FB:14:F1
X509v3 Authority Key Identifier:
keyid:49:4B:52:27:D1:1B:BC:F2:A1:21:6A:62:7B:51:42:7A:8A:D7:D5:56
```
Finalmente, a extensão Subject Alternative Name é usada para listar todos os nomes de host para os quais o certificado é válido. Esta extensão costumava ser opcional; se não estiver presente, os clientes recorrem as informações fornecidas no Common Name (CN), que faz parte do campo assunto. Se a extensão estiver presente, o conteúdo do campo CN será ignorado durante a validação.
```
X509v3 Subject Alternative Name:
DNS:www.feistyduck.com, DNS:feistyduck.com
```
## Conversão de Chaves e Certificados
As chaves privadas e os certificados podem ser armazenados em uma variedade de formatos, o que significa que você muitas vezes precisará convertê-los de um formato para outro. Os formatos mais comuns são:
##### Certificado Binário (DER)
Contém um certificado X.509 em sua forma bruta, usando a codificação DER ASN.1.
##### Certificado(s) ASCII (PEM)
Contém um certificado DER codificado em base64, com ----- BEGIN CERTIFICATE ----- usado como um cabeçalho e ----- END CERTIFICATE ----- como o rodapé. Geralmente visto com apenas um certificado por arquivo, embora alguns programas permitam mais de um certificado dependendo do contexto. Por exemplo, versões mais antigas do servidor web Apache requerem que o certificado do servidor esteja sozinho em um arquivo, com todos os certificados intermediários juntos em outro.
##### Chave Binária (DER)
Contém uma chave privada em seu formato bruto, usando a codificação DER ASN.1. O OpenSSL cria chaves em seu próprio formato tradicional (SSLeay). Há também um formato alternativo chamado PKCS#8 (definido no RFC 5208), mas não é amplamente utilizado. O OpenSSL também pode converter para e do formato PKCS#8 usando o comando pkcs8.
##### Chave ASCII (PEM)
Contém uma chave DER codificada em base64, às vezes com metadados adicionais (por exemplo, o algoritmo usado para proteção por senha).
##### Certificado(s) PKCS#7
É um formato complexo projetado para o transporte de dados assinados ou criptografados, definidos na RFC 2315. Geralmente é visto com extensões .p7b e .p7c e pode incluir toda a cadeia de certificados conforme necessário. Este formato é suportado pelo utilitário keytool do Java.
##### Chave(s) e Certificado(s) PKCS#12 (PFX)
Um formato complexo que pode armazenar e proteger uma chave de servidor junto com uma cadeia de certificados inteira. É comumente visto com extensões .p12 e .pfx. Esse formato é comumente usado em produtos Microsoft, mas também é usado para certificados de cliente. Nestes dias, o nome PFX é usado como um sinônimo para PKCS#12, embora PFX tenha se referido a uma formato diferente há muito tempo atrás (uma versão anterior do PKCS#12). É improvável que você encontre a versão antiga em qualquer lugar.
### Conversão PEM e DER
A conversão de certificados entre os formatos PEM e DER é executada com a ferramenta x509. Para converter um certificado do formato PEM para DER:
```
$ openssl x509 -inform PEM -in fd.pem -outform DER -out fd.der
```
Para converter um certificado do formato DER para PEM:
```
$ openssl x509 -inform DER -in fd.der -outform PEM -out fd.pem
```
A sintaxe é idêntica se você precisa converter chaves privadas entre formatos DER e PEM, porém são usados comandos diferentes: rsa para chaves RSA e dsa para chaves DSA.
### Conversão PKCS#12 (PFX)
Um comando é tudo o que é necessário para converter a chave e certificados no formato PEM para PKCS#12. O exemplo a seguir converte uma chave (fd.key), um certificado (fd.crt) e os certificados intermediários (fd-chain.crt) em um único arquivo PKCS#12:
```
$ openssl pkcs12 -export \
-name "My Certificate" \
-out fd.p12 \
-inkey fd.key \
-in fd.crt \
-certfile fd-chain.crt
Enter Export Password: ****************
Verifying - Enter Export Password: ****************
```
A conversão reversa não é tão direta. Você pode usar um único comando, mas nesse caso você terá todo o conteúdo em um único arquivo:
```
$ openssl pkcs12 -in fd.p12 -out fd.pem -nodes
```
Agora, você deve abrir o arquivo fd.pem no seu editor favorito e dividi-lo manualmente em arquivos individuais de chaves, certificados e arquivos de certificados intermediários. Enquanto estiver fazendo isso, você notará um conteúdo adicional fornecido antes de cada componente. Por exemplo:
```
Bag Attributes
localKeyID: E3 11 E4 F1 2C ED 11 66 41 1B B8 83 35 D2 DD 07 FC DE 28 76
subject=/1.3.6.1.4.1.311.60.2.1.3=GB/2.5.4.15=Private Organization...
/serialNumber=06694169/C=GB/ST=London/L=London/O=Feisty Duck Ltd...
/CN=www.feistyduck.com
issuer=/C=US/ST=Arizona/L=Scottsdale/O=Starfield Technologies, Inc./OU=http:/...
/certificates.starfieldtech.com/repository/CN=Starfield Secure Certification ...
Authority
-----BEGIN CERTIFICATE-----
MIIF5zCCBM+gAwIBAgIHBG9JXlv9vTANBgkqhkiG9w0BAQUFADCB3DELMAkGA1UE
BhMCVVMxEDAOBgNVBAgTB0FyaXpvbmExEzARBgNVBAcTClNjb3R0c2RhbGUxJTAj
[...]
```
Estes metadados adicionais são muito úteis para identificar rapidamente os certificados. Obviamente, você deve garantir que o arquivo de certificado principal contenha o certificado do servidor e não outra coisa. Além disso, você deve também garantir que os certificados intermediários são fornecidos na ordem correta, com o certificado de emissão seguindo o assinado. Se você vir um certificado raiz auto-assinado, sinta-se livre para excluí-lo ou armazená-lo em outro lugar; não deve entrar na cadeia.
>######Atenção
>A saída de conversão final não deve conter nada além da chave codificada e os certificados. Embora algumas ferramentas sejam inteligentes o suficiente para ignorar o que não é necessário, outras ferramentas não são. Deixar dados extras em arquivos PEM pode resultar em problemas difíceis de solucionar.

É possível usar o OpenSSL para dividir os componentes para você, mas isso requer várias invocações do comando pkcs12 (incluindo digitar a senha do pacote a cada vez):
```
$ openssl pkcs12 -in fd.p12 -nocerts -out fd.key -nodes
$ openssl pkcs12 -in fd.p12 -nokeys -clcerts -out fd.crt
$ openssl pkcs12 -in fd.p12 -nokeys -cacerts -out fd-chain.crt
```
Esta abordagem não vai poupar muito trabalho. Você ainda deve examinar cada arquivo para garantir que ele contém o conteúdo correto e para remover os metadados.
### Conversão PKCS#7
Para converter de PEM para PKCS#7, use o comando crl2pkcs7:
```
$ openssl crl2pkcs7 -nocrl -out fd.p7b -certfile fd.crt -certfile fd-chain.crt
```
Para converter de PKCS#7 para PEM, use o comando pkcs7 com a opção -print_certs:
```
$ openssl pkcs7 -in fd.p7b -print_certs -out fd.pem
```
Semelhante à conversão de PKCS#12, agora você deve editar o arquivo fd.pem para limpá-lo e dividi-lo nos componentes desejados.
## Configuração
Nesta seção, discutirei dois tópicos relevantes para a implantação de TLS. A primeira é a configuração do conjunto de criptografia, na qual você especifica qual das muitas suítes disponíveis no TLS você deseja usar para comunicação. Esse tópico é importante porque praticamente todos os programas que usam o OpenSSL reutilizam o mecanismo de configuração do seu conjunto. Isso significa que uma vez aprendido a configurar um conjunto de cifras para um programa, você pode reutilizar o mesmo conhecimento em outro lugar. O segundo tópico é sobre a medição de desempenho das operações de criptografia em seu estado natural.
### Seleção da suíte de criptografia
Uma tarefa comum na configuração do servidor TLS é selecionar quais conjuntos de cifra serão suportados. Para se comunicar de forma segura, o TLS precisa decidir exatamente quais cifras criptográficas serão usads para atingir seus objetivos (por exemplo, confidencialidade). Isso é feito selecionando um conjunto de criptografia adequado, que faz uma série de decisões sobre como a autenticação, a troca de chaves, a criptografia e outras operações são feitas. Os programas que dependem do OpenSSL geralmente adotam a mesma abordagem para a configuração do conjunto de ferramentas suportadas pelo OpenSSL, simplesmente passando as opções nos arquivos de configuração. Por exemplo, no httpd do Apache, a configuração da suite de criptografia pode ter esta aparência:
```
SSLHonorCipherOrder On
SSLCipherSuite "HIGH:!aNULL:@STRENGTH"
```
A primeira linha define a ordem de preferência da criptografia do servidor (e configura o httpd para selecionar ativamente as suítes). A segunda linha controla quais suítes serão suportados.
Chegar a uma boa configuração do conjunto criptográfico pode ser muito demorado, e há muitos detalhes a considerar. A melhor abordagem é usar o comando _ciphers_ do OpenSSL  para determinar quais suites são habilitadas com uma seqüência de configuração específica.
```
openssl ciphers -v 'ALL:COMPLEMENTOFALL'
ECDHE-RSA-AES256-GCM-SHA384 TLSv1.2 Kx=ECDH     Au=RSA  Enc=AESGCM(256) Mac=AEAD
ECDHE-ECDSA-AES256-GCM-SHA384 TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AESGCM(256) Mac=AEAD
ECDHE-RSA-AES256-SHA384 TLSv1.2 Kx=ECDH     Au=RSA  Enc=AES(256)  Mac=SHA384
ECDHE-ECDSA-AES256-SHA384 TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AES(256)  Mac=SHA384
ECDHE-RSA-AES256-SHA    SSLv3 Kx=ECDH     Au=RSA  Enc=AES(256)  Mac=SHA1
[106 linhas a mais]
```
>######Atenção
>Se você estiver usando o OpenSSL 1.0.0 ou posterior, você também pode usar a opção -V para solicitar saída extra-verbosa. Neste modo, a saída também conterá IDs de suite, que são sempre úteis ter. Por exemplo, o OpenSSL nem sempre usa os nomes de RFC para as suítes; em tais casos, você deve usar os IDs para cruzar a verificação.

No meu caso, havia 111 suites na saída. Cada linha contém informações sobre um pacote e as seguintes informações:
