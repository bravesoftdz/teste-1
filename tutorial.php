<HTML>
<HEAD>
<TITLE>Criando um Portal de Notícias Baseado em PHP/MySQL</TITLE>
</HEAD>

<BODY>

<h1>Criando um Portal de Notícias baseado em PHP/MySQL</h1>

<p>Ciro Feitosa
<br><a href="mailto:ciro@futtura.net">ciro@futtura.net</a><br>
Escrito em: 20/07/2000</p>


<p>&nbsp;</p>
<h3>1.º Passo - Criando e preparando o Banco de Dados (MySQL)</h3>

<div align="justify">
<p>Comece criando um banco de dados dedicado a este tutorial. Por exemplo, com o
nome notícias; se já estiver no cliente MySQL, digite o seguinte:

<pre>
create database <b>noticias;</b>
</pre>

<p>Por conseguinte, abra o banco de dados criado:

<pre>
use <b>noticias;</b>
</pre>

<p>Agora é criar uma tabela para cadastro das suas notícias. Você pode seguir o exemplo abaixo, superprático:

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

<p>Se você já tiver uma base de conhecimento em SQL, poderá saber o que cada linha acima realizará. Irei especificar o que você irá cadastrar em cada campo:

<p>
<li>id = Campo de identificação da notícia (não é necessário cadastrar nenhum
dado, pois ele já está habilitado com a função auto_increment que,
automaticamente, irá inserindo novos valores)</li>

<li>nome = Primeiro nome do autor da notícia</li>

<li>sobrenome = Sobrenome do autor da notícia</li>

<li>cidade = Cidade do autor</li> 

<li>estado = Estado da cidade (especificada com apenas 2 caracteres)</li>

<li>email = Email do autor, para contatos</li>

<li>data = Data utilizada, para saber quando foi realizado o cadastro (não será
necessário nenhum cadastro, pois faremos isso no php automaticamente, inserindo
a data atual)</li>

<li>hora = Hora utilizada no cadastro da notícias (também não é necessário o
cadastro, pois será feito automaticamente com o PHP)</li>

<li>título = Título da notícia (máximo de 100 caracteres)</li>

<li>subtítulo = Pequeno resumo da sua notícia (máximo de 200 caracteres)</li>

<li>texto = Agora sim, o texto da sua notícia, sem limite de caracteres</li>

<li>ver = Este campo é curioso. Ele será utilizado para o webmaster poder
autorizar cada notícia, pois caso não tivesse um campo parecido, toda notícia
cadastrada iria para o site. É como um controle de notícias. O padrão aqui, é
<i>off</i>, assim toda notícia primeiro será passada para o webmaster, para
depois ser validada.</li>

<p>* são campos obrigatórios no cadastro

<p>Agora com o banco de dados preparado, é hora de criarmos o sistema de cadastro de notícias do seu site. Este será o 2.º passo!



<p>&nbsp;</p>
<p>&nbsp;</p>
<h3>2º Passo - Criando o sistema de cadastro de notícias</h3>


<p>Este é um passo importante, onde um script criado em PHP irá inserir
dados no banco de dados MySQL. Aqui iremos utilizar os conhecimentos passados no
tutorial anterior, sobre questões básicas de PHP/MySQL. Primeiramente será
criado o arquivo em HTML (formulário) para o cadastro de notícias. Vamos lá:


<pre>
ARQUIVO cadastra.php
&lt;?php

$data = date("Y-m-d");
$hora = date("H:i:s");
$novadata = substr($data,8,2) . "/" .substr($data,5,2) . "/" . substr($data,0,4);
$novahora = substr($hora,0,2) . "h" .substr($hora,3,2) . "min";

