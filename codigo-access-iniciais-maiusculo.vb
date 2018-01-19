
Attribute VB_Name = "Funcao15"
'por: HELIO CANDIDO

'A função, (de minha autoria), abaixo converte as iniciais de um texto
'em maiúsculo obedecendo as regras portuguesas

Public Function InicialMaiuscula(Nome As String) As String
       Dim Verificando As Boolean
       Dim i As Integer
       Dim ch As String
       Dim chespeciais As String
       Dim chespeciais1 As String
       Dim NomeReserva As String

       Nome = LCase(Nome)
       Verificando = True
       For i = 1 To Len(Nome)
           ch = Mid$(Nome, i, 1)
               If (ch >= "a" And ch <= "z") Or (ch >= "à" And ch <= "ü") Then
                   If Verificando = True Then
                       Mid$(Nome, i, 1) = UCase(ch)
                       Verificando = False
                   End If
               Else
                   Verificando = True
               End If
       Next i

       NomeReserva = Nome

       Verificando = True
       For i = 1 To Len(NomeReserva)
           ch = Mid$(NomeReserva, i, 4)
           chespeciais = Mid$(NomeReserva, i, 5)
           If (ch = " De " Or ch = " Di " Or ch = " Da " Or ch = " Do " Or ch = " Du ") Or _
           (chespeciais = " Das " Or chespeciais = " Du " Or chespeciais = " Dos ") Then
               If Verificando = True Then
                   Mid$(NomeReserva, i, 2) = LCase(ch)
                   Verificando = False
               End If
           Else
               Verificando = True
           End If
       Next i

       NomeReserva = NomeReserva

       Verificando = True
       For i = 1 To Len(NomeReserva)
           chespeciais1 = Mid$(NomeReserva, i, 3)
               If chespeciais1 = " E " Then
                   If Verificando = True Then
                       Mid$(NomeReserva, i, 2) = LCase(chespeciais1)
                       Verificando = False
                   End If
               Else
                   Verificando = True
               End If
       Next i

       InicialMaiuscula = NomeReserva
End Function

