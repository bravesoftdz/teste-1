Function DVCPF(CPF As String) As String

'Rotina alterada por Dalvo Aragão Junior
'Data: 15/02/98
'Site: www.freeespace.com.br/sc/estoque

Dim lngSoma, lngInteiro As Long
Dim intNumero, intMais, I, intResto As Integer
Dim intDig1, intDig2 As Integer
Dim strDigVer, strcampo, strCaracter, StrConf As String
Dim dblDivisao As Double
lngSoma = 0
intNumero = 0
intMais = 0
strcampo = Left(CPF, 9)
strDigVer = Right(CPF, 2)
For I = 2 To 10
strCaracter = Right(strcampo, I - 1)
intNumero = Left(strCaracter, 1)
intMais = intNumero * I
lngSoma = lngSoma + intMais
Next I
dblDivisao = lngSoma / 11
lngInteiro = Int(dblDivisao) * 11
intResto = lngSoma - lngInteiro
If intResto = 0 Or intResto = 1 Then
intDig1 = 0
Else
intDig1 = 11 - intResto
End If
strcampo = strcampo & intDig1
lngSoma = 0
intNumero = 0
intMais = 0
For I = 2 To 11
strCaracter = Right(strcampo, I - 1)
intNumero = Left(strCaracter, 1)
intMais = intNumero * I
lngSoma = lngSoma + intMais
Next I
dblDivisao = lngSoma / 11
lngInteiro = Int(dblDivisao) * 11
intResto = lngSoma - lngInteiro
If intResto = 0 Or intResto = 1 Then
intDig2 = 0
Else
intDig2 = 11 - intResto
End If
StrConf = intDig1 & intDig2
DVCPF = StrConf

If DVCPF = strDigVer Then
MsgBox "CPF válido!", vbInformation
Else
MsgBox "CPF inválido", vbCritical
DoCmd.CancelEvent
End If

End Function