echo "&lt;h1&gt;Sistema de Cadastro de Notícias&lt;/h1&gt;";
echo "&lt;hr&gt;&lt;br&gt;";
echo "&lt;form action='inserir.php' method='post'&gt;";
echo "Nome:&lt;input name='nome' type='text' size=30&gt; *&lt;br&gt;";
echo "Sobrenome:&lt;input name='sobrenome' type='text' size=30&gt; *&lt;br&gt;";
echo "Cidade:&lt;input name='cidade' type='text' size=30&gt; *&lt;br&gt;";
echo "Estado:&lt;i&gt;(Exemplo: SP, RS, BA)&lt;/i&gt;&lt;input name='estado' type='text' size=5&gt; *&lt;br&gt;";
echo "Email: &lt;i&gt;(Exemplo: feitosac@yahoo.com)&lt;/i&gt;&lt;input name='email' type='text' size=30&gt;&lt;br&gt;&lt;br&gt;";
echo "Título do Texto:&lt;input name='titulo' type='text' size=30&gt; *&lt;br&gt;";
echo "Subtítulo do Texto:&lt;textarea name='subtitulo' rows=5 cols=30&gt;&lt;/textarea&gt;&lt;br&gt;";
echo "Texto:&lt;textarea name='texto' rows=10 cols=30&gt;&lt;/textarea&gt; *&lt;br&gt;";
echo "&lt;input name='data' type='hidden' value='$data'&lt;&gt;input name='hora' type='hidden' value='$hora'&gt;";
echo "&lt;input type='submit' value='Cadastrar'&gt;";
echo "&lt;/form&gt;";
echo "&lt;br&gt;&lt;hr&gt;";
echo "&lt;i&gt;Campos marcados com &lt;b&gt;*&lt;/b&gt; são obrigatórios no cadastro.&lt;br&gt;";
echo "&lt;b&gt;Observação&lt;/b&gt;: Será inserido no seu cadastro a data atual, bem como a hora atual do cadastro&lt;br&gt;";
echo "Data: $novadata - Hora: $novahora&lt;br&gt;";

?&gt;
FIM DO ARQUIVO cadastra.php
</pre>

<li>Vamos realizar uma pequena análise neste arquivo. Repare que os dados do
formulário serão enviados para o script "inserir.php", este, por conseguinte,
será o responsável pela inserção desta notícia no MySQL. Outro ponto, é que não
existem os campos <b>id</b>, <b>ver</b>, estes, como expliquei, serão inseridos
automaticamente pelo MySQL, e os campos <b>data</b>, <b>hora</b>, serão
inseridos pelo PHP.</li> <li>Agora é hora de criar o script PHP responsável por
isto tudo. Vamos nessa:</li>

<pre>
ARQUIVO inserir.php
&lt;?php

//Vamos definir as variáveis de data e hora
//para inserção no banco de dados

//Agora com as variáveis de data e hora criadas
//vamos criar uma variável especial para a querie sql

$sql = "INSERT INTO noticias (nome, sobrenome, cidade, estado, email, data, hora, 
titulo, subtitulo, texto) VALUES ('$nome', '$sobrenome', '$cidade', '$estado', 
'$email', '$data', '$hora', '$titulo', '$subtitulo', '$texto')";

//Agora é hora de contatar o mysql

$conexao = mysql_connect("localhost", "root", "root")
or die ("Configuração de Banco de Dados Errada!");

//Substitua os valores acima caso não esteje de acordo com sua máquina
//Selecionando o banco de dados...

$db = mysql_select_db("noticias")
or die ("Banco de Dados Inexistente!");

//Inserindo os dados

$sql = mysql_query($sql) 
or die ("Houve erro na gravação dos dados, por favor, clique em voltar e verifique os campos obrigatórios!");

echo "&lt;h1&gt;Cadastro efetuado com sucesso!&lt;/h1&gt;";

?&gt;
FIM DO ARQUIVO inserir.php

</pre>


<li>Você pode aperfeiçoar muito mais o script. Por exemplo, personalizar a
mensagem de erro e de êxito, inserir um link para cadastrar novamente, etc.</li>

<li>Agora vamos para o próximo e último passo, "Recuperando os dados
cadastrados"</li>


<p>&nbsp;</p>
<p>&nbsp;</p>
<h3>3.º Passo - Recuperando os dados cadastrados</h3>

<p>Irei mostrar como selecionar, por exemplo, as últimas 15 notícias inseridas
no MySQL; isto é muito útil, para sites que têm seções do tipo "Últimas
Notícias". Isto é feito com PHP novamente; faça conforme o exemplo abaixo, e
salve como um arquivo em PHP.

<pre>
ARQUIVO noticias.php
&lt;?php

//Vamos precisar contar o MySQL novamente

