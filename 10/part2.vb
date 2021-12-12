Imports System
Imports System.IO
Imports System.Collections.Generic

Module Part2

    Sub Main()
		Dim scores As List(Of Long) = New List(Of Long) ()
		' Dictionnaire associant les délimiteurs ouvrants à leur pendant fermant
		Dim chunksDelimiters = CreateObject("Scripting.Dictionary")
		chunksDelimiters("(") = ")"
		chunksDelimiters("[") = "]"
		chunksDelimiters("{") = "}"
		chunksDelimiters("<") = ">"
		' Dictionnaire pour les scores en fonction des erreurs de syntaxe
		Dim syntaxErrorScores = CreateObject("Scripting.Dictionary")
		syntaxErrorScores(")") = 1
		syntaxErrorScores("]") = 2
		syntaxErrorScores("}") = 3
		syntaxErrorScores(">") = 4
		' Récupération et traitement des lignes
		Dim reader as StreamReader = My.Computer.FileSystem.OpenTextFileReader("input.txt")
		Dim line as String = reader.ReadLine
		While line IsNot Nothing
			Dim corrupted As Boolean = False
			Dim startingDelimiters As List(Of String) = New List(Of String)()
			For Each character As String in line
				If chunksDelimiters.Exists(character)
					startingDelimiters.Add(character)
				ElseIf chunksDelimiters.Item(startingDelimiters(startingDelimiters.Count-1)) = character
					startingDelimiters.RemoveAt(startingDelimiters.Count-1)
				Else
					corrupted = True
					Exit For 'On s'arrête dès la première corruption trouvée
				End If
			Next
			If (Not corrupted) Then
				startingDelimiters.reverse()
				Dim score As Long = 0
				For Each startingDelimiter As String in startingDelimiters
					score = (score*5) + syntaxErrorScores.Item(chunksDelimiters.Item(startingDelimiter))
				Next
				scores.Add(score)
			End If
			line = reader.ReadLine
		End While
		reader.Close()
		' Détermination du gagnant
		scores.sort()
		Console.WriteLine("Score médian quant aux erreurs de syntaxe trouvées = {0}", scores(scores.Count/2))
    End Sub 
	
End Module