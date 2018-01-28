<HTML>
<HEAD>
<TITLE>Criando um Portal de Not�cias Baseado em PHP/MySQL</TITLE>
</HEAD>

<BODY>

<h1>Criando um Portal de Not�cias baseado em PHP/MySQL</h1>

<p>Ciro Feitosa
<br><a href="mailto:ciro@futtura.net">ciro@futtura.net</a><br>
Escrito em: 20/07/2000</p>


<p>&nbsp;</p>
<h3>1.� Passo - Criando e preparando o Banco de Dados (MySQL)</h3>

<div align="justify">
<p>Comece criando um banco de dados dedicado a este tutorial. Por exemplo, com o
nome not�cias; se j� estiver no cliente MySQL, digite o seguinte:

<pre>
create database <b>noticias;</b>
</pre>

<p>Por conseguinte, abra o banco de dados criado:

<pre>
use <b>noticias;</b>
</pre>

<p>Agora � criar uma tabela para cadastro das suas not�cias. Voc� pode seguir o exemplo abaixo, superpr�tico:

<pre>
CREATE TABLE noticias (
id int(5) NOT NULL auto_increment,
nome char(30) NOT NULL ,
sobrenome char(30) NOT NULL ,
cidade char(50) NOT NULL ,
estado char(2) NOT NULL ,
email char(80) ,
data date NOT NULL,
hora time NOT NULL ,
titulo char(100) NOT NULL ,
subtitulo char(200) ,
texto text NOT NULL ,
ver char(3) DEFAULT 'off' ,
PRIMARY KEY (id),
UNIQUE id (id)
);
</pre>

<p>Se voc� j� tiver uma base de conhecimento em SQL, poder� saber o que cada linha acima realizar�. Irei especificar o que voc� ir� cadastrar em cada campo:

<p>
<li>id = Campo de identifica��o da not�cia (n�o � necess�rio cadastrar nenhum
dado, pois ele j� est� habilitado com a fun��o auto_increment que,
automaticamente, ir� inserindo novos valores)</li>

<li>nome = Primeiro nome do autor da not�cia</li>

<li>sobrenome = Sobrenome do autor da not�cia</li>

<li>cidade = Cidade do autor</li> 

<li>estado = Estado da cidade (especificada com apenas 2 caracteres)</li>

<li>email = Email do autor, para contatos</li>

<li>data = Data utilizada, para saber quando foi realizado o cadastro (n�o ser�
necess�rio nenhum cadastro, pois faremos isso no php automaticamente, inserindo
a data atual)</li>

<li>hora = Hora utilizada no cadastro da not�cias (tamb�m n�o � necess�rio o
cadastro, pois ser� feito automaticamente com o PHP)</li>

<li>t�tulo = T�tulo da not�cia (m�ximo de 100 caracteres)</li>

<li>subt�tulo = Pequeno resumo da sua not�cia (m�ximo de 200 caracteres)</li>

<li>texto = Agora sim, o texto da sua not�cia, sem limite de caracteres</li>

<li>ver = Este campo � curioso. Ele ser� utilizado para o webmaster poder
autorizar cada not�cia, pois caso n�o tivesse um campo parecido, toda not�cia
cadastrada iria para o site. � como um controle de not�cias. O padr�o aqui, �
<i>off</i>, assim toda not�cia primeiro ser� passada para o webmaster, para
depois ser validada.</li>

<p>* s�o campos obrigat�rios no cadastro

<p>Agora com o banco de dados preparado, � hora de criarmos o sistema de cadastro de not�cias do seu site. Este ser� o 2.� passo!



<p>&nbsp;</p>
<p>&nbsp;</p>
<h3>2� Passo - Criando o sistema de cadastro de not�cias</h3>


<p>Este � um passo importante, onde um script criado em PHP ir� inserir
dados no banco de dados MySQL. Aqui iremos utilizar os conhecimentos passados no
tutorial anterior, sobre quest�es b�sicas de PHP/MySQL. Primeiramente ser�
criado o arquivo em HTML (formul�rio) para o cadastro de not�cias. Vamos l�:


