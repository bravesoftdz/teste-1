Attribute VB_Name = "ValidaCNPJ"
Option Compare Database   'Usar ordem do banco de dados para comparações
Function DVCNPJ(CGC As String) As String
Dim intSoma, intSoma1, intSoma2, intInteiro As Long
Dim intNumero, intMais, I, intResto As Integer
Dim intDig1, intDig2 As Integer
Dim strcampo, strCaracter, StrConf, strCGC, strDigVer As String
Dim dblDivisao As Double
intSoma = 0
intSoma1 = 0
intSoma2 = 0
intNumero = 0
intMais = 0
strDigVer = Right(CGC, 2)
strcampo = Left(CGC, 8)
strCGC = Right(CGC, 6)
strCGC = Left(strCGC, 4)
strcampo = Right(strcampo, 4) & strCGC
For I = 2 To 9
    strCaracter = Right(strcampo, I - 1)
    intNumero = Left(strCaracter, 1)
    intMais = intNumero * I
    intSoma1 = intSoma1 + intMais
Next I
strcampo = Left(CGC, 4)
For I = 2 To 5
    strCaracter = Right(strcampo, I - 1)
    intNumero = Left(strCaracter, 1)
    intMais = intNumero * I
    intSoma2 = intSoma2 + intMais
Next I
intSoma = intSoma1 + intSoma2
dblDivisao = intSoma / 11
intInteiro = Int(dblDivisao) * 11
intResto = intSoma - intInteiro
If intResto = 0 Or intResto = 1 Then
    intDig1 = 0
Else
    intDig1 = 11 - intResto
End If
intSoma = 0
intSoma1 = 0
intSoma2 = 0
intNumero = 0
intMais = 0
strcampo = Left(CGC, 8)
strCGC = Right(CGC, 6)
strCGC = Left(strCGC, 4)
strcampo = Right(strcampo, 3) & strCGC & intDig1
For I = 2 To 9
    strCaracter = Right(strcampo, I - 1)
    intNumero = Left(strCaracter, 1)
    intMais = intNumero * I
    intSoma1 = intSoma1 + intMais
Next I
strcampo = Left(CGC, 5)
For I = 2 To 6
    strCaracter = Right(strcampo, I - 1)
    intNumero = Left(strCaracter, 1)
    intMais = intNumero * I
    intSoma2 = intSoma2 + intMais
Next I
intSoma = intSoma1 + intSoma2
dblDivisao = intSoma / 11
intInteiro = Int(dblDivisao) * 11
intResto = intSoma - intInteiro
If intResto = 0 Or intResto = 1 Then
    intDig2 = 0
Else
    intDig2 = 11 - intResto
End If
StrConf = intDig1 & intDig2
DVCNPJ = StrConf
If DVCNPJ = strDigVer Then
MsgBox "CNPJ válido!", vbInformation
Else
MsgBox "CNPJ inválido", vbCritical
DoCmd.CancelEvent
End If
End Function
Function DVCPF(CPF As String) As String
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