$conexao = mysql_connect("localhost","root","root");
$db = mysql_select_db("noticias");

//Agora é realizar a querie de busca no banco de dados

$sql = "SELECT * FROM noticias WHERE ver = 'on' ORDER BY id DESC LIMIT 15";

// Irá selecionar as últimas 15 notícias inseridas

// O curioso aqui, é que ele só irá selecionar os campos onde
// estiver o ver=on, isto foi discutido logo atrás, como um 
// controle de notícias pelo webmaster
// Por padrão o MySQL colocou off, mas o webmaster terá que 
// revisar as notícias e alterar o campo ver para as que quiser validar.

$resultado = mysql_query($sql)
or die ("Não foi possível realizar a consulta ao banco de dados");

// Agora iremos "pegar" cada campo da notícia
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

echo "&lt;b&gt;Código da Notícia&lt;/b&gt;: $id";
echo "&lt;br&gt;";
echo "Autor: $nome $sobrenome - ($email)";
echo "&lt;br&gt;";
echo "Cidade: $cidade - Estado: $estado";
echo "&lt;br&gt;";
echo "Data: $novadata - Horário: $novahora";
echo "&lt;br&gt;";
echo "Título da Notícia: $titulo";
echo "&lt;br&gt;";
echo "Subtítulo da Notícia: &lt;i&gt; $subtitulo &lt;/i&gt;";
echo "&lt;br&gt;";
echo "Notícia: $texto";
echo "&lt;br&gt;";
echo "Validado pelo Webmaster: ";
if ($ver=on) { echo "Sim"; } else { echo "Não"; }
echo "&lt;hr&gt;";

}

?&gt;
FIM DO ARQUIVO noticias.php
</pre>

<li>Viu como é super simples? Neste script criamos uma variável para cada campo
da tabela, assim fica mais fácil de manusear os dados de qualquer forma. Nas
variávels <b>novadata</b>, <b>novahora</b>, crie uma função para mostrar as
variáveis de uma forma melhor. (agradecimentos a RENAS - Amigão!)</li>

<li>Você ainda pode personalizar estas notícias, deixando o layout do seu
jeito!</li>

<li>OBS: para mostrar todas as notícias em vez de só as últimas 15, apenas
crie uma nova variável $sql, como esta abaixo:</li>

<pre>
$sql = "SELECT * FROM noticias WHERE ver = 'on' ORDER BY id DESC";
</pre>

<li>Pronto! Foi só retirar "LIMIT 15". ;)</li>


<p>&nbsp;</p>
<p>&nbsp;</p>
<h3>4.º Passo - Controle de Notícias para Webmaster</h3>

<p>Neste passo irei explicar como mostrar todos os dados da tabela, para
podermos modificá-los, apagá-los, etc. Primeiramente, devemos criar um arquivo
PHP para mostrar todos os dados na tela, para depois podermos manuseá-los. Faça
como o exemplo abaixo:

<pre>
ARQUIVO controle.php
&lt;?php

$conexao = mysql_connect("localhost","root","root");
$db = mysql_select_db("noticias");
$sql = "SELECT * FROM noticias ORDER BY id DESC";
$resultado = mysql_query($sql)
or die ("Não foi possível realizar a consulta ao banco de dados");

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
echo "&lt;th width=100&gt;Título:&lt;/th&gt;";
echo "&lt;th width=50&gt;Disponível?&lt;/th&gt;";
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

<p>O próximo passo agora é criar os arquivos <b>alterar.php</b> e
<b>excluir.php</b>, responsáveis pela alteração e exclusão dos dados. É muito
simples o código, veja só:

<pre>
ARQUIVO excluir.php
&lt;?php

$conexao = mysql_connect("localhost","root","root");
$db = mysql_select_db("noticias");
$sql = “DELETE FROM noticias WHERE id='$id'”;
$resultado = mysql_query($sql)
or die ("Não foi possível realizar a exclusão dos dados.");
echo “&lt;h1&gt;A notícia foi excluída com êxito!&lt;/h1&gt;”;

?&gt;
FIM DO ARQUIVO excluir.php

ARQUIVO alterar.php
&lt;?php