<pre>
ARQUIVO cadastra.php
&lt;?php

$data = date("Y-m-d");
$hora = date("H:i:s");
$novadata = substr($data,8,2) . "/" .substr($data,5,2) . "/" . substr($data,0,4);
$novahora = substr($hora,0,2) . "h" .substr($hora,3,2) . "min";

echo "&lt;h1&gt;Sistema de Cadastro de Not�cias&lt;/h1&gt;";
echo "&lt;hr&gt;&lt;br&gt;";
echo "&lt;form action='inserir.php' method='post'&gt;";
echo "Nome:&lt;input name='nome' type='text' size=30&gt; *&lt;br&gt;";
echo "Sobrenome:&lt;input name='sobrenome' type='text' size=30&gt; *&lt;br&gt;";
echo "Cidade:&lt;input name='cidade' type='text' size=30&gt; *&lt;br&gt;";
echo "Estado:&lt;i&gt;(Exemplo: SP, RS, BA)&lt;/i&gt;&lt;input name='estado' type='text' size=5&gt; *&lt;br&gt;";
echo "Email: &lt;i&gt;(Exemplo: feitosac@yahoo.com)&lt;/i&gt;&lt;input name='email' type='text' size=30&gt;&lt;br&gt;&lt;br&gt;";
echo "T�tulo do Texto:&lt;input name='titulo' type='text' size=30&gt; *&lt;br&gt;";
echo "Subt�tulo do Texto:&lt;textarea name='subtitulo' rows=5 cols=30&gt;&lt;/textarea&gt;&lt;br&gt;";
echo "Texto:&lt;textarea name='texto' rows=10 cols=30&gt;&lt;/textarea&gt; *&lt;br&gt;";
echo "&lt;input name='data' type='hidden' value='$data'&lt;&gt;input name='hora' type='hidden' value='$hora'&gt;";
echo "&lt;input type='submit' value='Cadastrar'&gt;";
echo "&lt;/form&gt;";
echo "&lt;br&gt;&lt;hr&gt;";
echo "&lt;i&gt;Campos marcados com &lt;b&gt;*&lt;/b&gt; s�o obrigat�rios no cadastro.&lt;br&gt;";
echo "&lt;b&gt;Observa��o&lt;/b&gt;: Ser� inserido no seu cadastro a data atual, bem como a hora atual do cadastro&lt;br&gt;";
echo "Data: $novadata - Hora: $novahora&lt;br&gt;";

?&gt;
FIM DO ARQUIVO cadastra.php
</pre>

<li>Vamos realizar uma pequena an�lise neste arquivo. Repare que os dados do
formul�rio ser�o enviados para o script "inserir.php", este, por conseguinte,
ser� o respons�vel pela inser��o desta not�cia no MySQL. Outro ponto, � que n�o
existem os campos <b>id</b>, <b>ver</b>, estes, como expliquei, ser�o inseridos
automaticamente pelo MySQL, e os campos <b>data</b>, <b>hora</b>, ser�o
inseridos pelo PHP.</li> <li>Agora � hora de criar o script PHP respons�vel por
isto tudo. Vamos nessa:</li>

<pre>
ARQUIVO inserir.php
&lt;?php

//Vamos definir as vari�veis de data e hora
//para inser��o no banco de dados

//Agora com as vari�veis de data e hora criadas
//vamos criar uma vari�vel especial para a querie sql

$sql = "INSERT INTO noticias (nome, sobrenome, cidade, estado, email, data, hora, 
titulo, subtitulo, texto) VALUES ('$nome', '$sobrenome', '$cidade', '$estado', 
'$email', '$data', '$hora', '$titulo', '$subtitulo', '$texto')";

//Agora � hora de contatar o mysql

$conexao = mysql_connect("localhost", "root", "root")
or die ("Configura��o de Banco de Dados Errada!");