$conexao = mysql_connect("localhost","root","root");
$db = mysql_select_db("noticias");
$sql = "SELECT * FROM noticias WHERE id='$id'";
$resultado = mysql_query($sql)
or die ("Não foi possível realizar a consulta ao banco de dados");

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
echo "Código da Notícia: &lt;input name='id_novo' type='text' value='$id' size=20&gt;&lt;br&gt;";
echo "Data: $novadata&lt;br&gt;";
echo "Hora: $novahora&lt;br&gt;";
echo "Nome:&lt;input name='nome_novo' type='text' value='$nome' size=30&gt; *&lt;br&gt;";
echo "Sobrenome:&lt;input name='sobrenome_novo' type='text' value='$sobrenome' size=30&gt; *&lt;br&gt;";
echo "Cidade:&lt;input name='cidade_novo' type='text' value='$cidade' size=30&gt; *&lt;br&gt;";
echo "Estado:&lt;i&gt;(Exemplo: SP, RS, BA)&lt;/i&gt;&lt;input name='estado_novo' type='text' 
value='$estado' size=5&gt; *&lt;br&gt;";
echo "Email: &lt;i&gt;(Exemplo: feitosac@yahoo.com)&lt;/i&gt;&lt;input name='email_novo' type='text' 
value='$email' size=30&gt;&lt;br&gt;&lt;br&gt;";
echo "Título do Texto:&lt;input name='titulo_novo' type='text' value='$titulo' size=30&gt; *&lt;br&gt;";
echo "Subtítulo do Texto:&lt;textarea name='subtitulo_novo' rows=5 cols=30&gt;$subtitulo&lt;/textarea&gt;&lt;br&gt;";
echo "Texto:&lt;textarea name='texto_novo' rows=10 cols=30&gt;$texto&lt;/textarea&gt; *&lt;br&gt;";
echo "Disponibilizar? (on ou off): &lt;input name='ver_novo' type='text' value='$ver' size=5&gt;&lt;br&gt;";
echo "&lt;input type='submit' value='Alterar'&gt;";
echo "&lt;/form&gt;";
echo "&lt;br&gt;&lt;hr&gt;";
}

?&gt;
FIM DO ARQUIVO alterar.php
</pre>

<p>Agora basta criarmos o arquivo <b>alterar_db.php</b> que irá receber os dados
deste arquivo (alterar.php) e alterará seus respectivos dados no MySQL. É muito
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
or die ("Não foi possível realizar a consulta ao banco de dados");
echo "&lt;h1&gt;Notícia alterada com sucesso!&lt;/h1&gt;";

?&gt;
FIM DO ARQUIVO alterar_db.php
</pre>


<p>Finalmente, chegamos ao fim deste tutorial, que lhe ajudou a criar um
"Portal de Notícias baseado em PHP/MySQL". Queria, por fim, agradecer a
todos que me apoiaram, inclusive a um amigão, RENAS
(<a href="http://www.linuxfunciona.com.br" target="_blank">www.linuxfunciona.com.br</a>). Quer aprender mais sobre PHP? Leia, pesquise,
pratique! Assim você você vai poder se tornar um grande programador em PHP;
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

<li><a href="http://www.scriptbrasil.com" target="_blank">www.scripbrasil.com</a> - Notícias, Fórums, Scripts, etc.</li>

<li><a href="http://www.linuxfunciona.com.br" target="_blank">www.linuxfunciona.com.br</a> - Fórum de PHP e Linux.</li>

<li><a href="http://www.1001tutorials.com/php/index.shtml" target="_blank">www.1001tutorials.com/php/index.shtm</a> - Bons tutoriais sobre PHP</li>

<li><a href="http://www.mysql.com" target="_blank">www.mysql.com</a> - Site oficial do MySQL</li>

<li><a href="http://www.phpbuilder.com" target="_blank">www.phpbuilder.com</a> - Bom site para discussão entre programadores de PHP</li>

<li><a href="http://www.devshed.com target="_blank">www.devshed.com</a> - Tutoriais, artigos de revistas, etc.</li>

<li><a href="http://www.webmonkey.com" target="_blank">www.webmonkey.com</a> - Sites com matérias exclusivas sobre PHP</li>

</td>
</tr>
</table>



</BODY>
</HTML>