//Substitua os valores acima caso n�o esteje de acordo com sua m�quina
//Selecionando o banco de dados...

$db = mysql_select_db("noticias")
or die ("Banco de Dados Inexistente!");

//Inserindo os dados

$sql = mysql_query($sql) 
or die ("Houve erro na grava��o dos dados, por favor, clique em voltar e verifique os campos obrigat�rios!");

echo "&lt;h1&gt;Cadastro efetuado com sucesso!&lt;/h1&gt;";

?&gt;
FIM DO ARQUIVO inserir.php

</pre>


<li>Voc� pode aperfei�oar muito mais o script. Por exemplo, personalizar a
mensagem de erro e de �xito, inserir um link para cadastrar novamente, etc.</li>

<li>Agora vamos para o pr�ximo e �ltimo passo, "Recuperando os dados
cadastrados"</li>


<p>&nbsp;</p>
<p>&nbsp;</p>
<h3>3.� Passo - Recuperando os dados cadastrados</h3>

<p>Irei mostrar como selecionar, por exemplo, as �ltimas 15 not�cias inseridas
no MySQL; isto � muito �til, para sites que t�m se��es do tipo "�ltimas
Not�cias". Isto � feito com PHP novamente; fa�a conforme o exemplo abaixo, e
salve como um arquivo em PHP.

<pre>
ARQUIVO noticias.php
&lt;?php

//Vamos precisar contar o MySQL novamente

$conexao = mysql_connect("localhost","root","root");
$db = mysql_select_db("noticias");

//Agora � realizar a querie de busca no banco de dados

$sql = "SELECT * FROM noticias WHERE ver = 'on' ORDER BY id DESC LIMIT 15";

// Ir� selecionar as �ltimas 15 not�cias inseridas

// O curioso aqui, � que ele s� ir� selecionar os campos onde
// estiver o ver=on, isto foi discutido logo atr�s, como um 
// controle de not�cias pelo webmaster
// Por padr�o o MySQL colocou off, mas o webmaster ter� que 
// revisar as not�cias e alterar o campo ver para as que quiser validar.

$resultado = mysql_query($sql)
or die ("N�o foi poss�vel realizar a consulta ao banco de dados");

// Agora iremos "pegar" cada campo da not�cia
// e organizar no HTML

while ($linha=mysql_fetch_array($resultado)) {

$id = $linha["id"];
$nome = $linha["nome"];
$sobrenome = $linha["sobrenome"];
$cidade = $linha["cidade"];
$estado = $linha["estado"];
$email = $linha["email"];
$data = $linha["data"];
$hora = $linha["hora"];
$titulo = $linha["titulo"];
$subtitulo = $linha["subtitulo"];
$texto = $linha["texto"];
$ver = $linha["ver"];

$novadata = substr($data,8,2) . "/" .substr($data,5,2) . "/" . substr($data,0,4);
$novahora = substr($hora,0,2) . "h" .substr($hora,3,2) . "min";

echo "&lt;b&gt;C�digo da Not�cia&lt;/b&gt;: $id";
echo "&lt;br&gt;";
echo "Autor: $nome $sobrenome - ($email)";
echo "&lt;br&gt;";
echo "Cidade: $cidade - Estado: $estado";
echo "&lt;br&gt;";
echo "Data: $novadata - Hor�rio: $novahora";
echo "&lt;br&gt;";
echo "T�tulo da Not�cia: $titulo";
echo "&lt;br&gt;";
echo "Subt�tulo da Not�cia: &lt;i&gt; $subtitulo &lt;/i&gt;";
echo "&lt;br&gt;";
echo "Not�cia: $texto";
echo "&lt;br&gt;";
echo "Validado pelo Webmaster: ";
if ($ver=on) { echo "Sim"; } else { echo "N�o"; }
echo "&lt;hr&gt;";

}

?&gt;
FIM DO ARQUIVO noticias.php
</pre>

<li>Viu como � super simples? Neste script criamos uma vari�vel para cada campo
da tabela, assim fica mais f�cil de manusear os dados de qualquer forma. Nas
vari�vels <b>novadata</b>, <b>novahora</b>, crie uma fun��o para mostrar as
vari�veis de uma forma melhor. (agradecimentos a RENAS - Amig�o!)</li>

<li>Voc� ainda pode personalizar estas not�cias, deixando o layout do seu
jeito!</li>

<li>OBS: para mostrar todas as not�cias em vez de s� as �ltimas 15, apenas
crie uma nova vari�vel $sql, como esta abaixo:</li>

<pre>
$sql = "SELECT * FROM noticias WHERE ver = 'on' ORDER BY id DESC";
</pre>

<li>Pronto! Foi s� retirar "LIMIT 15". ;)</li>


<p>&nbsp;</p>
<p>&nbsp;</p>
<h3>4.� Passo - Controle de Not�cias para Webmaster</h3>

<p>Neste passo irei explicar como mostrar todos os dados da tabela, para
podermos modific�-los, apag�-los, etc. Primeiramente, devemos criar um arquivo
PHP para mostrar todos os dados na tela, para depois podermos manuse�-los. Fa�a
como o exemplo abaixo:

<pre>
ARQUIVO controle.php
&lt;?php

$conexao = mysql_connect("localhost","root","root");
$db = mysql_select_db("noticias");
$sql = "SELECT * FROM noticias ORDER BY id DESC";
$resultado = mysql_query($sql)
or die ("N�o foi poss�vel realizar a consulta ao banco de dados");

echo "&lt;table width=740 border=1 cellpadding=1 cellspacing=1&gt;";
echo "&lt;tr&gt;";
echo "&lt;th width=15&gt;ID:&lt;/th&gt;";
echo "&lt;th width=100&gt;Nome:&lt;/th&gt;";
echo "&lt;th width=100&gt;Sobrenome:&lt;/th&gt;";
echo "&lt;th width=100&gt;Cidade:&lt;/th&gt;";
echo "&lt;th width=15&gt;UF:&lt;/th&gt;";
echo "&lt;th width=100&gt;Email:&lt;/th&gt;";
echo "&lt;th width=30&gt;Data:&lt;/th&gt;";
echo "&lt;th width=30&gt;Hora:&lt;/th&gt;";
echo "&lt;th width=100&gt;T�tulo:&lt;/th&gt;";
echo "&lt;th width=50&gt;Dispon�vel?&lt;/th&gt;";
echo "&lt;th width=50&gt;Alterar&lt;/th&gt;";
echo "&lt;th width=50&gt;Excluir&lt;/th&gt;";
echo "&lt;/tr&gt;";

while ($linha=mysql_fetch_array($resultado)) {
$id = $linha["id"];
$nome = $linha["nome"];
$sobrenome = $linha["sobrenome"];
$cidade = $linha["cidade"];
$estado = $linha["estado"];
$email = $linha["email"];
$data = $linha["data"];
$hora = $linha["hora"];
$titulo = $linha["titulo"];
$ver = $linha["ver"];

$novadata = substr($data,8,2) . "/" .substr($data,5,2) . "/" . substr($data,0,4);
$novahora = substr($hora,0,2) . "h" .substr($hora,3,2) . "min";


echo "&lt;tr&gt;";
echo "&lt;th width=15&gt;$id&lt;br&gt;&lt;/th&gt;";
echo "&lt;th width=100&gt;$nome&lt;br&gt;&lt;/th&gt;";
echo "&lt;th width=100&gt;$sobrenome&lt;br&gt;&lt;/th&gt;";
echo "&lt;th width=100&gt;$cidade&lt;br&gt;&lt;/th&gt;";
echo "&lt;th width=15&gt;$estado&lt;br&gt;&lt;/th&gt;";
echo "&lt;th width=100&gt;$email&lt;br&gt;&lt;/th&gt;";
echo "&lt;th width=30&gt;$novadata&lt;br&gt;&lt;/th&gt;";
echo "&lt;th width=30&gt;$novahora&lt;br&gt;&lt;/th&gt;";
echo "&lt;th width=100&gt;$titulo&lt;br&gt;&lt;/th&gt;";
echo "&lt;th width=50&gt;$ver&lt;br&gt;&lt;/th&gt;";
echo "&lt;th width=50&gt;&lt;a href='alterar.php?id=$id'&gt;Alterar&lt;/a&gt;&lt;br&gt;&lt;/th&gt;";
echo "&lt;th width=50&gt;&lt;a href='excluir.php?id=$id'&gt;Excluir&lt;/a&gt;&lt;br&gt;&lt;/th&gt;";
echo "&lt;/tr&gt;";
echo "&lt;br&gt;";

}

echo "&lt;/table&gt;";

?>
FIM DO ARQUIVO controle.php
</pre>

<p>O pr�ximo passo agora � criar os arquivos <b>alterar.php</b> e
<b>excluir.php</b>, respons�veis pela altera��o e exclus�o dos dados. � muito
simples o c�digo, veja s�:

<pre>
ARQUIVO excluir.php
&lt;?php

$conexao = mysql_connect("localhost","root","root");
$db = mysql_select_db("noticias");
$sql = �DELETE FROM noticias WHERE id='$id'�;
$resultado = mysql_query($sql)
or die ("N�o foi poss�vel realizar a exclus�o dos dados.");
echo �&lt;h1&gt;A not�cia foi exclu�da com �xito!&lt;/h1&gt;�;

?&gt;
FIM DO ARQUIVO excluir.php

ARQUIVO alterar.php
&lt;?php

$conexao = mysql_connect("localhost","root","root");
$db = mysql_select_db("noticias");
$sql = "SELECT * FROM noticias WHERE id='$id'";
$resultado = mysql_query($sql)
or die ("N�o foi poss�vel realizar a consulta ao banco de dados");

while ($linha=mysql_fetch_array($resultado)) {
$id = $linha["id"];
$nome = $linha["nome"];
$sobrenome = $linha["sobrenome"];
$cidade = $linha["cidade"];
$estado = $linha["estado"];
$email = $linha["email"];
$data = $linha["data"];
$hora = $linha["hora"];
$titulo = $linha["titulo"];
$subtitulo = $linha["subtitulo"];
$texto = $linha["texto"];
$ver = $linha["ver"];

$novadata = substr($data,8,2) . "/" .substr($data,5,2) . "/" . substr($data,0,4);
$novahora = substr($hora,0,2) . "h" .substr($hora,3,2) . "min";

echo "&lt;h1&gt;Alterar Cadastro...&lt;/h1&gt;";
echo "&lt;hr&gt;&lt;br&gt;";
echo "&lt;form action='alterar_db.php?id=$id' method='post'&gt;";
echo "C�digo da Not�cia: &lt;input name='id_novo' type='text' value='$id' size=20&gt;&lt;br&gt;";
echo "Data: $novadata&lt;br&gt;";
echo "Hora: $novahora&lt;br&gt;";
echo "Nome:&lt;input name='nome_novo' type='text' value='$nome' size=30&gt; *&lt;br&gt;";
echo "Sobrenome:&lt;input name='sobrenome_novo' type='text' value='$sobrenome' size=30&gt; *&lt;br&gt;";
echo "Cidade:&lt;input name='cidade_novo' type='text' value='$cidade' size=30&gt; *&lt;br&gt;";
echo "Estado:&lt;i&gt;(Exemplo: SP, RS, BA)&lt;/i&gt;&lt;input name='estado_novo' type='text' 
value='$estado' size=5&gt; *&lt;br&gt;";
echo "Email: &lt;i&gt;(Exemplo: feitosac@yahoo.com)&lt;/i&gt;&lt;input name='email_novo' type='text' 
value='$email' size=30&gt;&lt;br&gt;&lt;br&gt;";
echo "T�tulo do Texto:&lt;input name='titulo_novo' type='text' value='$titulo' size=30&gt; *&lt;br&gt;";
echo "Subt�tulo do Texto:&lt;textarea name='subtitulo_novo' rows=5 cols=30&gt;$subtitulo&lt;/textarea&gt;&lt;br&gt;";
echo "Texto:&lt;textarea name='texto_novo' rows=10 cols=30&gt;$texto&lt;/textarea&gt; *&lt;br&gt;";
echo "Disponibilizar? (on ou off): &lt;input name='ver_novo' type='text' value='$ver' size=5&gt;&lt;br&gt;";
echo "&lt;input type='submit' value='Alterar'&gt;";
echo "&lt;/form&gt;";
echo "&lt;br&gt;&lt;hr&gt;";
}

?&gt;
FIM DO ARQUIVO alterar.php
</pre>

<p>Agora basta criarmos o arquivo <b>alterar_db.php</b> que ir� receber os dados
deste arquivo (alterar.php) e alterar� seus respectivos dados no MySQL. � muito
simples:

<pre>
ARQUIVO alterar_db.php
&lt;?php

$conexao = mysql_connect("localhost","root","root");
$db = mysql_select_db("noticias");
$sql = "UPDATE noticias SET id='$id_novo',nome='$nome_novo',sobrenome='$sobrenome_novo'
,cidade='$cidade_novo',estado='$estado_novo',email='$email_novo',titulo='$titulo_novo'
,subtitulo='$subtitulo_novo',texto='$texto_novo',ver='$ver_novo' WHERE id='$id'";
$resultado = mysql_query($sql)
or die ("N�o foi poss�vel realizar a consulta ao banco de dados");
echo "&lt;h1&gt;Not�cia alterada com sucesso!&lt;/h1&gt;";

?&gt;
FIM DO ARQUIVO alterar_db.php
</pre>


<p>Finalmente, chegamos ao fim deste tutorial, que lhe ajudou a criar um
"Portal de Not�cias baseado em PHP/MySQL". Queria, por fim, agradecer a
todos que me apoiaram, inclusive a um amig�o, RENAS
(<a href="http://www.linuxfunciona.com.br" target="_blank">www.linuxfunciona.com.br</a>). Quer aprender mais sobre PHP? Leia, pesquise,
pratique! Assim voc� voc� vai poder se tornar um grande programador em PHP;
no box "para saber mais" indico bons sites sobre este assunto.

<p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table bgcolor="#E8E8E8">

<tr>
<td>
<p><b>Para saber mais</b>

<p>

<li><a href="http://www.php.net" target="_blank">www.php.net</a> - Site oficial
do PHP</li>

<li><a href="http://www.scriptbrasil.com" target="_blank">www.scripbrasil.com</a> - Not�cias, F�rums, Scripts, etc.</li>

<li><a href="http://www.linuxfunciona.com.br" target="_blank">www.linuxfunciona.com.br</a> - F�rum de PHP e Linux.</li>

<li><a href="http://www.1001tutorials.com/php/index.shtml" target="_blank">www.1001tutorials.com/php/index.shtm</a> - Bons tutoriais sobre PHP</li>

<li><a href="http://www.mysql.com" target="_blank">www.mysql.com</a> - Site oficial do MySQL</li>

<li><a href="http://www.phpbuilder.com" target="_blank">www.phpbuilder.com</a> - Bom site para discuss�o entre programadores de PHP</li>

<li><a href="http://www.devshed.com target="_blank">www.devshed.com</a> - Tutoriais, artigos de revistas, etc.</li>

<li><a href="http://www.webmonkey.com" target="_blank">www.webmonkey.com</a> - Sites com mat�rias exclusivas sobre PHP</li>

</td>
</tr>
</table>



</BODY>
</HTML>
